ARG MOVIEPILOT_VERSION

FROM jxxghp/moviepilot-v2:${MOVIEPILOT_VERSION} AS base

ARG P115STRMHELPER_VERSION

RUN curl -sL "https://github.com/DDS-Derek/MoviePilot-Plugins/archive/refs/heads/main.zip" | busybox unzip -d /tmp - && \
    mv -f /tmp/MoviePilot-Plugins-main/plugins.v2/* /app/app/plugins/ && \
    rm -rf /app/app/plugins/p115strmhelper && \
    curl -sL "https://github.com/DDS-Derek/MoviePilot-Plugins/releases/download/P115StrmHelper_v${P115STRMHELPER_VERSION}/p115strmhelper_v${P115STRMHELPER_VERSION}.zip" | busybox unzip -d /app/app/plugins - && \
    umask 000 && \
    ${VENV_PATH}/bin/pip install -r /app/app/plugins/p115strmhelper/requirements.txt && \
    umask 022 && \
    rm -f /app/app/plugins/p115strmhelper/requirements.txt && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    ${HOME}/.cache

COPY --chmod=755 entrypoint.sh /entrypoint.sh
