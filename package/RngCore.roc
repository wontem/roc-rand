interface RngCore exposes [
        RngCore,
        seed,
        u32,
        u64,
    ] imports [
        Generator.{ Generator },
    ]

RngCore implements
    seed : input -> rng where rng implements RngCore
    u32 : Generator rng U32 where rng implements RngCore
    u64 : Generator rng U64 where rng implements RngCore
