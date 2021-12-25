FROM nginx:latest
# highly recommend you always pin versions for anything beyond dev/learn

WORKDIR /usr/share/nginx/html
# change working directory to root of nginx webhost
# using WORKDIR is preferred to using 'RUN cd /some/path'

COPY 3.index.html index.html
# copy source code from host into container-image

# I don't have to specify EXPOSE or CMD because they're in my FROM