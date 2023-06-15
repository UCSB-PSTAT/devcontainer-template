FROM docker.io/jupyter/minimal-notebook:x86_64-2023-03-06

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        tree zip \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

### Prints Jupyter server token when terminal is opened
RUN echo "echo \"Jupyter server token: \$(jupyter server list 2>&1 | grep -oP '(?<=token=)[[:alnum:]]*')\"" > ${HOME}/.get-jupyter-url.sh && \
    echo "sh \${HOME}/.get-jupyter-url.sh" >> ${HOME}/.bashrc

ENV GH_VERSION=2.30.0
RUN wget https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz -O - | tar xvzf - gh_${GH_VERSION}_linux_amd64/bin/gh --strip-components=2

RUN pip install copier==8.0.0
