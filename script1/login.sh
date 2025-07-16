#!/bin/bash

case ${1,,} in 
	demba | administrator)
		echo "Oh, you're the boss here. Welcome!"
		;;
	help)
		echo "Just enter your username, duh!"
		;;
	*)
		echo "Hello there.You're not the boss of me. Enter a valid username!"
esac
