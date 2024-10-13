def count_vowels(str):
    vowels = 'aeiou'
    cnt = 0
    for i in str:
        if i.lower() in vowels:
            cnt +=1 
    else: 
        return cnt

def reverse_string(str):
    return str[::-1]

def is_palindrome(str):
    return str.lower() == str[-1::-1].lower()

def capitalize_string(str):
    return str.capitalize()