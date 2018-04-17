/*
 * XG definitions
 */

/*
 *  Copyright (C) 1997,1998   Satoshi Nishimura
 *
 * Additions made by Arthur Pirika

 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * initial bender range in semitones
 */
init_bender_range = 2		// initial bender range is +-2 semitones

/*
 * XG-specific exclusive messages. Based on the mu2000EX
 * Most messages will work on level 1 devices, exceptions are noted.
 */
device_id = 16		// this can be changed later by users

def(xg_excl, "ii") {  // xg_excl(address, data)
// For an xg parameter that takes 1 byte of data.
excl(#(0x43, device_id, 0x4c, 
  		 $1 shr 16, $1 shr 8, $1, $2))
}

def(xg_excl2, "iii") {  // xg_excl(address, data)
// For an xg parameter that takes 2 bytes of data.
excl(#(0x43, device_id, 0x4c, 
  		 $1 shr 16, $1 shr 8, $1, $2, $3))
}

def(xg_reset, "") {
  xg_excl(0x00007E, 0)
}

/*
 * virtual control change for master volume 
 * using exclusive messages 
 */
defctrl("msvol", "MasterVol", new_gctrl(), 15u, 1) 
defeff(xg_effector, "", ExpandCtrl) {
  case(ctrl(MasterVol)) {
    if( val < 0 ) {
      warn("msvol: master volume out of range")
      val = 0
    } elsif( val > 127 ) {
      warn("msvol: master volume out of range")
      val = 127 
    }
    xg_excl(0x000004, int(val))
    reject
  }
}

xg_effector()       // attach the above effector 

/*
 * reverb, chorus, and variation effects
 */

def(xg_reverb_type, "ii") { xg_excl2(0x020100, $1, $2) }
def (xg_reverb_param, "ii") // specify the parameter number and it's value.
{
if ($1 > 16) { error("Parameter number out of range, should be between 1 and 16.") }
local::addr = $1 >= 1 && $1 <= 10 ? 0x020102+($1-1) : 0x020110+($1-11)
xg_excl(addr, $2)
}
def(xg_reverb_return, "i") { xg_excl(0x02010C, $1) }
def(xg_reverb_pan, "i") { xg_excl(0x02010D, $1) }

// chorus
def(xg_chorus_type, "ii") { xg_excl2(0x020120, $1, $2) }
def (xg_chorus_param, "ii") // specify the parameter number and it's value.
{
if ($1 > 16) { error("Parameter number out of range, should be between 1 and 16.") }
local::addr = $1 >= 1 && $1 <= 10 ? 0x020122+($1-1) : 0x020130+($1-11)
xg_excl(addr, $2)
}
def(xg_chorus_return, "i") { xg_excl(0x02012C, $1) }
def(xg_chorus_pan, "i") { xg_excl(0x02012D, $1) }
def(xg_chorus_to_reverb, "i") { xg_excl(0x02012E, $1) }

// variation effect
def(xg_variation_type, "ii") { xg_excl2(0x020140, $1, $2) }
def(xg_variation_param, "ii") // specify variation parameters.
// for parameters 1 to 10, the single value here is converted to 
// specify both msb and lsb values.
// for parameters 11 to 16, only one value is needed.
{
if ($1 > 16) { error("Parameter number out of range, should be between 1 and 16.") }
if ($1 >= 1 && $1 <= 10) { xg_excl2(0x020142+(2*($1-1)), $2/128, $2%128) }
else { xg_excl(0x020170+($1-11), $2) }
}
def(xg_variation_return, "i") {xg_excl(0x020156, $1) }
def(xg_variation_pan, "i") {xg_excl(0x020157, $1) }
def(xg_variation_to_reverb, "i") {xg_excl(0x020158, $1) }
def(xg_variation_to_chorus, "i") {xg_excl(0x020159, $1) }
def(xg_variation_connection, "i") {xg_excl(0x02015A, $1) }

// Support for extra insertion effects.
// Check with your devices manual to see how many effects are supported.
// Info here is based on the mu128 and mu1000/2000 modules.
// for each of these macros, specify the number of the insertion effect that the command applies to as the first argument.

// insertion type.
// specify msb and lsb.
def(xg_insertion_type, "iii") {
if ($1 > 4) { error("Sorry, only 4 insertion effects are supported at this time.") }
xg_excl2(0x030000 + ($1-1 shl 8), $2, $3)
}

// insertion parameters that take one byte.
// parameters. insertion number, parameter number, value.
def(xg_insertion_param, "iii") {
if ($1 > 4) { error("Sorry, only 4 insertion effects are supported at this time.") }
if ($2 > 16) { error("Parameter should be between 1 and 16.") }
if ($2 >= 1 && $2 <= 10) { xg_excl(0x030002 + ($1-1 shl 8) + $2-1, $3) }
else { xg_excl(0x030020 + ($1-1 shl 8) + $2-11, $3) }
}

// insertion parameters that use a full 14-bit value.
// parameters. insertion number, parameter number, value.
// applies to parameters 1-10 only.
def(xg_insertion_param_w, "iii") {
if ($1 > 4) { error("Sorry, only 4 insertion effects are supported at this time.") }
if ($2 > 10) { error("Only parameters 1 to 10 support 14-bit values.") }
xg_excl2(0x030030 + ($1-1 shl 8 ) + 2*($2-1), $3/128, $3%128)
}

// specify the part to which an insertion effect is applied.
// specify part 127 to  turn the effect off.

def(xg_insertion_part, "ii") {
xg_excl(0x03000C + ($1-1 shl 8), $2)
}

// enable random panning on the channel specified with the ch register.
xg_random_pan = 'xg_excl(0x08000E+(ch-1 shl 8), 0)'

// support for xg plugin boards.
// xg_plg_board(type, serial, part)
def (xg_plugin_board, "iii") {
xg_excl(0x700000 + ($1 shl 8) + $2, $3)
}

// supported plg boards, use these in first parameter of xg_plugin_board macro.
plg100vl = 0
plg100sg = 1
plg100dx = 2
plg100an = 3
plg100pf = 4

// include xg rhythm instruments file
include ("xg_drums")
