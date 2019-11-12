# Argon2 for nim
A nim wrapper for the Argon2 password hashing library.

Outputs an object that contains the raw and encoded hashes.


Use the `--recursive` flag when cloning to pull in the submodule at the same time.  

Argon2 makes use of multiple threads, so the `--threads:on` flag must be used when compiling your project.  

Example usage:
---
```nim
import argon2

var output1 = argon2("i", "password", "somesalt", 2, 65536, 4, 24)
# Argon2 variant, password/data, salt, iterations, memory in KiB, threads used, hash length

echo output1.raw
echo "---"
echo output1.enc

echo "==="

var output2 = argon2("password", "somesalt")
# defaults to using Argon2id, 1 iteration, 4096 KiB memory, 1 thread, 32byte hash length

echo output2.raw
echo "---"
echo output2.enc
```
Output:
> @[69, 215, 172, 114, 231, 111, 36, 43, 32, 183, 123, 155, 249, 191, 157, 89, 21, 137, 78, 102, 154, 36, 230, 198]  
> \---  
> $argon2i$v=19$m=65536,t=2,p=4$c29tZXNhbHQ$RdescudvJCsgt3ub+b+dWRWJTmaaJObG  
> \===  
> @[200, 133, 183, 140, 168, 92, 227, 162, 96, 103, 113, 64, 114, 129, 132, 163, 10, 221, 234, 252, 143, 253, 100, 210, 203, 252, 20, 68, 64, 38, 151, 7]  
> \---  
> $argon2id$v=19$m=4096,t=1,p=1$c29tZXNhbHQ$yIW3jKhc46JgZ3FAcoGEowrd6vyP/WTSy/wUREAmlwc  

---

