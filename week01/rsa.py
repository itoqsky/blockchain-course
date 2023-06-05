import math

print("pass 'p': ", end='')
p = int(input())

print("pass 'q': ", end='')
q = int(input())

print("pass message: ", end='')
msg = str(input())

def rsa_func(p, q, msg):

    n = p * q

    phi = (p - 1) * (q - 1)

    e = 2
    while True:
        if math.gcd(e, phi) == 1:
            break
        e += 1
 
    pub_key = e
 
    d = 2
    while True:
        if (d * e) % phi == 1:
            break
        d += 1
 
    prv_key = d

    en_text = []
    for letter in msg:
        l = ord(letter)
        e = pub_key
        encrypted_text = 1
        while e > 0:
            encrypted_text *= l
            encrypted_text %= n
            e -= 1
        en_text.append(encrypted_text)
    
    de_text = ''
    for num in en_text:
        d = prv_key
        encrypted_text = num

        decrypted = 1
        while d > 0:
            decrypted *= encrypted_text
            decrypted %= n
            d -= 1
        de_text += chr(decrypted)

    en_text = ''.join(str(p) for p in en_text)
    e = pub_key
    d = prv_key 
    return n, e, d, en_text, de_text
    

print(rsa_func(p, q, msg))


