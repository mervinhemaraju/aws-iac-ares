# > Imports
import logging
import smtplib
import ssl
import json
from kink import di
from di import main_injection
from email.message import EmailMessage
from utils.slack_blocks import block_error, block_message

# > Initialize Logging
logging.getLogger().setLevel(logging.INFO)


def post_to_slack(blocks, thread_ts=None, channel=None):
    response = di["slack_wc"].chat_postMessage(
        channel=di["SLACK_CHANNEL_MAIN"] if channel is None else channel,
        text=None,
        attachments=blocks,
        thread_ts=thread_ts,
    )
    return response, response["ts"]


def send_email(sender_email, subject, email_body):
    # * Create an EmailMessage object
    email_message = EmailMessage()

    # * Assign values to the email object
    email_message["From"] = sender_email
    email_message["To"] = di["RECEIVER_EMAIL"]
    email_message["Subject"] = subject
    email_message.set_content(email_body)

    # * Log to cloudwatch
    logging.info("Created email object with details")

    # * Log in and send the email
    with smtplib.SMTP_SSL(
        "smtp.gmail.com", 465, context=ssl.create_default_context()
    ) as smtp:
        # * Login to SMTP
        smtp.login(di["RECEIVER_EMAIL"], di["GMAIL_APP_PASSWORD"])

        # * Send the mail
        smtp.sendmail(
            di["RECEIVER_EMAIL"], di["RECEIVER_EMAIL"], email_message.as_string()
        )

    # * Log to cloudwatch
    logging.info("Mail sent succcessfully")


# > Main Functions
@main_injection
def main(event, context):
    try:
        # * Log to cloudwatch
        logging.info(f"email-function triggered with event: {event}")

        # * Verify ifthe the HTTP request type is POST
        if event["requestContext"]["http"]["method"] != "POST":
            return "Bad request", 400

        # * Reformat event
        event = json.loads(event["body"]) if "body" in event else event

        # * Get email details from event
        originator = event["originator"]
        sender_name = event["sender_name"]
        sender_email = event["sender_email"]
        email_body = event["email_body"]

        # * Log to Cloudwatch
        logging.info(f"originator: {originator}")
        logging.info(f"sender_name: {sender_name}")
        logging.info(f"sender_email: {sender_email}")
        logging.info(f"email_body: {email_body}")

        # * Define a subject
        subject = f"{originator} :: From {sender_name} :: To {sender_email}"

        # Send the email
        send_email(
            sender_email=sender_email,
            subject=subject,
            email_body=email_body,
        )

        # Post to slack
        post_to_slack(
            blocks=block_message(
                sender_email == sender_email,
                sender_name=sender_name,
                message=email_body,
            )
        )

        # * Log to cloudwatch
        logging.info("Posted to slack successfully")

        # * Return a message
        return "OK", 200

    except Exception as e:
        # * Log error
        logging.error(f"Error: {e}")

        # * Post alert to slack
        post_to_slack(blocks=block_error(str(e)), channel=di["SLACK_CHANNEL_ALERTS"])

        # * Return error
        return f"Internal server error: {str(e)}", 500
