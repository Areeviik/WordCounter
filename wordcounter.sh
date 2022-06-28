#! /bin/bash

args=("$@")
if [ $# -eq 0 ]
then
	echo "Wrong number of arguments"
	echo "Program takes at least one argument: filename"
	echo "And three more optional arguments: [-w|-c|-l]"

elif [ $# -eq 1 ]
then
	file=$1
	word_count=`wc -w < "$file"`
	char_count=`wc -c < "$file"`
	echo "Total words count: $word_count"
	echo "Total characters count: $char_count"
fi

i=1
while [ $i -le $# ]
do
	file=$1
	if [ ${args[${i}]}="-w" ]
	then
		after_opt=$(( $i+1 ))
		search_word=${args[${after_opt}]}
		search_word_count=`grep "$search_word" "$file" | wc -l`
		echo "Occurence of word $search_word : $search_word_count"

	elif [ ${args[${i}]}="-c" ]
	then
		after_opt=$(( $i+1 ))
		search_char=${args[${after_opt}]}
		search_char_count=`grep "$search_char" "$file" | wc -l`
		echo "Occurence of word $search_char: $search_char_count"
	fi
	
	i=$(( $i+1 ))
done


