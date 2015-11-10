## Getting in Front of Your Object with a Proxy

Controlling access to an object or providing a location-independent way of gettingat the object or delaying its creation--all three actually have a common solution: the **Proxy** pattern
.

The proxy is an object that respond, as the real object is like an *imposter*. The **Proxy** has a reference to the real object, the *subject*, hidden inside. When ever the client code calls a method on the the proxy, the proxy simply forwards the request to the real object.

In our example the `BankAccount` will be the real object, the proxy will be `BankAccountProxy`

The `BankAccountProxy` present the exactly interface as its subject.

Right now there is nothing fancy about our **Proxy**, but now that we havea proxy, we have a place to stand between the client and the real object, if we want to manage who does what to the bank accounr, theproxy provies the ideal point.

For the example we are goint to transform uor `BankAccountProxy` to an `AccountProtectionProxy`

We could have included the checking code in the `BankAcoount` object itself. The advantage od using a proxy for protection is that gices a nice separation of concerns. `AccountProtectionProxy` worries about who is allow and the `BankAccount` wories about with bank account stuff.


### Virtual Proxies Mkae You Lazy

We can use a proxy to delay creating objects until we really need them.
In a sense the virtual proxy is the biggest liar of the bunch, it pretends to be the real object, but it does not even have a reference to the real object until the client code calls a method. `VirtualAccountProxy`

In the two examples the frst one is responsible for creating the `BankAccoount` where the second example leave this responsabilty the block passed with the class.

### Eliminatig That Proxy Drudgery

One annoying characteristic that all of our proxies have so far is the need to write all of those boring methods.
We could avoid all this boring task by using `method_missing`

