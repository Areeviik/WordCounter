#! /bin/bash

args=("$@")
if [ $# -eq 0 ] | [ $# -eq 1 ];
then
	echo "Wrong number of arguments"
	echo "Program takes at least one argument: -f <filename>"
	echo "And three more optional arguments: [-w|-c|-l]"

elif [ $# -eq 2 ]
then
	file=$2
	word_count=`wc -w < "$file"`
	char_count=`wc -c < "$file"`
	echo "Total words count: $word_count"
	echo "Total characters count: $char_count"
fi

i=2
while [ $i -le $# ]
do
	file=$2
	opt_w="-w"
	opt_c="-c"
	opt_l="-l"
	cur_arg=${args[${i}]}

	if [ "$cur_arg" = "$opt_w" ];
	then
		after_opt=$(( $i+1 ))
		search_word=${args[${after_opt}]}
		search_word_count=`grep "$search_word" "$file" | wc -l`
		echo "Occurence of word $search_word : $search_word_count"
	
	elif [ "$cur_arg" = "$opt_c" ];
	then
		after_opt=$(( $i+1 ))
		search_char=${args[${after_opt}]}
		search_char_count=`grep "$search_char" "$file" | wc -l`
		echo "Occurence of word $search_char: $search_char_count"
	
	elif [ "$cur_arg" = "$opt_l" ];
	then
		after_opt=$(( $i+1 ))
		output_file=${args[${after_opt}]}
		word_count=`wc -w < "$file"`
		char_count=`wc -c < "$file"`
		echo "Output was written in file named [$output_file]"
		`echo "Total words count: $word_count" > "$output_file"`
		`echo "Total characters count: $char_count" > "$output_file"`
	fi
	i=$(( $i+1 ))
done


