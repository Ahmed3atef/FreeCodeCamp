# Build a Hash Table

Passed

In this lab, you will build a hash table from scratch. A hash table is a data structure that stores key-value pairs. A hash table works by taking the key as an input and then hashing this key according to a specific hashing function.

For the purpose of this lab, the hashing function will be simple: it will sum the Unicode values of each character in the key. The hash value will then be used as the actual key to store the associated value. The same hash value would also be used to retrieve and delete the value associated with the key.

**Objective:** Fulfill the user stories below and get all the tests to pass to complete the lab.

**User Stories:**

1.  You should define a class named `HashTable` with a `collection` attribute initialized to an empty dictionary when a new instance of `HashTable` is created. The `collection` dictionary should store key-value pairs based on the hashed value of the key.
    
2.  The `HashTable` class should have four instance methods: `hash`, `add`, `remove`, and `lookup`.
    
3.  The `hash` method should:
    
    -   Take a string as a parameter.
    -   Return a hashed value computed as the sum of the Unicode (ASCII) values of each character in the string. You can use the `ord` function for this computation.
4.  The `add` method should:
    
    -   Take two arguments representing a key-value pair, and compute the hash of the key.
    -   Use the computed hash value as a key to store a dictionary containing the key-value pair inside the `collection` dictionary.
    -   If multiple keys produce the same hash value, their key-value pairs should be stored in the existing nested dictionary under the same hash value.
5.  The `remove` method should:
    
    -   Take a key as its argument and compute its hash.
    -   Confirm if the key exists in the collection.
    -   Remove the corresponding key-value pair from the hash table.
    -   If the key does not exist in the collection, it should not raise an error or remove anything.
6.  The `lookup` method should:
    
    -   Take a key as its argument.
    -   Compute the hash of the key, and return the corresponding value stored inside the hash table.
    -   If the key does not exist in the collection, it should return `None`.