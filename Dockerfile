FROM ubuntu
RUN echo "HTTP_PROXY=$HTTP_PROXY http_proxy=$http_proxy NO_PROXY=$NO_PROXY"
RUN apt-get update
RUN apt-get install -y autojump
