class HashTable:
    def __init__(self):
        self.collection = {}

    def hash(self, string):
        # Sum the Unicode values of each character
        return sum([ord(char) for char in string])

    def add(self, key, value):
        key_hash = self.hash(key)

        # Check if the hash already exists in the collection
        if key_hash not in self.collection:
            self.collection[key_hash] = {}

        # Store the key-value pair in the nested dictionary at that hash
        self.collection[key_hash].update({key: value})

    def remove(self, key):
        key_hash = self.hash(key)

        # Check if the hash exists AND if the specific key is inside that bucket
        if key_hash in self.collection and key in self.collection[key_hash]:
            del self.collection[key_hash][key]

            # Optional: If the bucket is now empty, clean up the hash entry
            if not self.collection[key_hash]:
                del self.collection[key_hash]

    def lookup(self, key):
        key_hash = self.hash(key)

        # Check if the hash exists and return the specific key's value
        if key_hash in self.collection and key in self.collection[key_hash]:
            return self.collection[key_hash][key]

        return None
