
# > Initialize Logging
import logging
logging.getLogger().setLevel(logging.INFO)

# > Imports
import smtplib, ssl, os, json
from email.message import EmailMessage

# > Global variables
GMAIL_APP_PASSWORD = os.environ['GMAIL_APP_PASSWORD']
RECEIVER_EMAIL = os.environ['RECEIVER_EMAIL']

# > Main Functions
def main(event, context):

    # * Log to cloudwatch
    logging.info(f"email-function triggered with event: {event}")
    
    # * Verify ifthe the HTTP request type is POST
    if event['requestContext']['http']['method'] != "POST": return 'Bad request', 400

    # * Reformat event
    event = json.loads(event['body']) if 'body' in event else event

    # * Get email details from event
    originator = event['originator']
    sender_name = event['sender_name']
    sender_email = event['sender_email']
    email_body= event['email_body']

    # * Log to Cloudwatch
    logging.info(f"originator: {originator}")
    logging.info(f"sender_name: {sender_name}")
    logging.info(f"sender_email: {sender_email}")
    logging.info(f"email_body: {email_body}")

    # * Create an EmailMessage object
    email_message = EmailMessage()

    # * Assign values to the email object
    email_message['From'] = sender_email
    email_message['To'] = RECEIVER_EMAIL
    email_message['Subject'] = f"{originator} :: {sender_name} :: {sender_email}"
    email_message.set_content(email_body)

    # * Log to cloudwatch
    logging.info("Created email object with details")

    # * Log in and send the email
    with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=ssl.create_default_context()) as smtp:
        
        # * Login to SMTP
        smtp.login(RECEIVER_EMAIL, GMAIL_APP_PASSWORD)

        # * Send the mail
        smtp.sendmail(RECEIVER_EMAIL, RECEIVER_EMAIL, email_message.as_string())
    
    # * Log to cloudwatch
    logging.info("Mail sent succcessfully")

    # * Return a message
    return "OK", 200