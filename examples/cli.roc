app "rand"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br", rand: "../package/main.roc" }
    imports [pf.Stdout, pf.Task.{ Task }, rand.Generator, rand.XorShift32, rand.RngCore]
    provides [main] to pf

main : Task {} I32
main =
    rng = XorShift32.seed 42

    rng
    |> Generator.run gen
    |> .1
    |> Inspect.toStr
    |> Stdout.line

gen =
    x <- RngCore.u64 |> Generator.andThen
    y <- RngCore.u64 |> Generator.andThen
    { x, y } |> Generator.return
