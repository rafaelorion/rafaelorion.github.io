FROM jekyll/jekyll:4.2.0

WORKDIR /blog

COPY --chown=jekyll:jekyll Gemfile .
COPY --chown=jekyll:jekyll Gemfile.lock .

COPY . .

RUN bundle install

CMD ["jekyll", "serve"]
