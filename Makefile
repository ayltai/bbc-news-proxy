DOCKER_OWNER = ayltai
DOCKER_REPO  = geekylifehacks
PRODUCT_NAME = bbc-news-proxy
VERSION      = 1.0.0

dev:
	python -m fastapi dev main.py --host=0.0.0.0

prod:
	uvicorn main:app --host=0.0.0.0

venv:
	python3 -m venv venv

reset: clean upgrade

clean:
	pip uninstall -y -r requirements.txt
	pip uninstall -y -r requirements.dev.txt

upgrade:
	pip install --upgrade pip wheel setuptools
	pip install --upgrade --upgrade-strategy eager --prefer-binary -e .[dev]

upgrade-prod:
	pip install --upgrade pip wheel setuptools
	pip install --upgrade --upgrade-strategy eager --prefer-binary -r requirements.txt

outdated:
	pip list --outdated

deploy: prune build publish

build:
	DOCKER_BUILDKIT=1 docker build --no-cache -t ${DOCKER_OWNER}/${DOCKER_REPO}:${PRODUCT_NAME}-${VERSION} .

docker:
	docker run -p 8000:8000 ${DOCKER_OWNER}/${DOCKER_REPO}:${PRODUCT_NAME}-${VERSION}

publish:
	docker push ${DOCKER_OWNER}/${DOCKER_REPO}:${PRODUCT_NAME}-${VERSION}

prune:
	docker image remove ${DOCKER_OWNER}/${DOCKER_REPO}:${PRODUCT_NAME}-${VERSION} || true
	docker system prune -f

