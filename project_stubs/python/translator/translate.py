import re
import shutil
from google.cloud import translate
import glob
import sys
import os


def translate_line(inputStr: str, translator) -> str:
    '''
    Returns the translation of a given string using the given translator client
    If the line doesn't contain Chinese characters, it is returned as is
    '''

    hits = re.findall(u"[" + CHINESE_RANGE + u"].*", inputStr)

    # Handle case where Chinese is not found
    if len(hits) == 0:
        return inputStr
    # Regex should be finidng the first instance and then return everything 
    # after that so there should only be one hit...
    elif len(hits) > 1:
        raise Exception("More than one hit???")
    # If we do find a hit, return the line translated.
    else:
        translate = translator.translate(hits[0], target_language=target)
        return inputStr.replace(hits[0], translate['translatedText'])

def translate_file(inputPath, translator):
    '''
    Translates a file specified by a given path using the given translator. 
    '''
    
    print("Translating file... " + inputPath)
    
    outputPath = 'out.txt'
    
    output = open(outputPath, 'w')
    
    with open(inputPath) as f:
        for line in f:
            output.write(translate_line(line, translate_client))
    
    output.close()

    # Take care of backups and renaming
    inputBackup = inputPath + ".bkp"
    #shutil.move(inputPath, inputBackup)
    shutil.move(outputPath, inputPath)
    

if __name__== "__main__":
    translate_client = translate.Client()
    target = "en"
    types = ("*.c", "*.h")
    CHINESE_RANGE = u"\u4e00-\u9fff"
    
    base = input("Enter folder path: ")
    #base = "codeTest"

    if not os.path.isdir(base):
        raise Exception("folder can not be found...")
    
    files_grabbed = []
    problemFiles = {}
    
    # Make list of all files
    for files in types:
        files_grabbed.extend(glob.iglob(base + "/**/" + files, recursive=True))
    
    print(files)
    for filename in files_grabbed:
        try:
            translate_file(filename, translate_client)
        except UnicodeDecodeError as err:
            #print("Error with file {}. \n {}".format(filename, err))
            problemFiles[filename] = err

    
    print("\n\n******************************")
    print("Errors with following files...")
    print("******************************\n\n")
    for fileName in problemFiles:
        print("Error with file {}: \n {}".format(fileName, problemFiles[fileName]))
