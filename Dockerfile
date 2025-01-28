FROM dfdsdk/prime-pipeline:latest

ENV POETRY_HOME=/etc/poetry

RUN apt update && \
    apt install -y python3.9-full libpq-dev postgresql-client

RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -

RUN echo 'export PATH="/etc/poetry/bin:$PATH"' >> /etc/bash.bashrc && \
    echo 'alias python=python3' >> /etc/bash.bashrc

RUN mkdir -p $HOME/.postgresql && \
    curl -L https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o $HOME/.postgresql/root.crt && \
    curl -LO https://www.amazontrust.com/repository/AmazonRootCA1.pem && \
    curl -LO https://www.amazontrust.com/repository/AmazonRootCA2.pem && \
    curl -LO https://www.amazontrust.com/repository/AmazonRootCA3.pem && \
    curl -LO https://www.amazontrust.com/repository/AmazonRootCA4.pem && \
    cat AmazonRootCA1.pem >> $HOME/.postgresql/root.crt && \
    cat AmazonRootCA2.pem >> $HOME/.postgresql/root.crt && \
    cat AmazonRootCA3.pem >> $HOME/.postgresql/root.crt && \
    cat AmazonRootCA4.pem >> $HOME/.postgresql/root.crt && \
    rm -f AmazonRootCA*.pem

CMD bash
