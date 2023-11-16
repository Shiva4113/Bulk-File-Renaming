function reverse_string() {
    local str="$1"
    local len=${#str}
    local reverse=""

    for ((i = len - 1; i >= 0; i--)); 
    do
        reverse="$reverse${str:i:1}"
    done

    echo "$reverse"
}

function find_file() {
    local dir="$1"
    local fn="$2"

    if [ ! -d "$dir" ]; 
    then
        echo "Directory does not exist. Exiting the application!"
        exit 253
    fi

    local result=$(find "$dir" -type f -name "$fn")
    local matches=$(find "$dir" -type f -name "$fn" | wc -l)


    if [ $matches -eq 0 ]; 
    then
        echo "There are $matches number of matches"
    else
        echo "There are $matches number of matches"
        echo "$result"
    fi
}

function rename_file() {
    local dir="$1"
    local ext="$2"
    find "$dir" -type f -name "$ext" | while read -r file; 
    do
        initial=$(basename "$file")
        final=$(dirname "$file")
        renamed="${final}/${initial%$ext}.pNg"
        mv "$file" "$renamed"
        echo "Changed: $file to $renamed"
    done
}

read USN PWD DIR
myUSN="PES2UG22CS525"
EXT="*.png"
reverse_PWD=$(reverse_string "$PWD")

if test "$USN" = "$myUSN"; 
then
    if test "$reverse_PWD" = "$USN"; 
    then
        echo "Username and Password are correct!"
        find_file "$DIR" "$EXT"
        rename_file "$DIR" "$EXT"
    else
        echo "Invalid password. Exiting the application"
        exit 255
    fi
else
    echo "Invalid USN. Exiting the application"
    exit 254
fi