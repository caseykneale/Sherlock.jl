using Sherlock
using Test

@testset "Trim Abstract Symbols / parsing" begin
    @test nothing_is_val(nothing, 10) == 10
    @test nothing_is_val(11, 10) == 11
    @test nothing_is_val(7, 10) == 7
    @test trim_type( Symbol("weirdtype.typer{cookies} other stuff") ) == Symbol("typer")
    @test trim_type( Symbol("Any") ) == Symbol("Any")
    @test trim_type( Symbol("Distributions.Distribution") ) == Symbol("Distribution")
    @test trim_type( Symbol("Anything{goes} where goes <: stuff") ) == Symbol("Anything")

    @test ismacro(Symbol("@thiswouldbeamacro")) == true
    @test ismacro(Symbol("thisisnotamacro")) == false
end
