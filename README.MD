# Secure My Files

Script to encrypt and decrypt files using libsodium encryption/decryption algorithms.


## Requirements

Ruby 2.5.3+

## Install

1. Clone this repo

    ```
    $ git clone git@github.com:prodoxx/secure_file
    ```
    or 

    ```
    $ git clone https://github.com/prodoxx/secure_files.git
    ```

2. Install dependencies using bundle

    ```
    $ bundle install
    ```


## Usage

#### Encryption

To encrypt use the following format:

*ruby encryptor.rb [file_path] [file_path] ...*

##### Example

```
$ ruby encryptor.rb secret_file.docx
```

Output: 
```
Encryption Password: my_password
Salt Name: wikileak_docs

Encrypting secret_file.docx
Encryption Finished!

```

#### Decryption

To decrypt use the following format

*ruby decryptor.rb [file_path] [file_path] ...*

##### Example

```
$ ruby decryptor.rb secret_file.docx_encrypted
```

Output: 
```
Encryption Password: my_password
Salt File: salt_wikileak_docs.txt

Decrypting secret_file.docx_encrypted
Decryption Finished!
```


## FAQ

1. **Why do I need this?**
    You can use this to encrypt any file with very strong and fast encryption algorithms. 
2. **What is a salt**
    https://en.wikipedia.org/wiki/Salt_(cryptography)
3. **Where is the salt file?**
    It was generated in the folder where the encryptor and decryptor file is located named *salt_[your_salt_name].txt*.
4. **Can I still decrypt my encrypted files if I lose the salt?**
    Don't lose the salt. You won't be able to decrypt your files without it.