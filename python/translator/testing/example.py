# Imports the Google Cloud client library
from google.cloud import translate

# Instantiates a client
translate_client = translate.Client()

# The text to translate
text = u'3秒检测一次电池容量及计算百分比'
# The target language
target = 'en'

# Translates some text into Russian
translation = translate_client.translate(text, target_language=target)

print(u'Text: {}'.format(text))
print(u'Translation: {}'.format(translation['translatedText']))
