import json
import os
import urllib.request
from typing import Any


def handler(event: dict[str, Any], context: Any) -> dict[str, int]:
    webhook_url = os.environ["SLACK_WEBHOOK_URL"]

    disk_pct = event.get("disk_pct", "N/A")
    cpu_temp = event.get("cpu_temp", "N/A")
    ram_pct = event.get("ram_pct", "N/A")

    payload = {
        "text": (
            ":warning: *Pi Health Alert*\n"
            f"• Disk: *{disk_pct}%*\n"
            f"• CPU temp: *{cpu_temp}°C*\n"
            f"• RAM: *{ram_pct}%*"
        )
    }

    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        webhook_url,
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    with urllib.request.urlopen(req) as response:
        return {"statusCode": response.status}
