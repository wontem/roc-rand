interface Impls exposes [
        u64viau32,
    ] imports [
        Generator.{ Generator, andThen, return },
        RngCore.{ u32 },
    ]

u64viau32 =
    x <- u32 |> andThen
    y <- u32 |> andThen

    (Num.toU64 x)
    |> Num.shiftLeftBy 32
    |> Num.bitwiseOr (Num.toU64 y)
    |> return

