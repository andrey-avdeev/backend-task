## Installation
0. make sure pwd is python/task2
1. `python -m venv venv`
2. `source ./venv/bin/activate`
3. `pip install -r requirements.txt`
4. run `uvicorn main:app`

## Usage
0. user and password hardcoded as test/test
1. available endpoints: `GET /`, `POST /nest`
2. nesting parameters available as query parameter `nesting=key1,key2`
3. send requests via curl like this: `curl -X POST 'http://user:pass@127.0.0.1:8000/nest?nesting=city,country' -d @task1/input.json -H 'Content-Type: application/json'`
