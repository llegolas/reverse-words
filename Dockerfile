FROM golang:1.15.3
WORKDIR /go/src/github.com/llegolas/reverse-words/
COPY main.go .
RUN go get github.com/gorilla/mux && go get github.com/prometheus/client_golang/prometheus/promhttp
RUN CGO_ENABLED=0 GOOS=linux GO111MODULE=auto go build -a -installsuffix cgo -o main .

FROM scratch
COPY --from=0 /go/src/github.com/llegolas/reverse-words/main .
EXPOSE 8080
CMD ["/main"]
