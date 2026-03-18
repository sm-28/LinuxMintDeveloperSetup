#!/usr/bin/env bash

python3 -m venv ~/workenv

source ~/workenv/bin/activate

pip install --upgrade pip

pip install \
numpy \
pandas \
scikit-learn \
matplotlib \
seaborn \
jupyter \
notebook \
ipykernel \
fastapi \
uvicorn \
pydantic \
sqlalchemy \
psycopg2-binary \
langchain \
transformers \
datasets \
sentence-transformers \
faiss-cpu