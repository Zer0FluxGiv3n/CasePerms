#!/bin/bash

while getopts ":f:" opt; do
    case $opt in
        f) file="$OPTARG"
        ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit1
    ;;
esac

case $OPTARG in
    -*) echo "Option $opt needs a valid argument for file."
    exit 1
    ;;
esac
done

file_base=$(basename $file)
file_ext="${file##*.}"
new_file="${file_base%.*}"_cased."${file_ext}"
echo "[+] Will output results to $new_file"
if [[ -f $new_file ]]; then
    echo "[.] File $new_file already exists."
    read -p "[.] Do you want to overwrite? [y/n] . . . " confirm < /dev/tty
    confirm="${confirm,,}"
    if [[ "$confirm" == "y" ]]; then
    echo "[+] Deleting $new_file"
        rm $new_file
    elif [[ "$confirm" == "n" ]]; then
        echo "[+] Exiting"
        exit 0
    else
        echo "[+] Invlid response. Exiting."
        exit 1
    fi
fi

touch $new_file

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

cap_dot () {
	while read line_f; do
		echo "[+] Process line: $line_f"
		result=$(echo $line_f | sed 's/\.\([a-z]\)/.\U\1/g')
		result="${result^}"
        	echo $result >> $new_file
	done < $file
}

cap_first() {
	while read line_f; do
		echo "[+] Processing line: $line_f"
		echo "${line_f^}" >> $new_file
	done < $file
}

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

echo "[+] Completed processing file $file and output to new file: $new_file"
