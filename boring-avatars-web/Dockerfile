FROM ruby:3.3.5

RUN apt-get update && apt-get install -y redis-tools

RUN gem install sinatra -v 4.1.1
RUN gem install rackup -v 2.2.1
RUN gem install rerun -v 0.14.0
RUN gem install redis -v 5.4.0
RUN gem install puma -v 6.6

WORKDIR /app

COPY . .

CMD ["rerun", "ruby", "app.rb"]