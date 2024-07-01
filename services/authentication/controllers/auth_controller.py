from fastapi import APIRouter, Request, Response
from models.auth import Auth
from services.auth_service import auth_service

auth_router = APIRouter(prefix="/auth")

@auth_router.post("/")
async def authenticate(auth: Auth):
    model = auth.model_dump_json(indent=2)
    auth_service.produce_message("authentication-dev", model)
    return model