FROM elixir:1.14.0
RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client && \
    apt-get clean
ADD / /api
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new
WORKDIR /api
RUN mix deps.get && \
    mix deps.compile

EXPOSE 4000
CMD ["./run.sh"]