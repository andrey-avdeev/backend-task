import traceback
from typing import Optional, Dict, AnyStr, Any, List, Union

import secrets
from fastapi import FastAPI, Depends, HTTPException, status, Query
from fastapi.security import HTTPBasic, HTTPBasicCredentials

from task1.nest import main as nest

app = FastAPI()
security = HTTPBasic()

username, password = ('test', 'test')   # for speedup only; there is a lot of ways to hide hardcoded params


JSONObject = Dict[str, Any]
JSONArray = List[Any]
JSONStructure = Union[JSONArray, JSONObject]


def get_current_username(credentials: HTTPBasicCredentials = Depends(security)) -> str:
    correct_username = secrets.compare_digest(credentials.username, username)
    correct_password = secrets.compare_digest(credentials.password, password)
    if not (correct_username and correct_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Basic"},
        )
    return credentials.username


@app.get("/")
def root(current_username: str = Depends(get_current_username)):
    return f'I am up; hello {current_username}'


@app.post('/nest')
def nest_data(
        data: JSONStructure,
        current_username: str = Depends(get_current_username),
        nesting: Optional[str] = None,
):
    try:
        n = nesting.strip().split(',')
        result = nest(data, n)
        return (data, nesting, result)
    except Exception as e:
        return HTTPException(400, traceback.format_exc())
