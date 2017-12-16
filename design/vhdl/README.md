# Modules

## Symbols
- [ ] Generation
    - [ ] 16-bits
- [x] Irreduciblity
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/gen/reducable16.vhd)

## Galois Operations
- [x] Addition / Subtraction
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/addsub16.vhd)
- [x] Multiplication
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/mul16.vhd)
- [x] Division
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/ops/div16.vhd)
- [ ] Logarithm
    - [ ] 16-bits

## Control Units
- [ ] Opcode Control Unit
    - [ ] 6-bits

## Multiplexers
- [ ] Memory Lookup
    - [ ] 16-bits
- [x] Output Select
    - [x] [6-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/mux/outselect.vhd)

## Binary Arithmetic Logic Units
- [x] Partial Full Adder (PFA)
    - [x] [1-bit1](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/pfadder.vhd)
- [x] Carry-Lookahead Adder (CLA)
    - [x] [4-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/claadder4.vhd)
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/claadder16.vhd)
- [x] Two's Complement
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/twoscmp.vhd)
- [x] Variable Mask
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/varmask.vhd)
- [x] Masked Two's Complement
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/maskedtwoscmp.vhd)
- [ ] Overflow Bit Calculator
    - [ ] 16-bits
- [x] Degree of Polynomial
    - [x] [16-bits](https://github.com/sabbirahm3d/GFAU/blob/master/design/vhdl/alu/size.vhd)
- [ ] Zero Exception
    - [ ] 16-bits
- [ ] Out-of-bound Exception
    - [ ] 16-bits
