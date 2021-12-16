FROM ruby:3.0

USER root

RUN apt-get update && \
    apt-get -y install build-essential

# Ta-Lib install
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzf ta-lib-0.4.0-src.tar.gz

WORKDIR /ta-lib

RUN ./configure LDFLAGS="-lm"
RUN make
RUN make install

RUN env ARCHFLAGS="-arch PLATFORM" gem install talib_ruby -- \
    --with-talib-include=/ta-lib/include  \
    --with-talib-lib=/ta-lib/lib

# Ruby
WORKDIR /app
COPY src .
