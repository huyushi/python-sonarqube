FROM my_flask_01

WORKDIR /app

ARG PIP_VERSION=22.1.2

COPY . .

RUN python3 -m pip install --upgrade pip==${PIP_VERSION} --no-cache-dir && pip3 install -r requirements.txt

RUN apt-get update && apt-get install -y --no-install-recommends wget unzip

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip \
    && unzip sonar-scanner-cli-4.6.2.2472-linux.zip \
    && rm sonar-scanner-cli-4.6.2.2472-linux.zip \
    && mv sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner

ENV PATH="/opt/sonar-scanner/bin:${PATH}"

RUN flake8 --exclude=venv* --ignore=E501 .

RUN pytest -s -v

RUN sonar-scanner -X  -Dsonar.host.url="http://10.212.43.107:9000/" \
                      -Dsonar.projectName="my_python" \
                      -Dsonar.projectKey="my_python" \
                      -Dsonar.python.coverage.reportPaths=coverage.xml \
                      -Dsonar.login="sqa_e39b00b929bcc2d5dcb1f36caefde32ad3a37c2b"
EXPOSE 5000

CMD ["python3", "app/view.py"]