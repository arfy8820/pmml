pmml-0.2p1-fork-201405
============================

## What is this?

This is another fork of the pmml, practical music macro language, compiler as originally written by Satoshi Nishimura.
This fork includes the following so far.

* A draft translation of the pmml user's manual into english, around 80% complete, with annotations in the texinfo source where help is needed.
* an improved standard library, with updated support for Roland GS and Yamaha XG devices, as well as macros for easier manipulation of pitch bends, for example.

## Things still to be done

* Convert japanese text files to UTF-8. Sources in the comp and m2p directories are converted.
* fix the internal links in the japanese version of the texinfo sources when converted to HTML.

## Compilation and running notes

So far, this code is extremely 32-bit centric, inherently relying on the fact that int/long/pointers are 32-bits, and thus seems very tricky to get working on 64-bit systems. Because of this, use a 32-bit compiler and runtime for now. Under windows, MSYS2 with the I686 toolchain works fine.
Under mac/linux, use multilib support, etc.
Note though that Mac OS catalina and later have no provision for running any 32-bit code natively.
To compile, configure the values at the top of Makefile, namely, `bindir` and `libdir`. For 32-bit compilation under a multilib environment, add -m32 to the CC variable in makefile.

## call for help

I feel, at this point, 2022-01-18, that I've taken this code as far as I can. I've managed to get the code compiling with both
clang and gcc, and significantly reduced the number of warnings from clang by running iconv over the sources and converting to UTF-8 from EUC-JP.
However, I can't figure out how to prevent the segfaults that occur when the code is run as 64-bit. The C style seems very old, and I'm having trouble figuring out how it all fits together in places. Especially how the main PmmlObject union works.
So, for now, I'm pausing work on this code, but I'm leaving it here if anyone would like to take a look at it, and see if it can be made to run once again on new systems, such as Apple's M1 mac.