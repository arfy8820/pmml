pmml-0.2p1-fork-201405
============================

# What is this?

This is another fork of the pmml, practical music macro language, compiler as originally written by Satoshi Nishimura.
This fork includes the following so far.

* A draft translation of the pmml user's manual into english, around 80% complete, with annotations in the texinfo source where help is needed.
* an improved standard library, with updated support for Roland GS and Yamaha XG devices, as well as macros for easier manipulation of pitch bends, for example.

Things I'm still to do as of 2018/04/16

* Convert japanese text files to UTF-8.
* fix the internal links in the japanese version of the texinfo sources when converted to HTML.

# Compilation and running notes

So far, this code is extremely 32-bit centric, inherently relying on the fact that int/long/pointers are 32-bits, and thus seems very tricky to get working on 64-bit systems. Because of this, use a 32-bit compiler and runtime for now. Under windows, MSYS2 with the I686 toolchain works fine.
Under mac/linux, use multilib support, etc.

To compile, configure the values at the top of Makefile, namely, `bindir` and `libdir`. 
