import os
import oci
from kink import di
from functools import wraps
from dopplersdk import DopplerSDK
from slack_sdk import WebClient


def main_injection(func):
    def extract_secret(secrets, name):
        return secrets.get(
            project="cloud-iac-main",
            config="prd",
            name=name,
        ).value["raw"]

    def generate_oci_config(selected_account, region, secrets):
        #  Retrieve account info from secrets
        user_id = extract_secret(secrets, f"OCI_{selected_account.upper()}_USER_OCID")
        tenancy_id = extract_secret(
            secrets, f"OCI_{selected_account.upper()}_TENANCY_OCID"
        )
        key_content = extract_secret(
            secrets, f"OCI_{selected_account.upper()}_PRIVATE_KEY"
        )
        fingerprint = extract_secret(
            secrets, f"OCI_{selected_account.upper()}_FINGERPRINT"
        )

        # Return the config
        return {
            "user": user_id,
            "key_content": key_content,
            "fingerprint": fingerprint,
            "tenancy": tenancy_id,
            "region": region,
        }

    @wraps(func)
    def wrapper(*args, **kwargs):
        # * DI for os variables
        di["DOPPLER_MAIN_TOKEN"] = os.environ["DOPPLER_MAIN_TOKEN"]
        di["SLACK_CHANNEL"] = os.environ["SLACK_CHANNEL"]
        di["OCI_ACCOUNT_NAME"] = os.environ["OCI_ACCOUNT_NAME"]
        di["REGION"] = os.environ["REGION"]

        # * Initialize Doppler secrets
        doppler = DopplerSDK()
        doppler.set_access_token(di["DOPPLER_MAIN_TOKEN"])
        di["secrets"] = doppler.secrets

        # * Slack Sdk
        di["slack_wc"] = WebClient(
            token=extract_secret(secrets=di["secrets"], name="SLACK_BOT_MAIN_TOKEN")
        )

        # OCI COnfigs

        di["COMPARTMENT_PRODUCTION_ID"] = extract_secret(
            di["secrets"],
            f"OCI_{di['OCI_ACCOUNT_NAME'].upper()}_COMPARTMENT_PRODUCTION_ID",
        )

        di["COMPUTE_KEY_PUBLIC"] = extract_secret(
            di["secrets"],
            f"OCI_{di['OCI_ACCOUNT_NAME'].upper()}_COMPUTE_KEY_PUBLIC",
        )

        # * Get the OCI config
        config = generate_oci_config(
            secrets=di["secrets"],
            selected_account=di["OCI_ACCOUNT_NAME"],
            region=di["REGION"],
        )

        # * Validate oci config
        oci.config.validate_config(config)

        di["config"] = config

        return func(*args, **kwargs)

    return wrapper
