# Translator


Recursively searches through a folder and translates all Chinese Characters to
English using the Google Translate API. You will need an API Key for this to 
work...

This script will specifically target `.c` and `.h` files. 


## Setup 
`pip install -r requirements.txt`

See [Google Cloud API][1] for getting an API Key. Store the key in the translator 
directory in a file called `googleKey.json`.

Edit env with the appropriate path for `$TRANSLATOR_HOME`
`source ./env` - Sets the environment variables needed for the translator to work

**CAUTION: Do not run this on a directory containing a .git or similar version
control folder.** Changing files inside those directories may be problematic. 

Run with: `python translate.py`

[1]: https://cloud.google.com/translate/docs/reference/libraries#client-libraries-install-python
