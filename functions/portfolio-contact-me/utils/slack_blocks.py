VALUE_COLOR_NEGATIVE = "#ff7b7b"
VALUE_COLOR_STATEMENT = "#ffac5a"


def block_message(sender_name, sender_email, message):
    return [
        {
            "color": VALUE_COLOR_STATEMENT,
            "blocks": [
                {
                    "type": "section",
                    "fields": [
                        {
                            "type": "mrkdwn",
                            "text": f"A message was sent by `{sender_name}` from your portfolio.",
                        }
                    ],
                },
                {
                    "type": "section",
                    "fields": [
                        {
                            "type": "mrkdwn",
                            "text": f"Email: {sender_email}",
                        }
                    ],
                },
                {
                    "type": "section",
                    "fields": [
                        {
                            "type": "mrkdwn",
                            "text": f"```{message}```",
                        }
                    ],
                },
            ],
        }
    ]


def block_error(error_message):
    return [
        {
            "color": VALUE_COLOR_NEGATIVE,
            "blocks": [
                {
                    "type": "section",
                    "fields": [
                        {"type": "mrkdwn", "text": f"*Error:*\n{error_message}"}
                    ],
                },
            ],
        }
    ]
