# CasePerms
Simple script to take a file, and do various capitalizations for the contents on each line of the file. Got tired of going back doing this manually when I had something like a list of usernames and/or potential passwords.

## Requirements
Requires the package `crunch` if you wish to do entire letter permutations.

## Info
The script will first check if you supplied an output file name:
- If you did not supply an output file name, it create a new output file with the format `<input file (minus extension)>_cased<input file extension>`. i.e. `-f users.txt` will be output to `users_cased.txt`

If you did supply and output file name, it will check if the file exists.
- If the output file exists, it will ask if you want to overwrite.
- If the output file doesn't exist, it creates a new one to write to.

The script will then ask what mode to capitalize in:
1. Just the first letter
2. The first letter and any letters after a period
3. All permutations of capital letters in the entire line. (This can take a while and will consume a decent amount of RAM, depending on the length of each input)

Finally, it will perform the capitalizations and output each result line-by-line to the output file specified.

I am very new to bash scripting, so don't judge my flawed code too hard! Always open to suggestions on how to improve, thanks!

## Usage
**General Syntax:**
`CasePerm.sh -f <inputfile> -o <output file>`

**First letter only:**
```
$ CasePerm.sh -f users.txt

[+] Outputting results to users_first_letter.txt
[.] How do you want to capitalize?
    [f] First letters of every line
    [d] First letters of every line, and after '.'
    [p] Complete permutation of all letters
[.] Mode:  f
[+] Capitalizing first letters only . . . 
[+] Processing line: user1
[+] Processing line: tom
[+] Processing line: administrator
[+] Processing line: calvin.hobbes
[+] Completed processing file users.txt and output to new file: users_first_letter.txt

$ cat users_first_letter.txt

User1
Tom
Administrator
Calvin.hobbes
```
**First letter and after period:**
```
$ CasePerm.sh -f users.txt -o users_period.txt

[+] Outputting results to users_cased.txt
[.] How do you want to capitalize?\n
    [f] First letters of every line\n
    [d] First letters of every line, and after '.'\n
    [p] Complete permutation of all letters\n
[.] Mode:  d
[+] Capitalizing all first characters, and characters after '.' . . . 
[+] Process line: user1
[+] Process line: tom
[+] Process line: administrator
[+] Process line: calvin.hobbes
[+] Completed processing file users.txt and output to new file: users_cased.txt

$ cat users_period.txt

User1
Tom
Administrator
Calvin.Hobbes
```
**Permutations of all letters:**
```
$ CasePerm.sh -f users.txt -o users_perm.txt

[+] Outputting results to users_perm.txt
[.] How do you want to capitalize?\n
    [f] First letters of every line\n
    [d] First letters of every line, and after '.'\n
    [p] Complete permutation of all letters\n
[.] Mode:  p
[+] Capitalizing complete permuation . . . 
[+] Processing line: ed.dy
Crunch will now generate the following amount of data: 192 bytes
0 MB
0 GB
0 TB
0 PB
Crunch will now generate the following number of lines: 32 
[+] Processing line: cal
Crunch will now generate the following amount of data: 32 bytes
0 MB
0 GB
0 TB
0 PB
Crunch will now generate the following number of lines: 8 
[+] Completed processing file users.txt and output to new file: users_perm.txt

$ cat users_perm.txt

ED.DY
ED.Dy
ED.dY
ED.dy
Ed.DY
Ed.Dy
Ed.dY
Ed.dy
eD.DY
eD.Dy
eD.dY
eD.dy
ed.DY
ed.Dy
ed.dY
ed.dy
CAL
CAl
CaL
Cal
cAL
cAl
caL
cal
```
