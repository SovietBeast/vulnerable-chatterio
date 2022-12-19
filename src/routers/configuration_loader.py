import pickle
import os
from fastapi import (
    APIRouter, 
    Depends,
    File,
    UploadFile, 
    HTTPException,
    status
    )
from schemas.schemas import (
    Token, 
    User,
    GetUser
    )
from models.models import users
from utils.utils import (
    get_current_user, 
    hashPassword, 
    verifyPassword, 
    createAccessToken,
    TOKEN_EXPIRE_TIME
    )

from sqlalchemy import or_
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
from config.database import conn
from fastapi.responses import Response
from fastapi.security import OAuth2PasswordBearer

confRouter = APIRouter(
    prefix='/api/configuration',
    tags=["configuration"],
    dependencies=[Depends(get_current_user)]
)


@confRouter.post('/upload')
async def deserialize_picke_config_file(fs: UploadFile, token: str = Depends(OAuth2PasswordBearer(tokenUrl="api/login"))):
    user = await get_current_user(token)
    if user.username == 'admin':
        x = pickle.load(fs.file)
        return x
    else:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="You need admin privileges to load pickle configuration")