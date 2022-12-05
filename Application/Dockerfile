FROM python:3.8-bullseye

WORKDIR /app

COPY ./app ./

ARG BUILD_DATE
ARG BUILD_VERSION

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt  

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
