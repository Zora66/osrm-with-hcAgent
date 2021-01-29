FROM golang:1.15-alpine AS build

WORKDIR /src/
COPY main.go go.* /src/
RUN export GOPATH=/src/
RUN go get git
RUN go get -u github.com/firstrow/tcp_server
RUN go get -u github.com/mackerelio/go-osstat/cpu
RUN CGO_ENABLED=0 go build -o /bin/haproxyHC


FROM osrm/osrm-backend:v5.23.0
COPY --from=build /bin/haproxyHC /bin/haproxyHC
EXPOSE 5000
EXPOSE 7777
