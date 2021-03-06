# T1204 User Execution: Malicious File
<div align="center">
  <img alt="Picture" src="https://github.com/m-aze/rebl-rebel/blob/main/t1204/materials/example.gif" width="700"/>
</div>

# trigen.py
<img alt="Picture" src="https://github.com/m-aze/rebl-rebel/blob/main/t1204/materials/5f6f1f6a05a17e7397c6d7fe2fe44be2.png" width="600"/>

**Task: Modify the previous macro to emulate the Lazarus group. Use the Windows API to store shellcode as UUIDs (UuidFromStringA) and then run that shellcode (EnumSystemLocalesA). Again, this can be a simple test with calc or notepad. Upon success, a real payload will be provided. PtrSafe and LongPtr are key to getting this to work.**


**Generally, shellcode injection and execution follow these steps:**
1. Obtain a handle to a process (local or remote)
2. Allocate new region of memory to the process
3. Write/Move/Map shellcode to the newly allocated memory region
4. Execute the shellcode from the memory region using various methods

//

<ol>
<li> Create a heap object inside the local process </li>
<li> Allocate some blocks of memory on the heap </li>
<li> Using UuidFromStringA, convert an array of UUID strings into its binary representation </li>
<li> Using EnumSystemLocalesA, specify the pointer to the heap as a callback function, so it gets executed while EnumSystemLocalesA is running </li>
</ol>

# Instructions:

Step 1: Generate payload using msfconsole for calc.exe (64bit)

>>> msfvenom -a x64 --platform windows -p windows/x64/exec cmd=calc.exe x64/alpha_mixed -f py

>>> uuid.txt

Step 2: Create python script (converter.py) to convert shellcode bytes into UUID strings

Step 3: Create VBA to load UUIDs into memory

>>> calc-popup.vba

# Allocate and copy memory then execute to shellcode via abused function call

>>> python trigen.py "$(msfvenom -a x64 --platform windows -p windows/x64/exec cmd=calc.exe x64/alpha_mixed -f py)"

Step4: Load VBA into Word.docm with macros enabled

>>> Save and run the macro

>>> calc.exe will pop up

# Result
<div align="center">
<img alt="Picture" src="https://github.com/m-aze/rebl-rebel/blob/main/t1204/materials/example2.gif" width="600"/>
</div>

# Resources:


https://research.nccgroup.com/2021/01/23/rift-analysing-a-lazarus-shellcode-execution-method/

http://ropgadget.com/posts/abusing_win_functions.html

https://github.com/karttoon/trigen

https://docs.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-enumsystemlocalesa

https://docs.microsoft.com/en-us/windows/win32/api/rpcdce/nf-rpcdce-uuidfromstringa

## Disclaimer

The use of the application may be a criminal act, depending on the regulations of each country.

**The author of this document is not responsible in case criminal charges are brought against any individual or corporation using the tool against the stipulated laws, as well as for damages caused by a misuse of the tool. It is the responsibility of the end user to obey all applicable laws.**

It is recommended that use be limited to controlled environments and/or penetration testing with prior approval.
