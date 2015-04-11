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
