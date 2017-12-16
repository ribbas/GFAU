# Modules

## Symbols
- [ ] Generation
    - [ ] 16-bits
- [x] Irreduciblity
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/gen/mods/reducable16.vhd)

## Galois Operations
- [x] Addition / Subtraction
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/mods/addsub16.vhd)
- [x] Multiplication
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/mods/mul16.vhd)
- [x] Division
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/mods/div16.vhd)
- [ ] Logarithm
    - [ ] 16-bits

## Control Units
- [ ] Opcode Control Unit
    - [ ] 6-bits

## Multiplexers
- [ ] Memory Lookup
    - [ ] 16-bits
- [x] Output Select
    - [x] [6-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/mux/mods/outselect.vhd)

## Binary Arithmetic Logic Units
- [x] Partial Full Adder (PFA)
    - [x] [1-bit](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/pfadder.vhd)
- [x] Carry-Lookahead Adder (CLA)
    - [x] [4-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/claadder4.vhd)
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/claadder16.vhd)
- [x] Two's Complement
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/twoscmp.vhd)
- [x] Variable Mask
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/varmask.vhd)
- [x] Masked Two's Complement
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/maskedtwoscmp.vhd)
- [ ] Overflow Bit Calculator
    - [ ] 16-bits
- [x] Degree of Polynomial
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/mods/size.vhd)
- [ ] Zero Exception
    - [ ] 16-bits
- [ ] Out-of-bound Exception
    - [ ] 16-bits
