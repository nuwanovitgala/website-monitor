# Website Monitor

A lightweight Docker-based website monitoring tool that periodically captures website screenshots and sends them via SMTP email.

## Features

* Monitor multiple websites from a text file
* Process one website every 5 minutes
* Capture full-page screenshots using Puppeteer
* Optional page-load waiting time before capture
* SMTP email notifications
* Docker-ready deployment
* Suitable for uptime verification and visual monitoring

## Project Structure

* `websites.txt` - list of websites to monitor
* `screenshot.js` - captures screenshots
* `send_mail.py` - sends email notifications
* `run.sh` - monitoring loop
* `Dockerfile` - Docker image definition

## Requirements

* Docker
* SMTP server credentials

## Build

```bash
docker build -t website-monitor .
```

## Run

```bash
docker run -d \
  --name website-monitor \
  website-monitor
```

## Website List

Edit `websites.txt`:

```text
https://google.com
https://openai.com
https://github.com
```

## How It Works

1. Read website list
2. Select next website
3. Open website
4. Wait for page load
5. Capture screenshot
6. Send screenshot via SMTP
7. Wait 5 minutes
8. Repeat

## Future Improvements

* Telegram notifications
* WhatsApp integration
* SSL certificate expiry monitoring
* Website change detection
* Multiple screenshot formats
* Grafana integration
* Prometheus metrics

## License

MIT License
