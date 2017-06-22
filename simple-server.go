// Credit: Luke Kysow https://github.com/lkysow
package main

import (
	"fmt"
	"github.com/valyala/fasthttp"
)

func main() {
	fasthttp.ListenAndServe(":8080", fastHandler)
}

func fastHandler(ctx *fasthttp.RequestCtx) {
	fmt.Fprint(ctx, "OK")
}
