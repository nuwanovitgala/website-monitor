import smtplib
import ssl
import sys
from email.message import EmailMessage

smtp_server = "smtp.gmail.com"
smtp_port = 587

smtp_user = ""
smtp_pass = ""

to_email = ""

website = sys.argv[1]
image_file = sys.argv[2]

msg = EmailMessage()
msg["Subject"] = f"Website Screenshot - {website}"
msg["From"] = smtp_user
msg["To"] = to_email

msg.set_content(f"Screenshot captured for {website}")

with open(image_file, "rb") as f:
    img_data = f.read()

msg.add_attachment(
    img_data,
    maintype="image",
    subtype="png",
    filename=image_file
)

context = ssl.create_default_context()

with smtplib.SMTP(smtp_server, smtp_port) as server:
    server.starttls(context=context)
    server.login(smtp_user, smtp_pass)
    server.send_message(msg)

print("Email sent successfully")
