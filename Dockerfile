FROM oven/bun:1.2-alpine

RUN bun add -g @quasar/cli

EXPOSE 4000

ENTRYPOINT ["/usr/local/bin/quasar"]

CMD ["-v"]