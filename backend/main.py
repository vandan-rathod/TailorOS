from fastapi import FastAPI
from pydantic import BaseModel
from backend.api.auth import AuthManager

app=FastAPI()

class LoginRequest(BaseModel):
    username:str
    password:str

@app.get("/")

def home():
    return {"message":"Tailoring backend Running"}

@app.post("/login")
def login(data: LoginRequest):
    auth=AuthManager()

    result=auth.login(
        data.username,
        data.password
    )

    return {"success": result}