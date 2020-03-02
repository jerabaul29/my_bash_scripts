# work in progress: how to make a paper backup of a gpg key

# solution 1 I found so far ---------------------
# I like the solution used there: https://unix.stackexchange.com/questions/280222/generating-qr-code-of-very-big-file
# but I want to do it with binary instead. So something like:

# export in binary mode
gpg --export-secret-keys > private.key

# split with only half max size, to have a 'nice' QR code
split -C 1250 private.key splitkey-

for file in splitkey-??; do
    <"$file" qrencode -s 3 -d 150 -o "$file".qr
done

# then to re-cover the key: generate all binary files, concatenate, and test that it works with:
 gpg --dearmor newkey >/dev/null
 
# solution 2 I fond so far ---------------------
# use paperkey

# solution 3 I found so far --------------------
# use the code there: https://github.com/balos1/easy-gpg-to-paper

# toto:
# probably the best solution is to:
# - use paperkey for doing a dump in a 'quite traditional' format
# - write my own little script based on low-level tools to:
#   - compute sha512
#   - split
#   - qr-encode
#   - qr-encode the sha512
#   - qr-encode some metadata: how many images, range of them. Put together with the sha512?
#   - do a run-test to check that worked correctly: check that able to decode from list of qr codes
#   - write the decoding tool

# notes with qr-encode:
# set error correction level: https://linux.die.net/man/1/qrencode see option -l

# note with how to decode: choose a tmp folder for all operations

# note for backup: give possibility to encrypt with gpg (?)
# note for backup: give some explanations about how many QR codes to print / how many pages.
