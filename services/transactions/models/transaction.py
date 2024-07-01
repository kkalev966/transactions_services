from pydantic import BaseModel, PositiveInt, Field
from enum import Enum

class Currencies(str, Enum):
    GBP = 'GBP'
    USD = 'USD'
    EUR = "EUR"

class Transaction(BaseModel):
    id: PositiveInt
    u_id: PositiveInt = Field(None, ge=1, le=10000)
    amount: float
    currency: Currencies

