# LCD

These are polyglot implementations of the [July 2013 Coder Night problem](https://gist.github.com/ambethia/5960316). A "rosetta stone" of sorts, nearly identical implementations in each target language.

I try to be as idiomatic in each language as possible while staying true to the implementation (to help in making side-by-side comparisions). I'm far from an expert in a lot of these languages, so any feedback on specific techniques is appreciated.

* ruby √
* haxe √
* rust √
* lua √
* javascript √
* c# √
* dart √
* c √
* c++ √

## FAQ

These are some of the questions I found myself asking repeatedly when in unfamilliar territory:

* How are the project files ogranized, are there a best-practices to follow? 
* How do I run builds? A GUI, a Makefile (e.g. c, rust), run a VM on the command line (e.g. lua, ruby)?
* How do I print to standard out? "Hello, World?"
* What's the entry point? Is there a `main` function I can implement?
* How do I read the command line arguments (i.e. `vargs`)?
* How do I parse a string into a numeric/integer type?
* How do I define a new class, and what does the constructor look like? instance/member variables? Can I declare class-level static variables (e.g. for `H_SYM` and `V_SYM`)?
* What kind of control structures and iterators do I have, and how do I iterate each character in a string?
* Can I use a ternary conditional (`a ? b : c`) or a less-clear but semantic equivilant (`a and b or c`, e.g. in Lua)?
* How do I print to standard out without a new line character being appended for me?
* The bitwise 'and' operator; it's `&`, right?
* How do I raise a number to a power? (`Math.pow`, `^`, `**`)?
