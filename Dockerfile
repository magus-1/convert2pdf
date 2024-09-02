# Build stage
FROM python:3.12-slim AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends libreoffice unoconv && \
    rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

# Runtime stage
FROM python:3.12-slim

COPY --from=builder /usr/bin/unoconv /usr/bin/unoconv
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY app /app
WORKDIR /app

ENV PORT 8080
EXPOSE 8080

CMD exec python -m uvicorn api:app --host  0.0.0.0 --port 8080