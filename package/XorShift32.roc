interface XorShift32 exposes [
        XorShift32,
        u64,
        u32,
        seed,
    ] imports [
        Generator.{ embed, Generator, andThen, return },
        RngCore.{ RngCore },
    ]

XorShift32 := U32
    implements [
        Eq,
        RngCore {
            seed,
            u32,
            u64,
        },
    ]

seed = @XorShift32

u32 = embed \@XorShift32 state ->
    state
    |> \s -> Num.bitwiseXor s (Num.shiftLeftBy s 13)
    |> \s -> Num.bitwiseXor s (Num.shiftRightZfBy s 17)
    |> \s -> Num.bitwiseXor s (Num.shiftLeftBy s 5)
    |> \s -> (@XorShift32 s, s)

u64 =
    x <- u32 |> andThen
    y <- u32 |> andThen

    (Num.toU64 x)
    |> Num.shiftLeftBy 32
    |> Num.bitwiseOr (Num.toU64 y)
    |> return
