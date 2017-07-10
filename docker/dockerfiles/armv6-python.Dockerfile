FROM alexellis2/python-arm:armv6

ADD ./app.py /code/
ADD ./requirements.txt /code/

WORKDIR /code

RUN pip install -r requirements.txt

CMD ["python", "app.py"]