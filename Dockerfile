FROM jekyll/jekyll:4.1.0
#FROM jekyll/jekyll:3.7


#COPY --chown=jekyll:jekyll Gemfile .
#COPY --chown=jekyll:jekyll Gemfile.lock .

#WORKDIR blog
COPY . .


#RUN gem install bundler -v 2
RUN bundle install

CMD ["jekyll", "serve"]
