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
        read -p "Do you want to create a new file for $new_language? (y/n): " decision
        if [ "$decision" = "y" ]; then
            touch "data/$new_language.txt"
            echo "Enter the top 1000 words for $new_language, separated by new lines:"
            read -d '' -a words
            printf "%s\n" "${words[@]}" > "data/$new_language.txt"
            languages+=("$new_language")
            echo "$new_language has been added to the group."
        else
            echo "Not creating a new file for $new_language."
        fi
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

# Function to search for a specific word in a language file
search_word() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        read -p "Enter the word you want to search for: " word
        if grep -q "$word" "data/$language.txt"; then
            echo "$word is in the top 1000 words of $language."
        else
            echo "$word is not in the top 1000 words of $language."
        fi
    else
        echo "File for $language does not exist."
    fi
}

# Function to backup the language file before updating
backup_language_file() {
    if [ -f "data/$1.txt" ]; then
        cp "data/$1.txt" "data/$1_backup.txt"
        echo "Backup for $1 created."
    else
        echo "File for $1 does not exist."
    fi
}

# Function to update the top 1000 words of a language
update_words() {
    read -p "Enter the name of the language you want to update: " update_language
    if [ -f "data/$update_language.txt" ]; then
        backup_language_file "$update_language"
        echo "Enter the updated top 1000 words for $update_language, separated by new lines:"
        read -d '' -a words
        printf "%s\n" "${words[@]}" > "data/$update_language.txt"
        echo "The top 1000 words for $update_language have been updated."
    else
        echo "File for $update_language does not exist."
    fi
}

# Function to restore a language file from a backup
restore_language_file() {
    read -p "Enter the name of the language you want to restore: " restore_language
    if [ -f "data/$restore_language_backup.txt" ]; then
        cp "data/$restore_language_backup.txt" "data/$restore_language.txt"
        echo "Restored $restore_language from backup."
    else
        echo "Backup file for $restore_language does not exist."
    fi
}
# Function to display the least common 10 words of a language
display_bottom10_words() {
    if [ -f "data/$1.txt" ]; then
        echo "Displaying least common 10 words for $1:"
        tail -10 "data/$1.txt"
    else
        echo "File for $1 does not exist."
    fi
}

# Repeat_session function
repeat_session() {
    while true; do
        read -p "Do you want to repeat the session, choose another language group, add a new language, remove a language, list all languages, display top 10 words, display least common 10 words, search for a word, update words, or restore a language file? (repeat/choose/add/remove/list/top10/bottom10/search/update/restore/exit): " decision
        case $decision in
            bottom10)
                read -p "Enter the name of the language: " language
                display_bottom10_words "$language"
                ;;
            restore)
                restore_language_file
                ;;
            update)
                update_words
                ;;
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
            search)
                search_word
                ;;
            exit)
                echo "Exiting the Language Learning Companion. Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter 'repeat', 'choose', 'add', 'remove', 'list', 'top10', 'search' or 'exit'."
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
