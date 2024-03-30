#!/bin/bash

# Function to display the top 1000 words of a language
display_words() {
    if [ -f "data/$1.txt" ]; then
        echo "Displaying top 1000 words for $1:"
        cat "data/$1.txt"
    else
        echo "File for $1 does not exist."
    fi
}

# Function to display a random word from the top 1000 words of a language
display_random_word() {
    if [ -f "data/$1.txt" ]; then
        echo "Displaying a random word for $1:"
        shuf -n 1 "data/$1.txt"
    else
        echo "File for $1 does not exist."
    fi
}


# Function to add a new language to a group
add_language() {
    read -p "Enter the name of the language you want to add: " new_language
    if [ -f "data/$new_language.txt" ]; then
        if [[ " ${languages[@]} " =~ " ${new_language} " ]]; then
            echo "$new_language already exists in the group."
        else
            languages+=("$new_language")
            echo "$new_language has been added to the group."
        fi
    else
        echo "File for $new_language does not exist."
    fi
}

# Function to remove a language from a group
remove_language() {
    read -p "Enter the name of the language you want to remove: " remove_language
    if [[ " ${languages[@]} " =~ " ${remove_language} " ]]; then
        languages=("${languages[@]/$remove_language}")
        echo "$remove_language has been removed from the group."
    else
        echo "$remove_language does not exist in the group."
    fi
}

# Function to list all languages in the current group
list_languages() {
    echo "The current languages in the group are:"
    for language in "${languages[@]}"; do
        echo "$language"
    done
}

# Function to display the top 10 words of a language
display_top10_words() {
    if [ -f "data/$1.txt" ]; then
        echo "Displaying top 10 words for $1:"
        head -10 "data/$1.txt"
    else
        echo "File for $1 does not exist."
    fi
}

# Function to repeat the learning session
repeat_session() {
    while true; do
        read -p "Do you want to repeat the session, choose another language group, add a new language, remove a language, list all languages or display top 10 words? (repeat/choose/add/remove/list/top10/exit): " decision
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
            list)
                list_languages
                ;;
            top10)
                read -p "Enter the name of the language: " language
                display_top10_words "$language"
                ;;
            exit)
                echo "Exiting the Language Learning Companion. Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter 'repeat', 'choose', 'add', 'remove', 'list', 'top10' or 'exit'."
                ;;
        esac
    done
}

# Check if data directory exists, if not create it
check_data_dir() {
    if [ ! -d "data" ]; then
        mkdir "data"
        echo "Data directory created."
    fi
}

# Function to check if language files exist
check_language_files() {
    for language in "${languages[@]}"; do
        if [ ! -f "data/$language.txt" ]; then
            echo "File for $language does not exist. Removing from group."
            languages=("${languages[@]/$language}")
        fi
    done
}

# The main_script function
main_script() {
    check_data_dir
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

    check_language_files
    learn_by_group "${languages[@]}"
    repeat_session "${languages[@]}"
}

main_script
