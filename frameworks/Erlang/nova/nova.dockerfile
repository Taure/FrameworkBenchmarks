# Build stage 0
FROM erlang:25-alpine

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Copy our Erlang test application
COPY ./frameworks/Erlang/nova .
RUN apk add --update git
RUN rebar3 as prod release

# Build stage 1
FROM alpine

# Install some libs
RUN apk add --no-cache openssl && \
    apk add --no-cache ncurses-libs  && \
    apk add --no-cache libstdc++ && \
    apk add --no-cache libgcc

# Install the released application
COPY --from=0 /buildroot/_build/default/rel/nova_app /nova_app

EXPOSE 8080

CMD ["/nova_app/bin/nova_app", "foreground"]%