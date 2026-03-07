from fastapi import FastAPI
from fastapi.responses import JSONResponse
import os

ENVIRONMENT = os.getenv("ENVIRONMENT", "dev").lower()

if ENVIRONMENT not in {"dev", "prod"}:
    raise RuntimeError(f"Invalid ENVIRONMENT: {ENVIRONMENT}")

app = FastAPI(
    title="Example Backend",
    version="1.0.0",
    docs_url="/docs" if ENVIRONMENT != "prod" else None,
    redoc_url="/redoc" if ENVIRONMENT != "prod" else None,
    openapi_url="/openapi.json" if ENVIRONMENT != "prod" else None,
)

@app.get("/health")
def health_check():
  return {"status": "ok"}

@app.get("/")
def read_root():
  return JSONResponse(
    content={
      "message": "Hello from FastAPI",
      "environment": ENVIRONMENT
    }
  )
