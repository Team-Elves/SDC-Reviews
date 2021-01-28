#FROM node:latest I presume
#COPY . /someApp is a possibility here
#ADD . /someApp - is this the same as copy?
#WORKDIR /someApp - do I need this?
#RUN make / #whatever you name it
#EXPOSE some port # - do I need this?
#CMD ["node", "index.js"]????? many options here!

# slides in G Learn say "running 'docker build' in the directory with this Dockerfile will build a new image that will house our app.".... by "directory" I think they mean once you're on the "host_os$" or similar - the CLI INSIDE a Docker image?
# see more here: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/