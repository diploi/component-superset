import os

# Feature flags
FEATURE_FLAGS = {
    "ENABLE_TEMPLATE_PROCESSING": True,
}

# Flask configuration
ENABLE_PROXY_FIX = True

SECRET_KEY = os.environ.get("SECRET_KEY")

# Database configuration
DATABASE_DB=os.environ.get("DATABASE_DB")
DATABASE_HOST=os.environ.get("DATABASE_HOST")
DATABASE_PASSWORD=os.environ.get("DATABASE_PASSWORD")
DATABASE_USER=os.environ.get("DATABASE_USER")
DATABASE_PORT=os.environ.get("DATABASE_PORT")
DATABASE_DIALECT="postgresql"

# Ensure logs are initialized
STORE_LOGS_REMOTELY = True