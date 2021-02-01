FROM golang:1.15-alpine AS build
RUN apk update && apk add git
RUN go get -u github.com/firstrow/tcp_server
RUN go get -u github.com/mackerelio/go-osstat/cpu
WORKDIR /src
COPY main.go go.* /src/
RUN CGO_ENABLED=0 go build -o /bin/haproxyHC


FROM osrm/osrm-backend:v5.24.0
COPY --from=build /bin/haproxyHC /bin/haproxyHC
EXPOSE 5000
EXPOSE 7777
