## Getting Things Done with Commands
Command pattern is common in GUIs, recording what we have done and finnaly we will see how to use the command pattern to undo things or redo things.

### Ours simple button example
We have a button that will behave differently depending on who implemented, it will do a sequence of commands. That where are we going to focus our attention the list of **Comands**
Basically our button will be waiting until someone press it, and will execute a list of commands.
Our `Commands` will have to implement some short of interface.
Depending on the bussiness logic you might what to store the `commands` in the `Button` class or maybe add the logic of the command at run time, easily achieve with a block, so we could pass a `proc` to the `Button` and execute it if present. This is usually if the action is fairly simple, but if the action or comand is complicated and you will need to carry around a lot o¡f state information or decompose into several methods, use the command class.

In the example we have created a bunch of commands `create`, `delete` and `copy`. Now we need a kind of frint to hold all the commands and add them and remove them, sound lilke `Composite`
so we create the `CompositeCommand`

### Being Undone by a Command

Being able to undo is really common requirements in now a days.
The naive way to implemet this is by remenbering the state of thinkgs before the change.

So with this we could implement and interface where every command has the `execute` method and the `unexecute` method which unoes the same thing.  And we store the `Commands` in order.

