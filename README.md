# auto2

This project is an Urdu spell checker that takes user input in Urdu, checks the spelling against a dictionary on the frontend, and highlights incorrect words by underlining them in red. When the user long-clicks on a misspelled word, an API call is made to a Flask backend to provide the most probable suggestions. The suggestions are generated based on the closest match and the word's frequency in the language, providing the user with the optimal correction. If no suitable suggestion is found, the user has the option to add the word to the dictionary.

## Features

* Real-time Urdu spell checking: Automatically checks the spelling of words as the user types.
* Visual indication of errors: Misspelled words are underlined in red.
* Interactive correction suggestions: On long-clicking a misspelled word, suggestions are provided based on the closest match and frequency in the Urdu language.
* Custom dictionary management: Users can add new words to the dictionary if no suitable suggestion is found.

## Tech Stack
* Frontend: Flutter (Dart)
* Backend: Python (Flask)

## Usage
1. Input Urdu text: Start typing in Urdu. The app will automatically underline any misspelled words in red.

2. View suggestions: Long-click on a misspelled word to see a list of suggested corrections. The suggestions are ordered based on their match to the original word and their frequency in the Urdu language.

3. Correct or add words: Select a suggestion to correct the word or choose to add the word to your dictionary if it's not misspelled.

[![Watch the video](https://raw.githubusercontent.com/fixa-bit/spellcheck-suggestion/spell_checker_thumbnail.png)](https://raw.githubusercontent.com/fixa-bit/spellcheck-suggestion/demo.webm)




