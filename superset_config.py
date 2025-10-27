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

print("Configuring database connection...")
print(f"DB Host: {DATABASE_HOST}")
print(f"DB Port: {DATABASE_PORT}")
print(f"DB User: {DATABASE_USER}")
print(f"DB Name: {DATABASE_DB}")
SQLALCHEMY_DATABASE_URI = (
    f"{DATABASE_DIALECT}://{DATABASE_USER}:{DATABASE_PASSWORD}@"
    f"{DATABASE_HOST}:{DATABASE_PORT}/{DATABASE_DB}"
)

print(f"SQLALCHEMY_DATABASE_URI: {SQLALCHEMY_DATABASE_URI}")
# Ensure logs are initialized
STORE_LOGS_REMOTELY = True