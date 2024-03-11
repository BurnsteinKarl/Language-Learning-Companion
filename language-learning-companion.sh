#!/bin/bash

# Function to display the top 1000 words of a language
display_words() {
    echo "Displaying top 1000 words for $1:"
    cat "data/$1.txt"
}

# Function to learn languages by group
learn_by_group() {
    echo "You have chosen the $1 group. The languages in this group are:"
    for language in "${@:2}"
    do
        echo "$language"
        display_words "$language"
    done
}

# Main script
echo "Welcome to the Language Learning Companion!"
echo "Please choose a language group to learn:"
echo "1. Romance Languages Group"
echo "2. Germanic Languages Group"
echo "3. Slavic Languages Group"
echo "4. Scandinavian Languages Group"
echo "5. East Asian Languages Group"
echo "6. Indo-Aryan Languages Group"

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        learn_by_group "Romance Languages" "Italian" "Spanish" "Portuguese"
        ;;
    2)
        learn_by_group "Germanic Languages" "German" "Dutch" "Swedish"
        ;;
    3)
        learn_by_group "Slavic Languages" "Russian" "Polish" "Czech"
        ;;
    4)
        learn_by_group "Scandinavian Languages" "Danish" "Norwegian" "Swedish"
        ;;
    5)
        learn_by_group "East Asian Languages" "Mandarin Chinese" "Japanese" "Korean"
        ;;
    6)
        learn_by_group "Indo-Aryan Languages" "Hindi" "Bengali" "Punjabi"
        ;;
    *)
        echo "Invalid choice. Please enter a number between 1 and 6."
        ;;
esac