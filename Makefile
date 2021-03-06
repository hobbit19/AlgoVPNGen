IMAGE_NAME=algovpngen
PORT=8001
DEVPORT=8001

image.worker:
	docker build -t ${IMAGE_NAME}worker -f worker/Dockerfile .

run.worker:
	docker run --rm -e DO_REGION=${DO_REGION} -e DO_ACCESS_TOKEN=${DO_ACCESS_TOKEN} -e DO_SERVER_NAME="algotesting" -it ${IMAGE_NAME}worker

run.workerint:
	docker run --rm -e DO_REGION=${DO_REGION} -e DO_ACCESS_TOKEN=${DO_ACCESS_TOKEN} -e DO_SERVER_NAME="algotesting" -it ${IMAGE_NAME}worker /bin/bash

image.web:
	docker build --build-arg HTTP_PASSWD=${HTTP_PASSWD} --build-arg HEROKU_API_KEY=${HEROKU_API_KEY} -t ${IMAGE_NAME} -f app/Dockerfile .

run.web:
	docker run --rm -e PORT=8001 -p ${DEVPORT}:${PORT} -it ${IMAGE_NAME}

run.webint:
	docker run --rm -e PORT=${PORT} -p ${DEVPORT}:${PORT} -it ${IMAGE_NAME} /bin/bash

run: image.worker image.web run.web