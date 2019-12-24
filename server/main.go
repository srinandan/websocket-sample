package main

import (
	"fmt"
	"github.com/gorilla/websocket"
	"net/http"
)

var upgrader = websocket.Upgrader{}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "index.html")
	})

	http.HandleFunc("/v1/ws", func(w http.ResponseWriter, r *http.Request) {
		var conn, _ = upgrader.Upgrade(w, r, nil)
		go func(conn *websocket.Conn) {
			for {
				mType, msg, err := conn.ReadMessage()
				if err != nil {
					fmt.Println(err)
					conn.Close()
					break
				} else {
					fmt.Println("Received message: ", string(msg))
					reply := "Replying to: '" + string(msg) + "' with 'hello'"
					conn.WriteMessage(mType, []byte(reply))
				}
			}
		}(conn)
	})

	http.ListenAndServe(":3000", nil)
}
