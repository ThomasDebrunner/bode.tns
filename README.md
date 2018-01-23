# bode.tns

Bode.tns is a quick and dirty lua script intended to plot double-logarithmic bode-diagrams on directly on your TI-Nspire calculator. It is especially targeted towards electrical engineering problems.

## Features
* Amplitude and phase visualization
* Fast plotting with adjustable step width
* Works on all TI-Nspire calculators

## Usage
1. Download or clone this repository
2. Load the bode.tns file onto your calculator (e.g. Use Nspire Link Software)
3. Open the document on your calculator
4. Switch to tab 1.2
5. Redefine the function `h(w)`with your own, where `w` denotes the angular frequency. NOTE: use the built-in `i` (imaginary unit)!
6. On tab 1.3 you can see the amplitude, the phase plot is on tab 1.4
7. Move around with the arrow keys, zoom with +, -, /, *

#### Change step width
Redefine the `step` variable by typing `step:=x` where x denotes the step width. Note that in order to increase drawing performance, drawing is done linearly with respect to the decades. A step value of 1 corresponds to a single point every decade, a value of 0.1 to 10 points/decade.

I managed to get the best results with values around 0.02


#### Manually define window
You can manually define the display window by defining the variables `xstart`, `xend`, `ystart`, `yend`, `ystartp` and `yendp` where the variables ending with p only affect the phase plot. 

## License
The MIT License (MIT)

Copyright (c) 2012 Thomas Debrunner

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
