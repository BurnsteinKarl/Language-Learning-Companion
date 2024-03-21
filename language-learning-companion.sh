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

# Function to add a new language to a group
add_language() {
    read -p "Enter the name of the language you want to add: " new_language
    languages+=("$new_language")
    echo "$new_language has been added to the group."
}

# Function to remove a language from a group
remove_language() {
    read -p "Enter the name of the language you want to remove: " remove_language
    languages=("${languages[@]/$remove_language}")
    echo "$remove_language has been removed from the group."
}

# Function to repeat the learning session
repeat_session() {
    while true; do
        read -p "Do you want to repeat the session, choose another language group, add a new language, or remove a language? (repeat/choose/add/remove/exit): " decision
        case $decision in
            repeat)
                learn_by_group "$@"
                ;;
            choose)
                main_script
                ;;
            add)
                add_language
                ;;
            remove)
                remove_language
                ;;
            exit)
                echo "Exiting the Language Learning Companion. Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter 'repeat', 'choose', 'add', 'remove' or 'exit'."
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
            languages=("Romance Languages" "Italian" "Spanish" "Portuguese")
            ;;
        2)
            languages=("Germanic Languages" "German" "Dutch" "Swedish")
            ;;
        3)
            languages=("Slavic Languages" "Russian" "Polish" "Czech")
            ;;
        4)
            languages=("Scandinavian Languages" "Danish" "Norwegian" "Swedish")
            ;;
        5)
            languages=("East Asian Languages" "Mandarin Chinese" "Japanese" "Korean")
            ;;
        6)
            languages=("Indo-Aryan Languages" "Hindi" "Bengali" "Punjabi")
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 6."
            ;;
    esac

    learn_by_group "${languages[@]}"
    repeat_session "${languages[@]}"
}

main_script
