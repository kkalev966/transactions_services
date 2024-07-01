from pydantic import BaseModel, PositiveInt, Field

class Auth(BaseModel):
    id: PositiveInt = Field(None, ge=1, le=10000)
    is_logged: bool
