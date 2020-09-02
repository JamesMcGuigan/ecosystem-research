// Source: https://tour.golang.org/moretypes/18
// outputs base64 IMAGE:iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAIAAADT
// QUESTION: how do you export this image to a file?

package main

// $ go get "golang.org/x/tour/pic"
import "golang.org/x/tour/pic"

func Pic(dx, dy int) [][]uint8 {
	s := make([][]uint8, dy)
	for y := 0; y < dy; y++ {
		s[y] = make([]uint8, dx)
	}
	for y := 0; y < dy; y++ {
		for x := 0; x < dx; x++ {
			s[x][y] = uint8((x + y) / 2) // gradient
			s[x][y] = uint8(x * y)       // fractal
			s[x][y] = uint8(x ^ y)       // fractal - pretty
		}
	}
	return s
}

func main() {
	//print("<html><head/><body><img src='data:image/png:base64,")
	pic.Show(Pic)
	//print("'/></body></html>")
}
