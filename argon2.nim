# Build Argon2 library
#
# Header files
{.passC: "-Iphc-winner-argon2/include".}
{.passC: "-Iphc-winner-argon2/src".}
# Source files
{.compile: "phc-winner-argon2/src/argon2.c".}
{.compile: "phc-winner-argon2/src/core.c".}
{.compile: "phc-winner-argon2/src/encoding.c".}
{.compile: "phc-winner-argon2/src/ref.c".}
{.compile: "phc-winner-argon2/src/thread.c".}
{.compile: "phc-winner-argon2/src/blake2/blake2b.c".}

# C functions
func c_argon2_encodedlen(
  iterations: uint32,
  memory: uint32,
  threads: uint32,
  saltlen: uint32,
  hashlen: uint32,
  argon2type: uint8
): cint {.header: "argon2.h", importc: "argon2_encodedlen".}

func c_argon2_hash(
  iterations: uint32,
  memory: uint32,
  threads: uint32,
  pwd: ptr uint8,
  pwdlen: uint32,
  salt: ptr uint8,
  saltlen: uint32,
  hash: ptr uint8,
  hashlen: uint32,
  encoded: ptr char,
  encodedlen: uint32,
  argon2type: uint8,
  version: uint32
): cint {.header: "argon2.h", importc: "argon2_hash".}

# nim functions
type hashes* = object
  enc*: string
  raw*: seq[byte]

func argon2*(
  argon2type: string,
  pwd: string,
  salt: string,
  iterations: uint32,
  memory: uint32,
  threads: uint32,
  hashlen: uint32
): hashes =
  var
    localpwd = pwd
    localsalt = salt
    encstr: string
    enclen: cint
    a2type: uint8
    rawseq = newSeq[byte](hashlen)

  case argon2type:
    of "d":
      a2type = 0
    of "i":
      a2type = 1
    of "id":
      a2type = 2
    else:
      raise newException(Exception, "Invalid Argon2 Type.  Valid Types: \"i\", \"d\", \"id\"")

  if pwd.len < 1:
    raise newException(Exception, "Provided password/data is empty")

  if salt.len < 8:
    raise newException(Exception, "Provided salt must be at least eight characters")

  if iterations < 1:
    raise newException(Exception, "Provided iterations must be greater than zero")

  if memory < 256:
    raise newException(Exception, "Provided memory must be at least 256 KiB")
  if memory > uint32.high:
    raise newException(Exception, "Provided memory exceeds 2^32 KiB")

  if threads < 1:
    raise newException(Exception, "Provided threads must be greater than one")

  if hashlen < 4:
    raise newException(Exception, "Provided hash length must be at least four")

  enclen = c_argon2_encodedlen(iterations, memory, threads, uint32(salt.len), hashlen, a2type)
  encstr = newstring(enclen)

  let ret = c_argon2_hash(
      iterations,
      memory,
      threads,
      cast[ptr uint8](addr localpwd[0]),
      uint32(pwd.len),
      cast[ptr uint8](addr localsalt[0]),
      uint32(salt.len),
      cast[ptr uint8](addr rawseq[0]),
      hashlen,
      cast[ptr char](addr encstr[0]),
      uint32(enclen),
      a2type,
      0x13
  )

  if ret == 0:
    result.enc = encstr
    result.raw = rawseq
  else:
    raise newException(Exception, "Argon2 library error " & $ret)

