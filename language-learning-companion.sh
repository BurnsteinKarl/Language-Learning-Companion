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
        	languages=("Romance Languages" "Italian" "Spanish" "Portuguese")
	        learn_by_group "${languages[@]}"
        	repeat_session "${languages[@]}"
	        ;;
    	2)
        	languages=("Germanic Languages" "German" "Dutch" "Swedish")
	        learn_by_group "${languages[@]}"
	        repeat_session "${languages[@]}"
        	;;
    	3)
        	languages=("Slavic Languages" "Russian" "Polish" "Czech")
        	learn_by_group "${languages[@]}"
	        repeat_session "${languages[@]}"
        	;;
    	4)
	        languages=("Scandinavian Languages" "Danish" "Norwegian" "Swedish")
        	learn_by_group "${languages[@]}"
	        repeat_session "${languages[@]}"
        	;;
    	5)
	        languages=("East Asian Languages" "Mandarin Chinese" "Japanese" "Korean")
        	learn_by_group "${languages[@]}"
	        repeat_session "${languages[@]}"
        	;;
    	6)
	        languages=("Indo-Aryan Languages" "Hindi" "Bengali" "Punjabi")
        	learn_by_group "${languages[@]}"
	        repeat_session "${languages[@]}"
        	;;
    	*)
	        echo "Invalid choice. Please enter a number between 1 and 6."
        	;;
	esac
}

main_script
