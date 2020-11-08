FROM golang:latest AS builder
COPY app.go .
COPY blockchain.html .
COPY openapi.yml .
WORKDIR /go

RUN go get -d -v \
    github.com/lib/pq \
    github.com/julienschmidt/httprouter

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o a.out

FROM scratch
COPY --from=builder /go .
COPY blockchain.html . 
COPY openapi.yml .
EXPOSE 8000

CMD ["./a.out"]
