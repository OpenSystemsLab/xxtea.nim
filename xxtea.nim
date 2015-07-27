{.compile: "libxxtea.c".}

import base64

proc encrypt*(data: cstring, length: csize, key: cstring, outLen: ptr int): cstring {.cdecl, importc: "xxtea_encrypt", header: "../libxxtea.h".}
  ## Low-level wrapper for xxtea_encrypt function
proc decrypt*(data: cstring, length: csize, key: cstring, outLen: ptr int): cstring {.cdecl, importc: "xxtea_decrypt", header: "../libxxtea.h".}
  ## Low-level wrapper for xxtea_decrypt function

proc encrypt*(data, key: string): string {.inline.} =
  ## High-level xxtea encrypt function
  ##
  ## return a base64 encoded string
  var o: int
  result = base64.encode($encrypt(data.cstring, data.len, key.cstring, addr o))


proc decrypt*(data, key: string): string {.inline.} =
  ## High-level xxtea decrypt function
  ##
  ## data must be a base64 encoded
  var o: int
  var data = base64.decode(data)
  result = $decrypt(data, data.len, key.cstring, addr o)

when isMainModule:
  var msg ="Welcome to Nim wrapper for XXTEA"
  var key = "1234567890123456"

  var encrypted = encrypt(msg, key)
  assert "jJi5dh7tWVIw5w2JhrkYOs36636CiIbiHHv0Q8Jyr02zR09K" == encrypted
  assert msg == decrypt(encrypted, key)
