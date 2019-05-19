# vhd2icestorm
Additional scripts to automate vhd2vl together with Yosys, NextPNR/arachne-pnr and icestorm

Prerequisites:

yosys - http://www.clifford.at/yosys/download.html
icestorm tools + arachne-pnr/nextpnr - http://www.clifford.at/icestorm/

Usage:

$ git clone https://github.com/iamaiy/vhd2icestorm

$ cd vhd2icestorm

$ make

or

$ make PNR=arachne-pnr
$ make PNR=nextpnr

to run with specified place and route tool

(Optional, if you have a lattice icestick available) 

$ make prog

the sources are located in vhd/

Notes:
tested on Ubuntu 16.04 LTS, 18.04 LTS

Tips:
Follow the instructions on Clifford's Yosys-site regarding Ubuntu PPA installation.
When the PPA is installed arachne-pnr can be apt-get'd
