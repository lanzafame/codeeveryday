Algebraic data types
====================

Enumeration types
-----------------

Example:

> data Thing = Shoe
>            | Ship
>            | SealingWax
>            | Cabbage
>            | King
>   deriving Show

The above code declares a new type called `Thing`, which has five *data constructors*
`Shoe`, `Ship`, etc. which are the (only) values of type `Thing`.

> shoe :: Thing
> shoe = Shoe
>
> listOfThings :: [Thing]
> listOfThings = [Shoe, SealingWax, King, Cabbage, King]

We can write functions on `Thing`s by *pattern-matching*.

> isSmall :: Thing -> Bool
> isSmall Shoe       = True
> isSmall Ship       = False
> isSmall SealingWax = True
> isSmall Cabbage    = True
> isSmall King       = False

Recalling how function clauses are tried in order from top to bottom, we could also
make the definition of `isSmall` a bit shorter like so:

> isSmall2 :: Thing -> Bool
> isSmall2 Ship = False
> isSmall2 King = False
> isSmall2 _    = True

Beyong enumerations
-------------------

`Thing` is an *enumeration type*, similar to those provided by other 
languages such as Java or C++. However, enumeratinos are actually
only a special case of Haskell's more general *algebraic data types*.
As a first example of a data type which is not just an enumeration,
consider the definition of `FailableDouble`:

> data FailableDouble = Failure
>					  | OK Double
>   deriving Show

This says that the `FailableDouble` type has two data constructors.
The first one, `Failure`, takes no arguments, so `Failure` by itself
is a value of type `FailableDouble`. The second one, `OK`, takes an
argument of type `Double`. So `OK` by itself is not a value of type
`FailableDouble`; wwe need to give it a `Double`. For example, `OK
3.4` is a value of type `FailableDouble`.

> exD1 = Failure
> exD2 = OK 3.4

Thought exercise: what is the type of `OK`?

> safeDiv :: Double -> Double -> FailableDouble
> safeDiv _ 0 = Failure
> safeDiv x y = OK (x / y)

More pattern-matching! Notice how in the `OK` case we can give a name
to the `Double` that comes along with it.

> failureToZero :: FailableDouble -> Double
> failureToZero Failure = 0
> failureToZero (OK d) = d

Data constructors can have more than one argument.

> -- Store a person's name, age, and favourite Thing.
> data Person = Person String Int Thing
>	deriving Show
>
> brent :: Person
> brent = Person "Brent" 31 SealingWax
>
> stan :: Person
> stan = Person "Stan" 94 Cabbage
>
> getAge :: Person -> Int
> getAge (Person _ a _) = a


