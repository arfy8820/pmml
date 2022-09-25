pmml-0.2p1-fork-201405
============================

## What is this?

This is another fork of the pmml, practical music macro language, compiler as originally written by Satoshi Nishimura.
This fork includes the following so far.

* A draft translation of the pmml user's manual into english, around 80% complete, with annotations in the texinfo source where help is needed.
* an improved standard library, with updated support for Roland GS and Yamaha XG devices, as well as macros for easier manipulation of pitch bends, for example.

## Things still to be done

* fix the internal links in the japanese version of the texinfo sources when converted to HTML.

## Compilation and running notes

As of 2022-09-18, this code now runs as both 32-bit and 64-bit code, except under windows.
To compile, configure the values at the top of Makefile in the root of this tree, or pass the BINDIR and LIBDIR variables to make.
The source will compile on both clang and gcc. Tested systems include:
* MSYS gcc 12.2, mingw32 on windows 11.
* apple clang 13.0 and 14.0 under mac os 12.
* gcc 12.2 under Archlinux
* gcc 9 under Ubuntu 20.04
* FreeBSD 13.0 and clang 11.0
* cross-compiled from mac OS with dos/DJGPP, gcc 10.2.

## Binary/package releases

A windows binary package is available, containing both pmml and m2p, all libraries and examples, and both English and Japanese manuals in html format.
A homebrew tap is also available.
'brew tap arfy8820/midiutils'
or
'brew install arfy8820/midiutils/pmml'
The brew formula contains the same items as the windows version, above.
