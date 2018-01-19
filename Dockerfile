FROM python:2.7-slim

WORKDIR /tmp/ectou-metadata
ADD . /tmp/ectou-metadata
RUN python ./setup.py install

ENTRYPOINT ["ectou_metadata"]
