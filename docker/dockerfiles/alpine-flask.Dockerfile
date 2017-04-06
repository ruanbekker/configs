FROM alpine:latest

RUN apk update \
  && apk add python \
  && apk add py2-pip\
  && pip install pip --upgrade

ADD ./app /app
WORKDIR /app
RUN pip install -r /app/requirements.txt

ENTRYPOINT ["python"]
CMD ["app.py"]

EXPOSE 5000