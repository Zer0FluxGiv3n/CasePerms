#!/bin/bash

#
# Description: A simple bash script to capitalize various letters from each line of a file.
# Author: ZeroFluxGiven
# Date 2024-12-31
#


# Get arguments from user and assign if they exist.
file=false
new_file=false

while getopts ":f:o:" opt; do
   case $opt in
        f) file="$OPTARG"
        ;;
        o) new_file="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        exit 1
        ;;
        *) echo "[-] Error parsing command line inputs. Exiting."
        exit 1
        ;;
    esac

done

# Check if user supplied an input file.
if [[ $file = false ]]; then
   echo "[-] No input file specified. Exiting."
   exit 1
fi

# Check if the input file even exists
if [[ ! -f $file ]]; then
    echo "[-] Input file: $file does not exist. Exiting. "
    exit 1
fi

# If the user did not supply an output filename, create one from the input file.
if [[ $new_file = false  ]]; then
    file_base=$(basename $file)
    file_ext="${file##*.}"
    new_file="${file_base%.*}"_cased."${file_ext}"
fi

echo "[+] Outputting results to $new_file"

# Check if the output file exists. If it does, prompt the user to overwrite.
if [[ -f $new_file ]]; then
    echo "[.] File $new_file already exists."
    read -p "[.] Do you want to overwrite? [y/n] . . . " confirm < /dev/tty
    confirm="${confirm,,}"
    if [[ "$confirm" == "y" ]]; then
    echo "[+] Deleting $new_file"
        rm $new_file
    elif [[ "$confirm" == "n" ]]; then
        echo "[+] Exiting."
        exit 0
    else
        echo "[+] Invlid response. Exiting."
        exit 1
    fi
fi

touch $new_file

# Function to Capitalize all letters, in every permutation
cap_all () {
while read line_f; do
    echo "[+] Processing line: $line_f"
    map=$(crunch ${#line_f} ${#line_f} 10) > /dev/null 
    while read -r line; do
        result=""
        for (( i=0; i<${#line_f}; i++ )); do
            if [[ "${line:$i:1}" == "1" ]]; then
                char="${line_f:$i:1}"
                if [[ "$char" =~ [a-z] ]]; then
                    result+="${char^}"
                else
                    result+="$char"
                fi
            else
                result+="${line_f:$i:1}"
            fi
        done
	if ! grep -q "$result" "$new_file"; then
            echo $result >> "$new_file"
	fi
    done <<< $map
done < $file
}

# Function to capitalize onle the first letter of each line, and letters that come after periods.
cap_dot () {
	while read line_f; do
		echo "[+] Process line: $line_f"
		result=$(echo $line_f | sed 's/\.\([a-z]\)/.\U\1/g')
		result="${result^}"
        	echo $result >> $new_file
	done < $file
}

# Function to capitalize just the first letter
cap_first() {
	while read line_f; do
		echo "[+] Processing line: $line_f"
		echo "${line_f^}" >> $new_file
	done < $file
}

# Prompt user for capitalization option
read -p "[.] How do you want to capitalize?\n
    [f] First letters of every line\n
    [d] First letters of every line, and after '.'\n
    [p] Complete permutation of all letters\n
[.] Mode:  " mode < /dev/tty

case $mode in
	[pP]* ) echo "[+] Capitalizing complete permuation . . . "
		cap_all ;;
	[fF]* ) echo "[+] Capitalizing first letters only . . . "
		cap_first ;;
	[dD]* ) echo "[+] Capitalizing all first characters, and characters after '.' . . . "
		cap_dot ;;
	* ) echo "[+] No option selected, exiting."
		exit 0;;
esac

echo "[+] Completed processing file $file and output to new file: $new_file