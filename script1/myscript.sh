# comparison
# NUMBER1=30
# NUMBER2=4
# if [ $NUMBER1 -gt $NUMBER2 ]; then
#     echo "$NUMBER1 is greater than $NUMBER2"
# else
#     echo "$NUMBER1 is less than $NUMBER2"
# fi

# File Conditions
# FILE="test.txt"
# if [ -e $FILE ]; then
#     echo "$FILE exists"
# else
#     echo "$FILE does not exist"
# fi

# CASE STATEMENT
# read -p "Are you 21 or over? Y/N " ANSWER
# case "$ANSWER" in
#     [yY] | [yY][eE][sS])
#         echo "You can have a beer :)"
#         ;;
#     [nN] | [nN][oO])
#         echo "You can not have a beer"
#         ;;
#     *)
#         echo "Please enter y/yes or n/no"
# esac

# SIMPLE FOR LOOP
# NAMES="Demba Awa Fatou Cheick"
# for NAME in $NAMES
# do
#     echo "Hello $NAME"
# done

# FOR LOOP TO RENAME FILES
# FILES=$(ls *.txt)
# NEW="new"
# for FILE in $FILES
#     do
#         echo "Renaming $FILE to new-$FILE"
#         mv $FILE $NEW-$FILE
#     done

# WHILE LOOP - READ THROUGH A FILE LINE BY LINE
# LINE=1
# FILE="test.txt"
# while read -r CURRENT_LINE || [[ -n $CURRENT_LINE ]]; do
#     echo "$LINE: $CURRENT_LINE"
#     ((LINE++))
# done < "./new-1.txt"

# FUNCTION
# function say_hello() {
#     echo "Hello World!"
# }

# say_hello

# FUNCTION WITH PARAMETER
# function greet() {
#     echo "Hello, I am $1 and I'm $2 years old."
# }

# greet "Demba" "20"

# CREATE FOLDER AND WRITE TO A FILE
mkdir hello
touch "hello/world.txt"
echo "Hello World" >> "hello/world.txt"
echo "Created hello/world.txt"