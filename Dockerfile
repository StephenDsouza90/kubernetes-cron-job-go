# Build stage
FROM golang:1.20-alpine AS builder
WORKDIR /app
COPY cron_app.go .
RUN go build -o cron_app cron_app.go

# Runtime stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/cron_app .
CMD ["./cron_app"]