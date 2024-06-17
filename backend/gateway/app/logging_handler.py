import logging
import requests

class APILoggingHandler(logging.Handler):
    def __init__(self, api_url):
        super().__init__()
        self.api_url = api_url

    def emit(self, record):
        log_entry = self.format(record)
        try:
            response = requests.post(self.api_url, json={"log": log_entry})
            response.raise_for_status()
        except requests.exceptions.RequestException as e:
            print(f"Failed to send log entry to API: {e}")
