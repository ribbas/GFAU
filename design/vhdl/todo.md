# Issues with Modules

## generator.vhd

- [ ] Timing issues with zero and the zeroth term and their memory addresses.
- [ ] Concurrently write to `mem2`.
- [ ] One symbol per cycle (It takes 327.7 μs - 655.4 μs at maximum, which is sufficient)

## operators.vhd

- [ ] Merge `outselect` and `outconvert`
- [ ] Integrate high-impedence `id` ports

## control_unit.vhd

- [ ] Integrate high-impedence `id` ports

## memory_wrapper.vhd

- [ ] Integrate high-impedence `id` ports
