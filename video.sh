#!/bin/bash
# shell script to use ffpmeg to create static videos for my podcast @sltmbncs.
if [ -z $1 ];then
	echo "To use this bullshit, you will need to pass the path to the file as variable"
	echo "./video.sh /path/to/file"
	echo "example of file"
	echo "audio1.mp3 thumbnail1.png"
	echo "audio2.mp3 thumbnail2.png"
	echo "audio3.mp3 thumbnail3.png"
	echo "this will return 3 videos with static images , 2fps of static image"
else
	[ -f error.txt ] | rm -rf error.txt
	[ -f copy.txt ] | rm -rf copy.txt
	file=$1
	while read line || [ -n "$line" ]; do
	  	var1=$(echo $line | cut -f1 -d ' ' )
	 	var2=$(echo $line | cut -f2 -d ' ' )
	 	var3=$(echo $var2 | cut -f1 -d '.' )
	 	echo $var1 $var2
	 	check1=1
	 	check2=1
	 	if [ ! -f $var1 ];then
	 		check1=0
	 		echo "audio not found in the path passed "$var1
	 		echo "audio not found in the path passed "$var1 >> error.txt
	 	fi
	 	if [ ! -f $var2 ];then
	 		check2=0
	 		echo "image not found in the path passed "$var2
	 		echo "image not found in the path passed "$var2 >> error.txt
	 	fi
	 	if [[ $check1 == 1 && $check2 == 1 ]];then
	 		echo "converting the mp3: "$var1
		 	echo "and the image: "$var2
		 	echo "in the video: "$var3".mp4"
		 	echo "--------------------"
		 	echo "ffmpeg -loop 1 -f image2 -r 2 -i $var2 -i $var1 -c:v libx264 -c:a copy -shortest $var3.mp4" 
		 	echo "ffmpeg -loop 1 -f image2 -r 2 -i $var2 -i $var1 -c:v libx264 -c:a copy -shortest $var3.mp4" >> copy.txt
		 	echo "--------------------"
		 	# ffmpeg -loop 1 -f image2 -r 2 -i $var2 -i $var1 -c:v libx264 -c:a copy -shortest $var3".mp4"
		 	echo "output path is the same folder of the image";
	 	else
	 		echo "couldn't create the video "$var3".mp4"
	 		echo "couldn't create the video "$var3".mp4" >> error.txt
	 	fi
	done < $file
fi

# ffmpeg -loop 1 -f image2 -r 2 -i Imagens/CapaPiloto.png -i 1devemosnospreocuparcomdragaovermelho.mp3 -c:v libx264 -c:a copy -shortest 1.mp4
# ffmpeg -loop 1 -f image2 -r 2 -i Imagens/CapaPiloto.png -i 1devemosnospreocuparcomdragaovermelho.mp3 -c:v libx264 -c:a copy -shortest output.mp4
