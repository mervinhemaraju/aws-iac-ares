import os
from kink import di
from dopplersdk import DopplerSDK
from slack_sdk import WebClient
from functools import wraps
from utils.constants import (
    SECRETS_MAIN_PROJECT_NAME,
    SECRETS_MAIN_CONFIG,
    SECRETS_MAIN_SLACK_BOT_MAIN_TOKEN,
)


def main_injection(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        # * DI for os variables
        di["GMAIL_APP_PASSWORD"] = os.environ["GMAIL_APP_PASSWORD"]
        di["RECEIVER_EMAIL"] = os.environ["RECEIVER_EMAIL"]
        di["SLACK_CHANNEL_MAIN"] = os.environ["SLACK_CHANNEL_MAIN"]
        di["SLACK_CHANNEL_ALERTS"] = os.environ["SLACK_CHANNEL_ALERTS"]
        di["SECRETS_MAIN_TOKEN"] = os.environ["SECRETS_MAIN_TOKEN"]

        # * Secrets manager Doppler
        doppler = DopplerSDK()
        doppler.set_access_token(di["SECRETS_MAIN_TOKEN"])

        # * Get secrets
        secrets = doppler.secrets.get(
            project=SECRETS_MAIN_PROJECT_NAME,
            config=SECRETS_MAIN_CONFIG,
            name=SECRETS_MAIN_SLACK_BOT_MAIN_TOKEN,
        )

        # * Slack Sdk
        di["slack_wc"] = WebClient(token=secrets.value["raw"])

        return func(*args, **kwargs)

    return wrapper
