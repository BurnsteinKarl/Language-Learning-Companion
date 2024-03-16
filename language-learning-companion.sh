#!/bin/bash

# Function to display the top 1000 words of a language
display_words() {
    echo "Displaying top 1000 words for $1:"
    cat "data/$1.txt"
}

# Function to display a random word from the top 1000 words of a language
display_random_word() {
    echo "Displaying a random word for $1:"
    shuf -n 1 "data/$1.txt"
}

# Function to learn languages by group
learn_by_group() {
    echo "You have chosen the $1 group. The languages in this group are:"
    for language in "${@:2}"
    do
        echo "$language"
        display_words "$language"
        display_random_word "$language"
    done
}

# Function to repeat the learning session
repeat_session() {
    while true; do
        read -p "Do you want to repeat the session or choose another language group? (repeat/choose/exit): " decision
        case $decision in
            repeat)
                learn_by_group "$@"
                ;;
            choose)
                main_script
                ;;
            exit)
                echo "Exiting the Language Learning Companion. Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter 'repeat', 'choose' or 'exit'."
                ;;
        esac
    done
}

# Main script
main_script() {
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
            repeat_session "Romance Languages" "Italian" "Spanish" "Portuguese"
            ;;
        2)
            learn_by_group "Germanic Languages" "German" "Dutch" "Swedish"
            repeat_session "Germanic Languages" "German" "Dutch" "Swedish"
            ;;
        3)
            learn_by_group "Slavic Languages" "Russian" "Polish" "Czech"
            repeat_session "Slavic Languages" "Russian" "Polish" "Czech"
            ;;
        4)
            learn_by_group "Scandinavian Languages" "Danish" "Norwegian" "Swedish"
            repeat_session "Scandinavian Languages" "Danish" "Norwegian" "Swedish"
            ;;
        5)
            learn_by_group "East Asian Languages" "Mandarin Chinese" "Japanese" "Korean"
            repeat_session "East Asian Languages" "Mandarin Chinese" "Japanese" "Korean"
            ;;
        6)
            learn_by_group "Indo-Aryan Languages" "Hindi" "Bengali" "Punjabi"
            repeat_session "Indo-Aryan Languages" "Hindi" "Bengali" "Punjabi"
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 6."
            ;;
    esac
}

main_script
