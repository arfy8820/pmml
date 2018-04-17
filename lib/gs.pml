/*
 * GS-specific definitions (not tested)
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
 * initial bender range in semitones
 */
init_bender_range = 2		// initial bender range is +-2 semitones

/*
 * GS-specific exclusive messages
 */
device_id = 16		// this can be changed later by users

def(gs_excl, "ia") {  // gs_excl(address, data_array)
  local::dat = #(0x41, device_id, 0x42, 0x12, 
  		 $1 shr 16, $1 shr 8, $1, @$2)
  local::checksum = 0
  for($i, 5, #dat) { checksum += int(dat[$i]) & 0x7f }
  append(dat, - checksum)
  excl(dat)
}

def(gs_reset, "") {
  gs_excl(0x40007f, #(0))
}
def(sc88_mode_set, "i") {  // 0: single module mode  1: double module mode
  gs_excl(0x00007f, #($1))
}

/*
 * Returns the appropriate representation of the ch register for a gs exclusive.
 * 1-9 for channels 1 to 9, 0 for channel 10, and 10 through 15 for channels 11 to 16.
*/

def (gs_chan, "")
{
switch (ch)
{
case(1,2,3,4,5,6,7,8,9) { ch }
case(10) { 0 }
case(11,12,13,14,15,16) { ch-1 }
default { error("Huh? How did we get here? \n") }
}
}

/*
 * virtual control changes for master volume and master pan 
 * using exclusive messages 
 */
defctrl("msvol", "MasterVol", new_gctrl(), 15u, 1) 
defctrl("mspan", "MasterPan", new_gctrl(), 15u, 1) 

defeff(gs_effector, "", ExpandCtrl) {
  case(ctrl(MasterVol)) {
    if( val < 0 ) {
      warn("msvol: master volume out of range")
      val = 0
    } elsif( val > 127 ) {
      warn("msvol: master volume out of range")
      val = 127 
    }
    gs_excl(0x400004, #(int(val)))   
    reject
  }
  case(ctrl(MasterPan)) {
    if( val < 0 ) {
      warn("msvol: master pan out of range")
      val = 0
    } elsif( val > 127 ) {
      warn("msvol: master pan out of range")
      val = 127 
    }
    gs_excl(0x400006, #(int(val)))   
    reject
  }
}

gs_effector()       // attach the above effector 

/*
 * reverb, chorus, and delay
 */
def(gs_set_reverb, "i*") { // gs_set_reverb(macro, [, charac, pre-lpf, 
		           //   level, time, feedback, dummy, predelay] )
  gs_excl(0x400130, $*)
}

// individual parameter controls.
def(gs_reverb_macro, "i") {
gs_excl(0x400130, #($1))
}

def(gs_reverb_character, "i") {
gs_excl(0x400131, #($1))
}

def(gs_reverb_pre_LPF, "i") {
gs_excl(0x400132, #($1))
}

def(gs_reverb_level, "i") {
gs_excl(0x400133, #($1))
}

def(gs_reverb_time, "i") {
gs_excl(0x400134, #($1))
}

def(gs_reverb_delay_fb, "i") {
gs_excl(0x400135, #($1))
}

def(gs_reverb_predelay, "i") {
gs_excl(0x400137, #($1))
}

def(gs_set_chorus, "i*") { // gs_set_chorus(macro, [, pre-rpf, level, feedback,
		           //   delay, rate, depth, snd_to_rev, snd_to_delay] )
  gs_excl(0x400138, $*)
}

// individual parameter controls
def(gs_chorus_macro, "i") {
gs_excl(0x400138, #($1))
}

def(gs_chorus_pre_LPF, "i") {
gs_excl(0x400139, #($1))
}

def(gs_chorus_level, "i") {
gs_excl(0x40013a, #($1))
}

def(gs_chorus_fb, "i") {
gs_excl(0x40013b, #($1))
}

def(gs_chorus_delay, "i") {
gs_excl(0x40013c, #($1))
}

def(gs_chorus_rate, "i") {
gs_excl(0x40013d, #($1))
}

def(gs_chorus_depth, "i") {
gs_excl(0x40013e, #($1))
}

def(gs_chorus_to_reverb, "i") {
gs_excl(0x40013f, #($1))
}

def(gs_chorus_to_delay, "i") { // sc-88 and above.
gs_excl(0x400140, #($1))
}

// the following will only function on sc-88 and above.
def(gs_set_delay, "i*")  { // gs_set_delay(macro, [, pre-lpf, time-cent,
			   //   time-left, time-right, lev-cent, lev-left,
			   //   lev-right, level, feedback, snd_to_rev] )
  gs_excl(0x400150, $*)
}

// individual parameter controls
def(gs_delay_macro, "i") {
gs_excl(0x400150, #($1))
}

def(gs_delay_pre_LPF, "i") {
gs_excl(0x400151, #($1))
}

def(gs_delay_time_c, "i") {
gs_excl(0x400152, #($1))
}

def(gs_delay_time_ratio_l, "i") {
gs_excl(0x400153, #($1))
}

def(gs_delay_time_ratio_r, "i") {
gs_excl(0x400154, #($1))
}

def(gs_delay_level_c, "i") {
gs_excl(0x400155, #($1))
}

def(gs_delay_level_l, "i") {
gs_excl(0x400156, #($1))
}

def(gs_delay_level_r, "i") {
gs_excl(0x400157, #($1))
}

def(gs_delay_level, "i") {
gs_excl(0x400158, #($1))
}

def(gs_delay_fb, "i") {
gs_excl(0x400159, #($1))
}

def(gs_delay_to_reverb, "i") {
gs_excl(0x40015a, #($1))
}

def(gs_set_eqlzer, "i*") { // gs_set_eqlzer(l-freq, l-gain, h-freq, h-gain)
  gs_excl(0x400200, $*)
}

// the following will only function on sc-88pro and above.
def(gs_set_fx, "i*") { // fxTypeH, fxTypeL, dumby, fxp1, fxp2, fxp3... fxp20, sndToReverb, SndToChorus, sndToDelay.
  gs_excl(0x400300, $*)
}

// individual parameter controls
def(gs_fx_type, "ii") { // fx type has both msb and lsb.
gs_excl(0x400300, #($1, $2))
}

// gs_fx_param(paramNo, value) - specify each parameter individually.
def(gs_fx_param, "ii") {
gs_excl(0x400303+($1-1), #($2))
}

def(gs_fx_to_reverb, "i") {
gs_excl(0x400317, #($1))
}

def(gs_fx_to_chorus, "i") {
gs_excl(0x400318, #($1))
}

def(gs_fx_to_delay, "i") {
gs_excl(0x400319, #($1))
}

// switch insertion effect on for the specified channel in the ch register.
gs_fx_on = 'gs_excl(0x404022 + gs_chan() shl 8, #(1))'

// switch insertion effect off for the specified channel in the ch register.
gs_fx_off = 'gs_excl(0x404022 + gs_chan() shl 8, #(0))'

/* 
 * display string on the LCD panel
 */
def(gs_display_string, "s") {
  local::dat = #()
  local::len = strlen($1)
  for($i, 1, 32) {
    if( $i <= len ) {
      append(dat, charcode(substr($1, $i, 1)))
    } elsif( $i <= 16 ) {
      append(dat, 0x20)
    }
  }
  gs_excl(0x100000, dat)
}

/*
 * gs_write_bitmap(page_no, string1, string2, ..., string16) stores 
 * a bitmap image to one of the 16 image buffers in a GS module.
 * "stringN" contains a 16-character string representing the bitmap 
 * of the N-th line.  Charactor "*" or "x" truns on its corresponding dot. 
 * If page_no is 1, the bitmap is immediately displayed.
 */
def(gs_write_bitmap, "issssssssssssssss") { 
  local::$ad = 0x100000 + ((($1 + 1) shl 7) & 0xf00) + ((~$1 & 1) shl 6)
  shift
  local::dat = rep(64,0)
  for($i,1,16) {
    local::$d = 0
    local::$ofs = 0
    for($col, 1, 16) {
      if( local::$c = substr($*[$i], $col, 1)  $c == "*" || $c == "x" ) {
         $d |= 1
      }
      if( $col % 5 == 0 ) {
	 dat[$i + $ofs] = $d
         $d = 0
         $ofs += 16
      }
      $d shl= 1
    }
    $d shl= 3
    dat[$i + 48] = $d
  }
  gs_excl($ad, dat)
}

def(gs_display_page, "i") {  // gs_display_page(page_no)
  gs_excl(0x102000, #($1))
}
def(gs_display_time, "i") {  // gs_display_time(time)
  gs_excl(0x102001, #($1))
}

/* Set the specified channel in the ch register to the given drum map.
0 for melody, 1 or 2 for specified drum map.
*/

def (gs_drum_map, "i")
{
gs_excl(0x401015 + (gs_chan() shl 8), #($1))
}

def (gs_sc_map, "i") {
for ($i, 1, 16) {
ch=$i
gs_excl(0x404001 + (gs_chan() shl 8), #($1))
}
}

/*
 * include rhythmic instrument name file
 */
include("gs_drums")
