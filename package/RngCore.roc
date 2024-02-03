interface RngCore exposes [
        RngCore,
        seed,
        u32,
        u64,
        bool,
    ] imports [
        Generator.{ Generator, andThen, return },
    ]

RngCore implements
    seed : input -> rng where rng implements RngCore
    u32 : Generator rng U32 where rng implements RngCore
    u64 : Generator rng U64 where rng implements RngCore

bool : Generator rng Bool where rng implements RngCore
bool =
    x <- u32 |> andThen
    x
    |> Num.shiftRightBy 31
    |> Bool.isEq 0
    |> return
