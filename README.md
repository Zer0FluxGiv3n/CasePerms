# CasePerms
Simple script to take a file, and do various capitalizations for the contents on each line of the file. Got tired of going back doing this manually when I had something like a list of usernames and/or potential passwords.

The script will first check if an output file exists of the format `<input file (minues extension)>_cased.<original input file extension>` i.e. `CasePerm.sh -f users.txt` will look for `users_cased.txt` in the current working directory.

If the output file exists, it will ask if you want to overwrite. If the output file doesn't exist, it creates a new one to write to.

The script will then ask what mode to capitalize in:
1. Just the first letter
2. The first letter and any letters after a period
3. All permutations of capital letters in the entire line. (This can take a while and will consume a decent amount of RAM, depending on the length of each input)

Finally, it will perform the capitalizations and output each result line-by-line to the output file specified.

Syntax:
`CasePerm.sh -f <inputfile>`

I'm a very amateur bash scripted, so don't judge my flawed code too hard!
