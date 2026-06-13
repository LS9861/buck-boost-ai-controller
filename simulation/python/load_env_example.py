"""
Example: How to load and use API keys from .env file
"""

import os
from dotenv import load_dotenv

# Load .env file from project root
# Adjust path if running from different directory
env_path = os.path.join(os.path.dirname(__file__), '..', '..', '.env')
load_dotenv(env_path)

# Now you can access your keys
api_key = os.getenv("DEEPSEEK_API_KEY")
base_url = os.getenv("DEEPSEEK_BASE_URL")

if api_key:
    print(f"✅ API key loaded from .env (length: {len(api_key)} characters)")
    print(f"   Base URL: {base_url}")
else:
    print("❌ API key not found. Check your .env file location.")

# Never print the actual key in production!
# print(f"Key: {api_key}")  # DON'T DO THIS