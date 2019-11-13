# Argon2 for nim
A nim wrapper for the Argon2 password hashing library.

Outputs an object that contains the raw and encoded hashes.

<br>

Argon2 makes use of multiple threads, so the `--threads:on` flag must be used when compiling your project.  

Use the `--recursive` flag when cloning manually to pull in the submodule at the same time (nimble does this automatically).  

Example usage:
---
### Detailed:
```nim
import argon2

var output1 = argon2("i", "password", "somesalt", 2, 65536, 4, 24)
# Argon2 variant, password/data, salt, iterations, memory in Bytes, threads used, hash length

echo output1.raw
echo "---"
echo output1.enc
```
Output:
> @[69, 215, 172, 114, 231, 111, 36, 43, 32, 183, 123, 155, 249, 191, 157, 89, 21, 137, 78, 102, 154, 36, 230, 198]  
> \---  
> $argon2i$v=19$m=65536,t=2,p=4$c29tZXNhbHQ$RdescudvJCsgt3ub+b+dWRWJTmaaJObG  

---
### Simplified:
```nim
import argon2

echo argon2("password", "somesalt").enc
# defaults to using Argon2id, 1 iteration, 4096 Bytes memory, 1 thread, 32byte hash length
```
Output:
> $argon2id$v=19$m=4096,t=1,p=1$c29tZXNhbHQ$yIW3jKhc46JgZ3FAcoGEowrd6vyP/WTSy/wUREAmlwc  

