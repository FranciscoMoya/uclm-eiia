FROM ubuntu:latest
MAINTAINER Francisco Moya "francisco.moya@uclm.es"

RUN apt-get update -y && apt-get install -y python3-pip python3-dev

COPY py/requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY py /app

ENTRYPOINT [ "python3" ]
CMD [ "eii.py" ]

