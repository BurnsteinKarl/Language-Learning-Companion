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

# Function to display the number of words in a language file
display_word_count() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        word_count=$(wc -l < "data/$language.txt")
        echo "The $language file contains $word_count words."
    else
        echo "File for $language does not exist."
    fi
}

# Function to sort the words in a language file
sort_words() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        sort "data/$language.txt" -o "data/$language.txt"
        echo "The words in $language file have been sorted alphabetically."
    else
        echo "File for $language does not exist."
    fi
}

# Function to check if a word exists in all language files
check_word_in_all_languages() {
    read -p "Enter the word you want to check: " word
    for language in "${languages[@]}"; do
        if [ -f "data/$language.txt" ]; then
            if grep -q "$word" "data/$language.txt"; then
                echo "$word is in the top 1000 words of $language."
            else
                echo "$word is not in the top 1000 words of $language."
            fi
        else
            echo "File for $language does not exist."
        fi
    done
}

# Function to display the most common word in a language file
display_most_common_word() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        most_common_word=$(sort "data/$language.txt" | uniq -c | sort -nr | head -1)
        echo "The most common word in $language file is: $most_common_word."
    else
        echo "File for $language does not exist."
    fi
}

# Function to compare two language files and find common words
compare_languages() {
    read -p "Enter the name of the first language: " language1
    read -p "Enter the name of the second language: " language2
    if [ -f "data/$language1.txt" ] && [ -f "data/$language2.txt" ]; then
        echo "Common words in $language1 and $language2:"
        comm -12 <(sort "data/$language1.txt") <(sort "data/$language2.txt")
    else
        echo "One or both files for $language1 and $language2 do not exist."
    fi
}

# Function to display the least common word in a language file
display_least_common_word() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        least_common_word=$(sort "data/$language.txt" | uniq -c | sort -n | head -1)
        echo "The least common word in $language file is: $least_common_word."
    else
        echo "File for $language does not exist."
    fi
}
# Function to display the total number of unique words across all language files
display_total_unique_words() {
    total_unique_words=0
    for language in "${languages[@]}"; do
        if [ -f "data/$language.txt" ]; then
            unique_words=$(sort "data/$language.txt" | uniq | wc -l)
            total_unique_words=$((total_unique_words + unique_words))
        else
            echo "File for $language does not exist."
        fi
    done
    echo "The total number of unique words across all languages in the group is: $total_unique_words."
}
# Function to display the longest word in a language file
display_longest_word() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        longest_word=$(awk '{ if (length > max) {max = length; longest = $0} } END { print longest }' "data/$language.txt")
        echo "The longest word in $language file is: $longest_word."
    else
        echo "File for $language does not exist."
    fi
}

# Function to display the shortest word in a language file
display_shortest_word() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        shortest_word=$(awk '{ if (length < min || min == 0) {min = length; shortest = $0} } END { print shortest }' "data/$language.txt")
        echo "The shortest word in $language file is: $shortest_word."
    else
        echo "File for $language does not exist."
    fi
}
# Function to display the average word length in a language file
display_average_word_length() {
    read -p "Enter the name of the language: " language
    if [ -f "data/$language.txt" ]; then
        total_length=$(awk '{ total += length } END { print total }' "data/$language.txt")
        word_count=$(wc -l < "data/$language.txt")
        average_length=$(echo "scale=2; $total_length / $word_count" | bc)
        echo "The average word length in $language file is: $average_length."
    else
        echo "File for $language does not exist."
    fi
}

# Update the repeat_session function to include the new feature
repeat_session() {
    while true; do
        read -p "Do you want to repeat the session, choose another language group, add a new language, remove a language, list all languages, display top 10 words, display least common 10 words, search for a word, check a word in all languages, update words, restore a language file, sort words, display word count, display most common word, display least common word, compare two languages, display total unique words, display average word length, or exit? (repeat/choose/add/remove/list/top10/bottom10/search/checkall/update/restore/sort/count/mostcommon/leastcommon/compare/totalunique/averagelength/exit): " decision
        case $decision in
            averagelength)
                display_average_word_length
                ;;
            totalunique)
                display_total_unique_words
                ;;
            leastcommon)
                display_least_common_word
                ;;
            compare)
                compare_languages
                ;;
            mostcommon)
                display_most_common_word
                ;;
            checkall)
                check_word_in_all_languages
                ;;
            sort)
                sort_words
                ;;
            count)
                display_word_count
                ;;
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
