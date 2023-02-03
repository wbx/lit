# Based from https://github.com/luvit/lit/blob/master/containers/lit-runtime/Dockerfile
FROM alpine AS build
RUN apk update && apk upgrade  &&\
    apk add cmake ninja git build-base openssl-dev curl  &&\
    git clone --recursive https://github.com/luvit/luvi.git /luvi
WORKDIR /luvi
ENV GENERATOR Ninja
RUN make regular-shared  &&\
    make test  &&\
    build/luvi -v || true
RUN curl -L https://github.com/wbx/lit/releases/latest/download/lit.zip -o lit.zip  &&\
    apk add libgcc --no-cache  &&\
    cp build/luvi build/lit && cat lit.zip >> build/lit && rm lit.zip  &&\
    build/lit make github://luvit/luvit build/luvit build/luvi

FROM alpine AS runtime
COPY --from=build /luvi/build/luvit /luvi/build/luvi /luvi/build/lit /usr/bin/
RUN apk add libgcc --no-cache

RUN luvit -v || true
RUN lit -v || true
WORKDIR /workdir
CMD ["ash"]
