What is Haskell?

Haskell is a lazy, functional, statically typed programming language.

Functional

- Functions are first-class, that is, functions are values which can be used in
  exactly the same ways as any other sort of value.
- The meaning of Haskell programs is centered around evaluating expressions
  rather than executing instructions.

Pure

Haskell expressions are always referentially transparent, that is:
- No mutation! Everything (variables, data structures...) is immutable.
- Expressions never have "side effects" (like updating global variables or
  printing to the screen).
- Calling the same function with the same arguments results in the same output
  every time.

Benefits to purity:
- Equational reasoning and refactoring: In Haskell one can always "replace
  equals by equals", just like you learned in algebra class.
- Parallelism: Evaluating expressions in parallel is easy when they are guaranteed
  not to affect one another.
- Fewer headaches: Simply put, unrestricted effects and action-at-a-distance
  makes for programs that are hard to debug, maintain, and reason about.

Lazy

In Haskell, expressions are not evaluated until their results are actually needed.
Some of the consequences of this include:
- It is easy to define a new control structure just by defining a function.
- It is possible to define and work with infinite data structures.
- It enables a more compositional programming style (see wholemeal programming).
- One major downside, however, is that reasoning about time and space usage
  becomes much more complicated!

Statically typed

Every Haskell expression has a type, and types are all checked at compile-time.
Programs with type errors will not even compile, much less run.

Types

Static type systems can seem annoying. In fact, in languages like C++ and Java,
they are annoying. But this isn’t because static type systems per se are annoying;
it’s because C++ and Java’s type systems are insufficiently expressive!
We’ll take a close look at Haskell’s type system, which

- Helps clarify thinking and express program structure

The first step in writing a Haskell program is usually to write down all the types.
Because Haskell’s type system is so expressive, this is a non-trivial design
step and is an immense help in clarifying one’s thinking about the program.

- Serves as a form of documentation

Given an expressive type system, just looking at a function’s type tells you a
lot about what the function might do and how it can be used, even before you
have read a single word of written documentation.

- Turns run-time errors into compile-time errors

It’s much better to be able to fix errors up front than to just test a lot and
hope for the best. “If it compiles, it must be correct” is mostly facetious
(it’s still quite possible to have errors in logic even in a type-correct program),
but it happens in Haskell much more than in other languages.

Abstraction

“Don’t Repeat Yourself” is a mantra often heard in the world of programming.
Also known as the “Abstraction Principle”, the idea is that nothing should be
duplicated: every idea, algorithm, and piece of data should occur exactly once
in your code. Taking similar pieces of code and factoring out their commonality
is known as the process of abstraction.

Haskell is very good at abstraction: features like parametric polymorphism,
higher-order functions, and type classes all aid in the fight against repetition.
Our journey through Haskel will in large part be a journey from the specific to
the abstract.

Wholemeal programming

Another theme we will explore is wholemeal programming. A quote from Ralf Hinze:

“Functional languages excel at wholemeal programming, a term coined by Geraint
Jones. Wholemeal programming means to think big: work with an entire list,
rather than a sequence of elements; develop a solution space, rather than an
individual solution; imagine a graph, rather than a single path. The wholemeal
approach often offers new insights or provides new perspectives on a given problem.
It is nicely complemented by the idea of projective programming: first solve a
more general problem, then extract the interesting bits and pieces by transforming
the general program into more specialised ones.”

For example, consider this pseudocode in a C/Java-ish sort of language:

int acc = 0;
for ( int i = 0; i < lst.length; i++ ) {
  acc = acc + 3 * lst[i];
}

This code suffers from what Richard Bird refers to as “indexitis”: it has to
worry about the low-level details of iterating over an array by keeping track of
a current index. It also mixes together what can more usefully be thought of as
two separate operations: multiplying every item in a list by 3, and summing the
results.

In Haskell, we can just write

sum (map (3*) lst)

We’ll explore the shift in thinking represented by this way of programming, and
examine how and why Haskell makes it possible.

Literate Haskell

This file is a "literate Haskell document": only lines preceded by > and a space
core; everything else (like this paragraph) is a comment. Literate Haskell documents
have an extension of .lhs, whereas non-literate Haskell source files use .hs.

Declarations and variables

Here is some Haskell code:

> x :: Int
> x = 3
>
> -- Note that normal (non-literate) comments are preceded by two hyphens
> {- or enclosed
>    in curly brace/hyphen pairs. -}

The above code declares a variable x with Int (:: is pronounced "has type") and
declares the value of x to be 3. Note that this will be the value of x forever
(at least, in this particular program). The value of x cannot be changed later.

Try uncommenting the line below; it will generate an error saying something like
Multiple declarations of `x`.

--> x = 4

In Haskell, variables are not mutable boxes; they are just names for values!

Put another way, = does not denote "assignment" like it does in many other
languages. Instead, = denotes definition, like it does in mathematics. That
is, x = 4 should not be read as "x gets 4" or "assign 4 to x", but as
"x is defined to be 4".

What do you think this code means?

> y :: Int
> y = y + 1

Basic Types

> -- Machine-sized integers
> i :: Int
> i = -78

Ints are guaranteed by the Haskell language standard to accommodate values at
least up to \pm 2 ^ 29, but the exact size depends on your architecture. For
example, on a 64-bit machine the range is \pm 2 ^ 63. You can find the range
on your machine by evaluating the following:

> biggestInt, smallestInt :: Int
> biggestInt = maxBound
> smallestInt = minBound

(Note that idomatic Haskell uses camelCase for identifier names.)

The Integer type, on the other hand, limited only by the amount of memory on the
machine.

> -- Arbitrary-precision integers
> n :: Integer
> n = 1234567890987654321431432153641364587978547380
>
> reallyBig :: Integer
> reallyBig = 2^(2^(2^(2^2)))
>
> numDigits :: Int
> numDigits = length (show reallyBig)

For floating-point numbers, there is Double:

> -- Double-precision floating point
> d1, d2 :: Double
> d1 = 4.5387
> d2 = 6.2831e-4

There is alos a single-precision floating point number type, Float.

Finally, there are booleans, characters, and strings:

> -- Booleans
> b1, b2 :: Bool
> b1 = True
> b2 = False
>
> -- Unicode characters
> c1, c2, c3 :: Char
> c1 = 'x'
> c2 = 'Ø' -- '\216'
> c3 = 'ダ' -- '\12480'
>
> -- Strings are lists of characters with special syntax
> s :: String
> s = "Hello, Haskell!"

GHCi

GHCi is an interactive Haskell REPL.
Common commands:
:load (:l)
:reload (:r)
:type (:t)
:? -- list commands

Arithmetic

Example of arithmetic in GHCi:

ex01 = 3 + 2
ex02 = 19 - 27
ex03 = 2.35 * 8.6
ex04 = 8.7 / 3.1
ex05 = mod 19 3
ex06 = 19 `mod` 3
ex07 = 7 ^ 222
ex08 = (-3) * (-7)

Note how `backticks` make a function name into an infix operator. Note also that
negative numbers must often be surrounded by parentheses, to avoid having the
negation sign parsed as subtraction.

This, however gives an error:

> -- badArith1 = i + n

Addition is only between values of the same numeric type, and Haskell does not
do implicit conversion. You must explicitly convert with:
- fromIntegral: converts from any integral type (Int or Integer) to any other
  numeric type.
- round, floor, ceiling: convert floating-point numbers to Int to Integer.

Now try this:

> -- badArith2 = i / i

This is an error since / performs floating-point division only. For integer
division we can use div.

ex09 = i `div` i
ex10 = 12 `div` 5

Boolean logic

As you would expect, Boolean values can be combined with (&&) (logical and), (||)
(logical or), and not. For example,

ex11 = True && False
ex12 = not (False || True)

Things can be compared for equality with (==) and (/=), or compared for order
using (<), (>), (<=), and (>=).

ex13 = ('a' == 'a')
ex14 = (16 /= 3)
ex15 = (5 > 3) && ('p' <= 'q')
ex16 = "Haskell" > "C++"

Haskell also has if-expressions: if b then t else f is an expression which
evaluates to t if the Boolean expression b evaluates to True, and f if b
evaluates to False. Notice that if-expressions are very different than
if-statements. For example, with an if-statement, the else part can be optional;
an omitted else clause means “if the test evaluates to False then do nothing”.
With an if-expression, on the other hand, the else part is required, since the
if-expression must result in some value.

Idiomatic Haskell does not use if expressions very much, often using
pattern-matching or guards instead (see the next section).

Defining basic functions

We can write functions on integers by cases.

> -- Compute the sum of the integers from 1 to n.
> sumtorial :: Integer -> Integer
> sumtorial 0 = 0
> sumtorial n = n + sumtorial (n - 1)

Note the syntax for the type of a function: sumtorial :: Integer -> Integer says
that sumtorial is a function which takes an Integer as input and yields another
Integer as output.

Each clause is checked in order from top to bottom, and the first matching clause
is chosen. For example, sumtorial 0 evaluates to 0, since the first clause is
matched. sumtorial 3 does not match the first claue (3 is not 0), so the second
clause is tried. A variable like n matches anything, so the second clause matches
and sumtorial 3 evaluates to 3 + sumtorial (3 - 1) (which can then be evaluated
further).

Choices can also be made based on arbitrary Boolean expressions using guards.
For example:

> hailstone :: Integer -> Integer
> hailstone n
>   | n `mod` 2 == 0 = n `div` 2
>   | otherwise      = 3 * n + 1

Any number of guards can be associated with each clause of a function defintion,
each of which is a Boolean expression. If the clause's patterns mathc, the guards
are evaluated in order from top to bottom, and the first one which evaluates to
True is chosen. If none of the guards evaluate to True, matching continues with
the next clause.

For example, suppose we evaluate hailstone 3. First, 3 is matched against n, which
succeeds (since a variable matches anything). Next, n `mod` 2 == 0 is evaluated;
it is False since n = 3 does not result in a remainder of 0 when divided by 2.
otherwise is just a convenient synonym for True, so the second guard is chosen,
and the result of hailstone 3 is thus 3*3 + 1 = 10.

As a more complex (but more contrived) example:

> foo :: Integer -> Integer
> foo 0 = 16
> foo 1
>   | "Haskell" > "C++" = 3
>   | otherwise         = 4
> for n
>   | n < 0            = 0
>   | n `mod` 17 == 2  = -43
>   | otherwise        = n + 3

As a final note about Boolean expressions and guards, suppose we wanted to abstract
out the test of evenness used in defining hailstone. A first attempt is shown below:

> isEven :: Integer -> Bool
> isEven n
>   | n `mod` 2 == 0 = True
>   | otherwise      = False

This works, but it is much too complicated.

Pairs
