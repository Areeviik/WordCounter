#! /bin/bash

if [ $#==0 ]
then
	echo "Wrong number of arguments"
	echo "Program takes at least one argument: filename"
	echo "And three more optional arguments: [-w|-c|-l]"

fi
if [ $#==1 ]
then
	file=$1
	word_count=`wc -w < $file`
	char_count=`wc -c < $file`
	echo "Total words count: $word_count"
	echo "Total characters count: $char_count"
fi
