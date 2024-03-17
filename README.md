# Language Learning Companion

This is a bash script that helps you learn languages by displaying the top 1000 words and a random word from a chosen language group. The script supports six language groups: Romance, Germanic, Slavic, Scandinavian, East Asian, and Indo-Aryan.

## How to Use

1. Run the script in your terminal.
2. You will be presented with a list of language groups to choose from. Enter the corresponding number of your choice.
3. The script will display the top 1000 words and a random word for each language in the chosen group.
4. After displaying the words, you will be asked if you want to repeat the session, choose another language group, or exit the script.

## Functions

- `display_words(language)`: This function displays the top 1000 words for the given language.
- `display_random_word(language)`: This function displays a random word from the top 1000 words of the given language.
- `learn_by_group(group, languages...)`: This function displays the top 1000 words and a random word for each language in the given group.
- `repeat_session(group, languages...)`: This function asks the user if they want to repeat the session, choose another language group, or exit the script.
- `main_script()`: This is the main function of the script. It welcomes the user and asks them to choose a language group.

## Requirements

- The script assumes that there are text files in the `data` directory for each language, named in the format `language.txt`, containing the top 1000 words for that language.
- The `shuf` command must be available on your system to display a random word.

## Note

This script does not provide translations for the words. It is intended to be used as a companion for language learning, not as a standalone language learning tool.
