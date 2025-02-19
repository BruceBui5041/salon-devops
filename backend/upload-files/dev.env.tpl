# service
REST_PORT=2888

# allow origins
ALLOW_ORIGINS=http://${EIP_PUBLIC_IP}:3000 http://${EIP_PRIVATE_IP}:3000 http://${ADMIN_PANEL_PRIVATE_IP}:3000

# DB
DB_USER=root
DB_PASSWORD=root
DB_HOST=${DB_PRIVATE_IP}
DB_PORT=3306
DB_NAME=salon_dev

# redis
REDIS_ADDR=redis:6379
REDIS_PASSWORD=

# dynamodb table name
DYNAMODB_VIDEO_TABLE_NAME=video_cache
DYNAMODB_USER_TABLE_NAME=salon_user_cache
DYNAMODB_ENROLLMENT_TABLE_NAME=enrolled_cache
# hours
DYNAMODB_USER_CACHE_TTL=24
DYNAMODB_VIDEO_CACHE_TTL=72
DYNAMODB_ENROLLMENT_CACHE_TTL=72


# video processor
VIDEO_PROCESSOR_ADDR=video-processor:50052

# JWT
JWT_SECRET=abc123

# logger
LOG_LEVEL=DEBUG

# cronjob (value is int and it as minute in the cronjob interval)
VIDEO_PROCESS_REQUEST_INTERVAL=1
COURSE_UPDATE_COUNTFIELD_INTERVAL=1

# BE request Processor to process video via this queue topic
REQ_PROCESS_VIDEO_TOPIC=study-platform-video-process-dev.fifo

# Processor update process video progress to BE via this queue topic
UPDATE_VIDEO_PROCESS_PROGRESS_TOPIC=study-platform-video-process-progress.fifo

# S3
AWS_PUBLIC_BUCKET=salon-dev-pub
AWS_PUBLIC_CLOUDFRONT=https://d3i048dqjftjb3.cloudfront.net

# AWS
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_REGION=ap-southeast-1
AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID}

#eSMS
OTP_SMS_REST_API=https://rest.esms.vn/MainService.svc/json/SendMultipleMessage_V4_post_json/
OTP_SMS_API_KEY=${OTP_SMS_API_KEY}
OTP_SMS_API_SECRET_KEY=${OTP_SMS_API_SECRET_KEY}
OTP_SMS_BRANDNAME=Baotrixemay
OTP_TTL=5 # minutes