/*
 * Model-specific drums macro definitions for XG
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

include("gm_drums")

/*
 * macro for each instrument
 */

MuteSurdo	= 'note(n=13)'
OpenSurdo	= 'note(n=14)'
HiQ 		= 'note(n=15)'
WhipSlap 		= 'note(n=16)'
ScratchH	= 'note(n=17)'
ScratchL	= 'note(n=18)'
FingerSnap 	= 'note(n=19)'
ClickNoise	= 'note(n=20)'
MetronomeClick	= 'note(n=21)'
MetronomeBell	= 'note(n=22)'
SeqClickL = 'note(n=23)'
SeqClickH = 'note(n=24)'
BrushTap = 'note(n=25)'
BrushSwirl = 'note(n=26)'
BrushSlap = 'note(n=27)'
BrushTapSwirl = 'note(n=28)'
SnareRoll 	= 'note(n=29)'
Castanet	= 'note(n=30)'
SnareSoft = 'note(n=31)'
Sticks		= 'note(n=32)'
KickSoft = 'note(n=33)'
OpenRimShot = 'note(n=34)'

Shaker		= 'note(n=82)'
JingleBell	= 'note(n=83)'
BellTree	= 'note(n=84)'

/*
 * macro for a group of instruments
 */
Surdo		= 'note(n=14)'	// x:open m:muted
