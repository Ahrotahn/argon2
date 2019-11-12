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
  pwdlen: csize,
  salt: ptr uint8,
  saltlen: csize,
  hash: ptr uint8,
  hashlen: csize,
  encoded: ptr char,
  encodedlen: csize,
  argon2type: uint8,
  version: uint32
): cint {.header: "argon2.h", importc: "argon2_hash".}

# nim functions
