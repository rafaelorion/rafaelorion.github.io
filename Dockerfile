FROM jekyll/jekyll:4.2.0

WORKDIR /blog

COPY --chown=jekyll:jekyll Gemfile .
COPY --chown=jekyll:jekyll Gemfile.lock .

COPY . .

RUN chmod a+x /blog 
RUN bundle install


CMD ["jekyll", "serve"]

#COPY  /site /site

EXPOSE 4000