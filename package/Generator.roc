interface Generator exposes [
        return,
        embed,
        run,
        andThen,
        Generator,
    ] imports [

    ]

Step state value : state -> (state, value)
Generator state value := Step state value

return : value -> Generator state value
return = \v ->
    @Generator \s -> (s, v)

embed : Step state value -> Generator state value
embed = @Generator

run : state, Generator state value -> (state, value)
run = \s, @Generator step -> step s

andThen : Generator state valueA, (valueA -> Generator state valueB) -> Generator state valueB
andThen = \@Generator step1, f ->
    state0 <- @Generator

    (state1, value1) = step1 state0
    (@Generator step2) = f value1

    step2 state1
