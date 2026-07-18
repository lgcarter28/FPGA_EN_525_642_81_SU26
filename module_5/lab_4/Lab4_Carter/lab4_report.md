# Lab 4 Report: VGA Checkerboard Display

## Design Summary

This design implements a 640 x 480 VGA checkerboard with 20 columns and 15 rows. Each square is 32 x 32 pixels. The board clock is 100 MHz, and the VGA timing logic generates a 25 MHz clock-enable pulse by dividing the 100 MHz clock by four. The design does not create a separate derived clock; all sequential logic uses the 100 MHz clock.

The visible display alternates green and blue checkerboard squares. A red square is stored as an X/Y board coordinate and is drawn over the checkerboard when the current pixel square matches the stored coordinate. The pushbuttons move the red square one board position per debounced button press. The square wraps at each edge. `SW[0]` is an active-high reset and returns the square to its starting position at the upper-left corner.

## Major Blocks

- `vga_timing_640x480`: Generates the 25 MHz enable pulse, horizontal counter, vertical counter, active-video signal, and active-low VGA sync outputs.
- `debounce_button`: Synchronizes each pushbutton, waits for a stable press, and produces a one-clock movement pulse.
- `square_position_controller`: Stores `square_x` and `square_y`, applies movement pulses, and handles wraparound at the board edges.
- `vga_color_renderer`: Converts pixel counters into board-square coordinates, detects the selected red square, generates the checkerboard pattern, and drives RGB outputs.
- `seg7_controller`: Reuses the Lab 3 display controller to show the current X/Y coordinate in hexadecimal on the lower four digits.

## VGA Timing

The horizontal counter counts from 0 to 799. The vertical counter counts from 0 to 520 and increments when the horizontal counter wraps. The visible region is detected when `h < 640` and `v < 480`.

The sync signals are active low:

- `VGA_HS = 0` for `656 <= h < 752`
- `VGA_VS = 0` for `490 <= v < 492`

## Resource Utilization

Vivado synthesis reported the following utilization for `lab4_top` on `xc7a100tcsg324-1`:

| Resource | Used | Available | Utilization |
| --- | ---: | ---: | ---: |
| Slice LUTs | 236 | 63,400 | 0.37% |
| Slice Registers | 178 | 126,800 | 0.14% |
| Block RAM Tile | 0 | 135 | 0.00% |
| DSPs | 0 | 240 | 0.00% |
| Bonded IOB | 36 | 210 | 17.14% |
| BUFGCTRL | 1 | 32 | 3.13% |

The design is small relative to the device. Most logic is simple counters, comparators, muxes, and flip-flops. No block RAM or DSP resources are required because the image is generated procedurally from the pixel counters and stored square coordinate.

## Design Principles

The design uses synchronous logic and a clock-enable approach. The 25 MHz VGA rate is implemented as an enable pulse, so the design avoids creating an additional clock domain. Pushbutton inputs are synchronized and debounced before they affect the position registers. The display logic is split into timing, position control, color rendering, and seven-segment display blocks to keep the implementation close to the block diagram.

The checkerboard pattern is generated from counter bits instead of storing a frame buffer. The square size is 32 pixels, so the design can use selected counter bits to convert pixel position into board-square position. This keeps resource usage low.

## Testing

The design was tested on hardware with a VGA display. The checkerboard displayed correctly, the red square moved in response to the four directional pushbuttons, the square wrapped around the board edges, and `SW[0]` reset the square to the upper-left starting position. While reset is asserted, the VGA timing logic is also reset, so the display may go black until reset is released.

Simulation testbenches were also added for the VGA timing generator, color renderer, and square position controller. These testbenches check counter timing, sync ranges, active video, color selection, movement, reset, and wraparound behavior.

## Block Diagram

The completed detailed block diagram is included as `logic_diagram_v3.drawio`. It expands the design into the requested implementation-level blocks, including counters, comparators, registers, muxes, gates, timers, ports, and display output paths.
