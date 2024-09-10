# Stage 1: Build
FROM python:3.9

COPY . /app/

RUN pip3 install -r /app/requirements.txt

EXPOSE 9808

ENTRYPOINT ["python", "/app/cli.py"]
