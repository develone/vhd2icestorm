# vhd2icestorm
Additional scripts to automate vhd2vl together with icestorm

Prerequisites:
yosys - http://www.clifford.at/yosys/download.html
icestorm tools + arachne-pnr - http://www.clifford.at/icestorm/

Usage:
$ git clone https://github.com/iamaiy/vhd2icestorm
$ cd vhd2icestorm
$ make

(Optional, if you have a lattice icestick available) 
$ make prog

the sources are located in vhd/

Notes:
tested on Ubuntu 16.04 LTS

Tips:
Follow the instructions on Clifford's Yosys-site regarding Ubuntu PPA installation.
When the PPA is installed arachne-pnr can be apt-get'd
