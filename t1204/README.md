Task: Modify the previous macro to emulate the Lazarus group. Use the Windows API to store shellcode as UUIDs (UuidFromStringA) and then run that shellcode (EnumSystemLocalesA). Again, this can be a simple test with calc or notepad. Upon success, a real payload will be provided. PtrSafe and LongPtr are key to getting this to work.


What you will need:

1. Metasploit

2. Windows API understanding

3. Converter


Generally, shellcode injection and execution follow these steps:



1. Obtain a handle to a process (local or remote)

2. Allocate new region of memory to the process

3. Write/Move/Map shellcode to the newly allocated memory region

4. Execute the shellcode from the memory region using various methods

//

11. Create a heap object inside the local process

22. Allocate some blocks of memory on the heap

33. Using UuidFromStringA, convert an array of UUID strings into its binary representation. In this case, this "binary representation" is our shellcode.

44. Using EnumSystemLocalesA, specify the pointer to the heap as a callback function, so it gets executed while EnumSystemLocalesA is running.



Step 1: Generate payload using msfconsole for calc.exe (64bit)

>>> msfvenom -a x64 --platform windows -p windows/x64/exec cmd=calc.exe x64/alpha_mixed -f py

> uuid.txt


Step 2: Create python script (converter.py) to convert shellcode bytes into UUID strings



Step 3: Create VBA to load UUIDs into memory

# allocate mem, copy shellcode into mem, transfer execution to shellcode via abused function call

>>> python trigen.py "$(msfvenom -a x64 --platform windows -p windows/x64/exec cmd=calc.exe x64/alpha_mixed -f py)"


Step4: Load VBA into Word.docm with macros enabled
>>> Save and run the macro
>>> calc.exe will pop up
