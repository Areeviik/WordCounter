#! /bin/bash

args=("$@")
if [[ $# -eq 0 || $# -eq 1 ]];
then
	echo "Wrong number of arguments"
	echo "Program takes at least one argument: -f <filename>"
	echo "And three more optional arguments: [-w|-c|-l]"


else
	file=$2
	word_count=`wc -w < "$file"`
	char_count=`tr -d '[:space:]' < "$file" | wc -c`
	echo "Total words count: $word_count"
	echo "Total characters count: $char_count"

i=2
while [ $i -le $# ]
do
	l_flag=$false
	file=$2
	opt_w="-w"
	opt_c="-c"
	opt_l="-l"
	cur_arg=${args[${i}]}

	if [ "$cur_arg" = "$opt_w" ];
	then
		if [ $l_flag -eq $false]
		then
			w_flag=$true
			after_opt=$(( $i+1 ))
			search_word=${args[${after_opt}]}
			search_word_count=`grep "$search_word" "$file" | wc -l`
			echo "Occurence of word $search_word : $search_word_count"
		fi
	elif [ "$cur_arg" = "$opt_c" ];
	then
		if [ $l_flag -eq $false ]
		then
			c_flag=$true
			after_opt=$(( $i+1 ))
			search_char=${args[${after_opt}]}
			search_char_count=`grep "$search_char" "$file" | wc -l`
			echo "Occurence of character $search_char: $search_char_count"
		fi
	elif [ "$cur_arg" = "$opt_l" ];
	then
		l_flag=$true
		after_opt=$(( $i+1 ))
		output_file=${args[${after_opt}]}
		word_count=`wc -w < "$file"`
		char_count=`tr -d '[:space:]' < "$file" | wc -c`
		echo "Output was written in file named [$output_file]"
		`echo "Total words count: $word_count" >> "$output_file"`
		`echo "Total characters count: $char_count" >> "$output_file"`
		if [ $w_flag -eq $true]
		then
			`echo "Occurence of word $search_word : $search_word_count" >> "$output_file"`
		fi
		if [ $c_flag -eq $true]
		then
			`echo "Occurence of character $search_char: $search_char_count" >> "$output_file"`
		fi
	fi
	i=$(( $i+1 ))
done

fi
