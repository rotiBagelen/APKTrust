FROM ubuntu:latest

WORKDIR /app

RUN apt update && apt install -y \
    python3 python3-pip curl xz-utils ca-certificates git && \
    update-ca-certificates

RUN curl -fsSL "https://nodejs.org/dist/v20.19.0/node-v20.19.0-linux-x64.tar.xz" -o node.tar.xz \
    && tar -xf node.tar.xz \
    && mv node-v20.19.0-linux-x64 /usr/local/node \
    && ln -s /usr/local/node/bin/node /usr/local/bin/node \
    && ln -s /usr/local/node/bin/npm /usr/local/bin/npm \
    && ln -s /usr/local/node/bin/npx /usr/local/bin/npx \
    && rm node.tar.xz

RUN node -v && npm -v

COPY requirements.txt .

RUN pip3 install --break-system-packages -r requirements.txt

COPY . .

RUN cd "FRONTEND PMLD REVISED/AUTOPENTEST" \
    && npm install \
    && npm run build

EXPOSE 5000

CMD ["python3", "app.py"]

