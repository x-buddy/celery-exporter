# Stage 1: Build
FROM python:3.9

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY . /app/

pip install -r /app/requirements.txt

EXPOSE 9808

ENTRYPOINT ["python", "/app/cli.py"]
