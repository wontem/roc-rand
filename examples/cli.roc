app "rand"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br", rand: "../package/main.roc" }
    imports [pf.Stdout, pf.Task.{ Task }, rand.Generator, rand.XorShift32, rand.RngCore]
    provides [main] to pf

main : Task {} I32
main =
    42
    |> XorShift32.seed
    |> Generator.run gen
    |> .1
    |> Inspect.toStr
    |> Stdout.line

gen =
    x <- XorShift32.u64 |> Generator.andThen
    y <- XorShift32.u64 |> Generator.andThen
    z <- bool |> Generator.andThen
    { x, y, z } |> Generator.return

bool : Generator.Generator rng Bool where rng implements RngCore.RngCore
bool =
    x <- RngCore.u32 |> Generator.andThen
    x
    |> Num.shiftRightBy 31
    |> Bool.isEq 0
    |> Generator.return
