interface XorShift32 exposes [
        XorShift32,
        u64,
        u32,
        seed,
    ] imports [
        Generator.{ embed, Generator },
        RngCore.{ RngCore },
        Impls.{ u64viau32 },
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

u64 = u64viau32
