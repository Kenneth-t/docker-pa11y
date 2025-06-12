# Pa11y Dashboard Docker Container
FROM --platform=linux/amd64 node:18-slim

LABEL maintainer="Rob Loach <robloach@gmail.com>"

# Install dependencies required by Headless Chrome
RUN apt-get update && apt-get install -y \
  gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
  libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
  libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
  libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 \
  build-essential libx11-dev libglib2.0-dev libgbm-dev \
  libnss3 lsb-release xdg-utils wget net-tools git --no-install-recommends && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment
ENV NODE_ENV=production

# Clone and install Pa11y Dashboard
RUN git clone https://github.com/pa11y/dashboard.git

WORKDIR /dashboard

RUN npm install

# Overwrite config AFTER npm install
COPY production.json ./config/production.json

EXPOSE 4000
EXPOSE 3000

# Start the app
CMD ["node", "."]