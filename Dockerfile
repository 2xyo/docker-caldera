FROM python:3.6-alpine


# Caldera dep
RUN apk update && apk upgrade && \
    apk add --no-cache --virtual .fetch-deps bash git build-base python3-dev libffi-dev wget ca-certificates openssl-dev && \ 
    mkdir /usr/src/app && \
    git clone --depth=1 https://github.com/mitre/caldera /usr/src/app/caldera && \
    pip install --no-cache-dir -r /usr/src/app/caldera/caldera/requirements.txt && \ 
    mkdir -p /usr/src/app/caldera/dep/crater/crater && \ 
    wget "https://github.com/mitre/caldera-crater/releases/download/v0.1.0/CraterMainWin7.exe" -O "/usr/src/app/caldera/dep/crater/crater/CraterMain.exe" && \
    rm -rf /var/cache/apk/*

# RUN printf "database:\n  host:mongcal" >> /usr/src/app/caldera/caldera/conf/settings.yaml.default
EXPOSE 8888
WORKDIR /usr/src/app/caldera/caldera
CMD [ "python3", "./caldera.py", "-d" ]

