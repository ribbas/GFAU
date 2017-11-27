# Modules

## Symbols
- [ ] Generation
    - [ ] 16-bits
- [x] Irreduciblity
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/gen/reducable16.vhd)

## Galois Operations
- [x] Addition / Subtraction
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/addsub16.vhd)
- [ ] Multiplication
    - [ ] 16-bits
- [ ] Division
    - [ ] 16-bits
- [ ] Logarithm
    - [ ] 16-bits

## Control Units
- [ ] Opcode Parser
    - [ ] 6-bits
- [ ] Output Select
    - [ ] 6-bits

## Binary Arithmetic
- [x] Partial Full Adder (PFA)
    - [x] [1-bit1](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/pfadder.vhd)
- [ ] Carry-Lookahead Adder (CLA)
    - [x] [4-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/claadder4.vhd)
    - [ ] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/claadder16.vhd)
- [ ] Most Significant Bit (MSB) Select
    - [ ] 16-bits
- [ ] Degree of Polynomial
    - [ ] 16-bits
- [ ] Zero Exception
    - [ ] 16-bits
- [ ] Infinity Exception
    - [ ] 16-bits
