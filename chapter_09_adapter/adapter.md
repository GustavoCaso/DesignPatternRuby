## Filling in the Gapas with the Adapter

With the adapter pattern we are able to create bridges that connect between mismatching software interfaces.

In our example we are going to encrypt a file from one source to another.

What happen when we need to encrypt someting that is not a `File`, maybe a `String`, for that case we will need a `StringIOAdapter`

### Adapt or modify

There are other options apart from creating an **Adapter**, depending on the complexity of the code, we could take advantage of the flexibility and dynamic properties of **Ruby**.

* We can modify the eisting class at runtime
* We could add instance methods dynamicaliy to the object we are going to use (singleton class)

When to choose between Adapetr or Modify the class, here are some exaple where opening and modifying the class is valid:

* The modification is simple and clear
* We understand the class we are modifying and the way which it is used.
* The interface mismatch is exetnsive and complex.
* You have no idea how this class works.

| *Adpaters* preserve the encapsulation at the cost of some complexity.
