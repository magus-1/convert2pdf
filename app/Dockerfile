# Build stage
FROM python:3.12-slim AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends libreoffice unoconv && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

# Runtime stage
FROM python:3.12-slim

COPY --from=builder /usr/bin/unoconv /usr/bin/unoconv
COPY . ./

ENV PORT 8000
EXPOSE 8000

CMD exec uvicorn api:app --host 0.0.0.0 --port 8000