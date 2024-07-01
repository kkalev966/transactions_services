import sys
import os

project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(project_root)

from fastapi import FastAPI
from controllers.transaction_controller import transactions_router


app: FastAPI = FastAPI()
app_v1_prefix: str = "/api/v1"

app.include_router(transactions_router, prefix=app_v1_prefix)