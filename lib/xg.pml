/*
 * XG definitions
 */

/*
 *  Copyright (C) 1997,1998   Satoshi Nishimura
 *
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
 * define model specific control changes
 */
def(pmctrl, "i")  { ctrl(84, $1) }		// 84: portamento control
defctrl("reverb", "Reverb", 91, 15, 1)		// 91: reverb send level
defctrl("chorus", "Chorus", 93, 15, 1)		// 93: chorus send level
defctrl("variation", "Variation", 94, 15, 1)		// 94: delay send level
defctrl("filter", "Filter", 74, 15, 1) // documented in xg specs as harmonic brightness control
defctrl("filter_res", "Filter_res", 71, 15, 1) // documented in xg spec as harmonic content control.
defctrl("attack", "Attack", 73, 15, 1) // Same as attack rate nrpc.
defctrl("release", "Release", 72, 15, 1) // Same as release rate nrpc.

all_sound_off = 'ctrl(120,0)'
reset_all_ctrls = 'ctrl(121,0)'

/* NRPCs */
def(vib_rate, "i")    {nrpc(0x0108, $1 + 64)}	// vibrato rate (-64 - 63) 
def(vib_depth, "i")   {nrpc(0x0109, $1 + 64)}	// vibrato depth (-64 - 63) 
def(vib_delay, "i")   {nrpc(0x010a, $1 + 64)}	// vibrato delay (-64 - 63) 
def(tvf_cutoff, "i")  {nrpc(0x0120, $1 + 64)}	// TVF cutoff freq (-64 - 63) 
def(tvf_reso, "i")    {nrpc(0x0121, $1 + 64)}	// TVF resonance (-64 - 63) 
def(env_attack, "i")  {nrpc(0x0163, $1 + 64)}	// envelope attack (-64 - 63) 
def(env_decay, "i")   {nrpc(0x0164, $1 + 64)}	// envelope decay (-64 - 63) 
def(env_release, "i")   {nrpc(0x0166, $1 + 64)}	// envelope decay (-64 - 63)
// set per-note drums parameters   (ex.) drums_pitch(drums_no(BD), 10)
def(drums_filter, "ii") {nrpc(0x1400 + $1, $2 + 64)} // drums filter cutoff (-64 - 63)
def(drums_filter_res, "ii") {nrpc(0x1500 + $1, $2 + 64)} // drums filter resonance  (-64 - 63)
def(drums_env_attack, "ii") {nrpc(0x1600 + $1, $2 + 64)} // drums attack rate (-64 - 63)
def(drums_env_decay, "ii") {nrpc(0x1700 + $1, $2 + 64)} // drums decay rate (-64 - 63)
def(drums_pitch, "ii") {nrpc(0x1800 + $1, $2 + 64)} // drums pitch (-64 - 63) 
def(drums_pitch_fine, "ii") {nrpc(0x1900 + $1, $2 + 64)} // drums pitch fine tuning (-64 - 63)
def(drums_level, "ii") {nrpc(0x1a00 + $1, $2)}  // drums level (0-127)
def(drums_pan, "ii")   {nrpc(0x1c00 + $1, $2)}  // drums pan (1-127, 0 for rnd)
def(drums_reverb, "ii"){nrpc(0x1d00 + $1, $2)}	// drums reverb (0-127)
def(drums_chorus, "ii"){nrpc(0x1e00 + $1, $2)}	// drums chorus (0-127)
def(drums_variation, "ii") {nrpc(0x1f00 + $1, $2)}	// drums variation effect (0-127)

/* values for panpot control */
left7 = 0
left6 = 10
left5 = 19
left4 = 28
left3 = 37
left2 = 46
left1 = 55
center = 64
right1  = 73
right2  = 82
right3  = 91
right4  = 100 
right5  = 109
right6  = 118
right7  = 127

// xprog. extended program change.
// xprog takes either 2 or 3 args.
// if 2 args, xprog(fullBankNo, progNo)
// else if 3 args, xprog(bankMsb, bankLsb, progNo)
// FullBannkNO is converted to msb and lsb with (fullBankNo/128, fullBankNo%128)
// ProgNo is 0 based, not 1 based as with the prog macro.
def(xprog, "ii:i")
{
  if ($# == 2)
{
ctrl(0, $1/128)
ctrl(32, $1%128)
prog($2+1)
}
else
{
ctrl(0, $1)
ctrl(32, $2)
prog($3+1)
}
}

/*
 * initial bender range in semitones
 */
init_bender_range = 2		// initial bender range is +-2 semitones

/* 
 * GM system on
 */
gm_system_on = 'excl(#(0x7e, 0x7f, 0x09, 0x01))'

/*
 * XG-specific exclusive messages. Based on level 1 xg specs.
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
def(xg_variation_param, "ii:i") // specify variation parameters.
// for parameters 1 to 10, specify both msb and lsb values.
// for parameters 11 to 16, only one value is needed.
{
if ($1 > 16) { error("Parameter number out of range, should be between 1 and 16.") }
if ($1 >= 1 && $1 <= 10) { xg_excl2(0x020142+(2*($1-1)), $2, $3) }
else { xg_excl(0x020170+($1-11), $2) }
}
def(xg_variation_return, "i") {xg_excl(0x020156, $1) }
def(xg_variation_pan, "i") {xg_excl(0x020157, $1) }
def(xg_variation_to_reverb, "i") {xg_excl(0x020158, $1) }
def(xg_variation_to_chorus, "i") {xg_excl(0x020159, $1) }
def(xg_variation_connection, "i") {xg_excl(0x02015A, $1) }

// enable random panning on the channel specified with the ch register.
xg_random_pan = 'xg_excl(0x08000E+(ch-1 shl 8), 0)'

// TBA: Instrument names and drum settings specific to xg.
