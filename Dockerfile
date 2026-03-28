FROM docker.io/alpine AS build
RUN apk add --no-cache build-base linux-headers
WORKDIR /usr/local/src/byedpi
COPY . .
RUN LDFLAGS=-static make

FROM docker.io/alpine AS ciadpi
RUN apk add --no-cache curl
COPY --from=build /usr/local/src/byedpi/ciadpi /bin/
ENTRYPOINT ["/bin/ciadpi"]
