provider "local" {

}

resource "local_file" "first" {
  filename = "temp.txt"
  content  = "this is first temp file"

}