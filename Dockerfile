FROM node:20-bullseye

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    chromium \
    ca-certificates \
    fonts-liberation \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libxss1 \
    libasound2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN npm install puppeteer

RUN chmod +x run.sh

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

CMD ["./run.sh"]
