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

a. Create a heap object inside the local process
b. Allocate some blocks of memory on the heap
c. Using UuidFromStringA, convert an array of UUID strings into its binary representation.
d. Using EnumSystemLocalesA, specify the pointer to the heap as a callback function, so it gets executed while EnumSystemLocalesA is running.


# Instructions:

Step 1: Generate payload using msfconsole for calc.exe (64bit)

>>> msfvenom -a x64 --platform windows -p windows/x64/exec cmd=calc.exe x64/alpha_mixed -f py

>>> uuid.txt

Step 2: Create python script (converter.py) to convert shellcode bytes into UUID strings

Step 3: Create VBA to load UUIDs into memory

>>> calc-popup.vba

# allocate mem, copy shellcode into mem, transfer execution to shellcode via abused function call

>>> python trigen.py "$(msfvenom -a x64 --platform windows -p windows/x64/exec cmd=calc.exe x64/alpha_mixed -f py)"

Step4: Load VBA into Word.docm with macros enabled

>>> Save and run the macro

>>> calc.exe will pop up

# Result
<img alt="Picture" src="https://github.com/m-aze/rebl-rebel/blob/main/t1204/materials/example2.gif" width="600"/>


# Resources:


https://research.nccgroup.com/2021/01/23/rift-analysing-a-lazarus-shellcode-execution-method/

http://ropgadget.com/posts/abusing_win_functions.html

https://github.com/karttoon/trigen

https://docs.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-enumsystemlocalesa

https://docs.microsoft.com/en-us/windows/win32/api/rpcdce/nf-rpcdce-uuidfromstringa

## Disclaimer
Content is for educational purposes only. Do not investigate individuals, websites, server, or a network, or conduct any illegal activities on any system you do not have permission to analyze. !
