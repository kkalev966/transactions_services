from fastapi import APIRouter, Request, Response
from models.transaction import Transaction
from services.transaction_service import transaction_service

transactions_router = APIRouter(prefix="/transactions")

@transactions_router.post("/")
async def create_transaction(transaction: Transaction):
    model = transaction.model_dump_json(indent=2)
    transaction_service.produce_message("transactions-dev", model)
    return model