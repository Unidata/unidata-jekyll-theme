# syntax=docker/dockerfile:1
FROM docker.io/ruby:3.4.8
EXPOSE 4000/tcp

ENV DOCS_UID=1000

WORKDIR /doc_bootstrap
COPY Gemfile .
RUN bundle install

COPY --chmod=700 entrypoint.sh /

WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-h"]
