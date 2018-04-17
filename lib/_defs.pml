/*
 * Basic macro difinitions.
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

MAXINT = 0x7fffffff
MAXNEGINT = 0x80000000
REST = 0x80000000
LASTVAL = 0x80000000
bgngrp = '{'
endgrp = '}'

CUR_TRACK = 2
def(newtrack, "q") { 
    defthread($1) 
    $1 { tk = CUR_TRACK text(3, "("+idstr($1)+")") } CUR_TRACK += 1
    $1
}

def(mod12, "n") { (($1 + 12000) % 12) }
def(gap,"n") { dp=100 do= -$1 }

/*
 * definitions for control change
 */
def(defctrl, "ssirn:n") {
  evalstr($2) = $3
  evalstr($2 + "Step") = $4
  evalstr($2 + "Threshold") = $5
  if( null($6) ) {
    edef(evalstr($1), "n") { ctrl($3, $$1) }
  } 
  edef(evalstr($1 + "_pt"), "n") { ctrl_pt($3, $$1) }
  edef(evalstr($1 + "_to"), "n") {
    ctrl_to($3, $$1, evalstr($2 + "Step"), evalstr($2 + "Threshold"))
  }
  edef(evalstr($1 + "_cto"), "n:nn") { 
    ctrl_cto($3, $$1, evalstr($2 + "Step"), evalstr($2 + "Threshold"),
             null($$2) ? 0 : {$$2}, null($$3) ? 0 : {$$3})
  }
}

defctrl("mod", "Mod", 1, 15u, 1)		// 1: modulation wheel
defctrl("breath", "Breath", 2, 15u, 1)		// 2: breath control
defctrl("foot", "Foot", 4, 15u, 1)		// 4: foot controller
defctrl("pmtime", "Pmtime", 5, 15u, 1)		// 5: portamento time
defctrl("vol", "Vol", 7, 15u, 1)		// 7: volume
defctrl("pan", "Pan", 10, 15u, 1)		// 10: pan pot
defctrl("expr", "Expr", 11, 15u, 1)		// 11: expression control
defctrl("bend", "Bend", 128, 15u, 4, 0)		// 128: pitch bend
defctrl("kp", "Kp", 129, 15u, 1, 0)		// 129: key pressure
defctrl("cpr", "Cpr", 130, 15u, 1, 0)		// 130: channel pressure
defctrl("vmag", "Vmag", 132, 15u, 0.01)		// 132: velocity magnifier
defctrl("tempo", "Tempo", 192, 15u, 1, 0)	// 192: tempo
defctrl("rtempo", "Rtempo", 193, 15u, 0.01)	// 192: relative tempo

// switches
ped	= 'ctrl(64,127)'			// 64: dumper pedal
pedoff	= 'ctrl(64,0)'
Ped = 64
pm	= 'ctrl(65,127)'			// 65: portamento on/off
pmoff	= 'ctrl(65,0)'
Pm = 65
sped	= 'ctrl(67,127)'			// 67: soft pedal
spedoff	= 'ctrl(67,0)'
Sped = 67
poly_mode = 'ctrl(127,0)'
mono_mode = 'ctrl(126,0)'

// common extentions found on multiple synths.
def(pmctrl, "i")  { ctrl(84, $1) }		// 84: portamento control
defctrl("reverb", "Reverb", 91, 15, 1)		// 91: reverb send level
defctrl("chorus", "Chorus", 93, 15, 1)		// 93: chorus send level
defctrl("effect", "Effect", 94, 15, 1)		// 94: effect send level
defctrl("filter", "Filter", 74, 15, 1) // Same as nrpc filter control
defctrl("filter_res", "Filter_res", 71, 15, 1) // Same as nrpc filter resonance control
defctrl("attack", "Attack", 73, 15, 1) // Same as attack rate nrpc.
defctrl("release", "Release", 72, 15, 1) // Same as release rate nrpc.

all_sound_off = 'ctrl(120,0)'
reset_all_ctrls = 'ctrl(121,0)'

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

// xprog: extended program change.
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

// parameter control
// add a workaround for sequencers that need controllers spaced out in time to maintain order to all 4 macros below.
// Set the following variable to 1 in a source file if this feature is needed.
$gap_needed = 0
def(rpc, "ii") { // rpc(RPN, data): registered parameter control (0-127)
  ctrl(100, $1 & 0x7f)
  ctrl(101, ($1 shr 8) & 0x7f)
  ctrl(6, $2 & 0x7f)
  ctrl(38, ($2 shl 7) & 0x7f)
}
def(rpcw, "ii") { // rpcw(RPN, data): registered parameter control (0-16383)
  ctrl(100, $1 & 0x7f)
  ctrl(101, ($1 shr 8) & 0x7f)
  ctrl(6, ($2 shr 7) & 0x7f)
  ctrl(38, $2 & 0x7f)
}
def(nrpc, "ii") { // nrpc(NRPN, data): non-registered PC (0-127)
  ctrl(98, $1 & 0x7f)
  ctrl(99, ($1 shr 8) & 0x7f)
  if ($gap_needed) { r(4u) } ctrl(6, $2 & 0x7f)
  ctrl(38, ($2 shl 7) & 0x7f)
}
def(nrpcw, "ii") { // nrpcw(NRPN, data): non-registered PC (0-16383)
  ctrl(98, $1 & 0x7f)
  ctrl(99, ($1 shr 8) & 0x7f)
  if ($gap_needed) { r(4u) } ctrl(6, ($2 shr 7) & 0x7f)
  ctrl(38, $2 & 0x7f)
}

/* NRPCs */
def(vib_rate, "i")    {nrpc(0x0108, $1 + 64)}	// vibrato rate (-64 - 63) 
def(vib_depth, "i")   {nrpc(0x0109, $1 + 64)}	// vibrato depth (-64 - 63) 
def(vib_delay, "i")   {nrpc(0x010a, $1 + 64)}	// vibrato delay (-64 - 63) 
def(tvf_cutoff, "i")  {nrpc(0x0120, $1 + 64)}	// TVF cutoff freq (-64 - 63) 
def(tvf_reso, "i")    {nrpc(0x0121, $1 + 64)}	// TVF resonance (-64 - 63) 
def(env_attack, "i")  {nrpc(0x0163, $1 + 64)}	// envelope attack (-64 - 63) 
def(env_decay, "i")   {nrpc(0x0164, $1 + 64)}	// envelope decay (-64 - 63) 
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
def(drums_effect, "ii") {nrpc(0x1f00 + $1, $2)}	// drums delay (0-127)

$bend_range = 2 // common default on most gm compatible synths.
def(bender_range, "i") { rpc(0, $1)
$bend_range = $1
}

// calculate a pitchbend value based on number of semitones given.
def(bend_tones, "i") {
$1*(8192/$bend_range)
}

// a macro to slide over a certain duration to a given number of semitones, then reset the wheel at the given speed
// format: slide_to(wait, duration, semitones, resetSpeed)
// wait and duration are rational, semitones is parsed through the bend_tones macro above.
def(slide_to, "rrir") {
reset_speed = $4
rt+=$1 bend(0) rt+=$2-reset_speed bend_pt(bend_tones($3)) rt+=reset_speed bend_to(0)
}

def(fine_tune, "i")    { rpcw(1, $1+0x2000) }   // -8192 <= $1 <= 8191
def(coarse_tune, "i")  { rpc(2, $1+0x40) }      // -64 <= $1 <= 63 

// 123: all notes off
all_notes_off = 'ctrl(123, 0)'

// allocator for virtual control change numbers
::cur_vctrl = 132
def(new_vctrl) {
  ::cur_vctrl += 1
  ::cur_vctrl
}
::cur_gctrl = 193
def(new_gctrl) {
  ::cur_gctrl += 1
  ::cur_gctrl
}
   
/* 
 * GM system on
 */
gm_system_on = 'excl(#(0x7e, 0x7f, 0x09, 0x01))'

   /*
 * define commands for text events
 */
def(comment, "s")      { text(1, $1) } 
def(copyright, "s") { {tk=1  text(2, $1)} }
def(trackname, "s") { text(3, $1) }
def(instname, "s")  { text(4, $1) }
def(lyric, "s")     { text(5, $1) }
def(cue, "s")       { text(7, $1) }
if( defined($format) && {$format == 2} ) {
   def(title, "s")   { text(1, $1) }
   def(seqname, "s") { text(3, $1) }
   def(mark, "s")  { text(6, $1) } 
} else { 
   def(title, "s")   { {tk=1  text(1, $1)} }
   def(seqname, "s") { {tk=1  text(3, $1)} }
   def(mark, "s")  { {tk=1  text(6, $1)} } 
}
marker = 'mark'

/*
 * forte, piano
 */
ppp   = 'v=20'
pp    = 'v=35'
//piano = 'v=50'
p     = 'v=50'
mp    = 'v=65'
mf    = 'v=80'	// default velocity
forte = 'v=95'
ff    = 'v=110'
fff   = 'v=127'

/*
 * effector flags
 */
TimeSort = 0x00  /* obsolete */
MergeTracks = 0x01
ExpandCtrl = 0x02

/*
 * for controlling dumper pedals  <undocumented>
 */
hold_delay = z
hold = '{ped(dt+=hold_delay) R pedoff}'

/*
 * macros/effectors for implementing pseudo-ties  <undocumented>
 *   Use like: [c e(tie) g] [g e(endtie) a](gr=10)
 */
defeff($bgn_tie) {
  case(note_off) { reject }
}
tie = '$bgn_tie()'

defeff($end_tie) {
  case(note_on) { reject }
}
endtie = '$end_tie()'
midtie = '$end_tie() $bgn_tie()'

// for backward compatibility
at = 'kp'
at_to = 'kp_to'
at_cto = 'kp_cto'
eff_events = 'set_eff_etypes()'
thru_events = 'set_thru_etypes()'
set_ethru = 'del_eff_etypes()'
clr_ethru = 'add_eff_etypes()'
eff_chs = 'set_eff_chs()'
thru_chs = 'set_thru_chs()'
set_cthru = 'del_eff_chs()'
clr_cthru = 'add_eff_chs()'
// send the given pmml to multiple tracks at once.

def(layer_tracks, "aq")
{
foreach($i, $1)
{
$i {
$2
}
}
}
