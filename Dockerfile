FROM golang:latest
COPY app.go .
COPY blockchain.html .
COPY openapi.yml .

RUN go get -d -v \
    github.com/lib/pq \
    github.com/julienschmidt/httprouter

RUN go build -o a.out

FROM alpine
EXPOSE 8000/tcp
