#! /bin/bash

args=("$@")
if [[ $# -eq 0 || $# -eq 1 ]];
then
	echo "Wrong number of arguments"
	echo "Program takes at least one argument: -f <filename>"
	echo "And three more optional arguments: [-w|-c|-l]"


else
	l_flag=0
	i=2
	file=$2
	while [ $i -le $# ]
	do
		opt_l="-l"
		opt_w="-w"
		opt_c="-c"
		cur_arg=${args[${i}]}
		if [ "$cur_arg" = "$opt_l" ]
		then
			l_flag=1
		elif [ "$cur_arg" = "$opt_w" ]; then
			w_flag=1
			after_opt_w=$(( $i+1 ))
			search_word=${args[${after_opt_w}]}
			search_word_count=`grep "$search_word" "$file" | wc -l`

		elif [ "$cur_arg" = "$opt_c" ]; then
			c_flag=1
			after_opt_c=$(( $i+1 ))
			search_char=${args[${after_opt_c}]}
			search_char_count=`grep "$search_char" "$file" | wc -l`
		fi
		i=$(( $i+1 ))
	done

	if [ $l_flag -eq 0 ]
	then
		word_count=`wc -w < "$file"`
		char_count=`tr -d '[:space:]' < "$file" | wc -c`
		echo "Total words count: $word_count"
		echo "Total characters count: $char_count"
	fi
	i=2
	while [ $i -le $# ]
	do
		cur_arg=${args[${i}]}

		if [ "$cur_arg" = "$opt_w" ];
		then
			w_flag=1
			if [ $l_flag -eq 0 ]
			then
				echo "Occurence of word $search_word : $search_word_count"
			fi
		elif [ "$cur_arg" = "$opt_c" ];
		then
			c_flag=1
			if [ "$l_flag" -eq 0 ]
			then
				echo "Occurence of character $search_char: $search_char_count"
			fi
		elif [ "$cur_arg" = "$opt_l" ];
		then
			l_flag=1
			after_opt=$(( $i+1 ))
			output_file=${args[${after_opt}]}
			word_count=`wc -w < "$file"`
			char_count=`tr -d '[:space:]' < "$file" | wc -c`
			echo "Output was written in file named [$output_file]"
			`echo "Total words count: $word_count" >> "$output_file"`
			`echo "Total characters count: $char_count" >> "$output_file"`
			if [ $w_flag ]
			then
				`echo "Occurence of word $search_word : $search_word_count" >> "$output_file"`
			fi
			if [ $c_flag ]
			then
				`echo "Occurence of character $search_char: $search_char_count" >> "$output_file"`
			fi
		fi
		i=$(( $i+1 ))
	done

	fi
