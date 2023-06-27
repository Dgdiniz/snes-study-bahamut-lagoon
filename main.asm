// vim: ft=bass-snes

architecture wdc65816
include "instructions.snes.asm"

variable codeCursor = $f00000  //$f00000-$f1ffff
variable textCursor = $f20000  //$f20000-$f6ffff
variable sramCursor = $316000  //$316000-$317fff

output "rom/bahamut-en.sfc", create
insert "rom/bahamut-jp.sfc"; fill $500000
tracker enable

macro seek(variable offset) {
  if offset & 0xc00000 == 0x400000 {
    origin (offset & $3fffff) | $400000
    base   (offset & $3fffff) | $400000
  }
  if offset & 0xc00000 == 0xc00000 {
    origin (offset & $3fffff) | $000000
    base   (offset & $3fffff) | $c00000
  }
}

//mark ROM for North American region instead of Japanese region
seek($c0ffb5); db 'E'  //was 'J'

//modify mapper from HiROM to ExHiROM
seek($c0ffd5); db $35  //was $31

//expand ROM from 4MB to 8MB
seek($c0ffd7); db $0d  //was $0c

//expand SRAM from 8KB to 32KB
//  $30:6000-7fff: save RAM
//  $31:6000-7fff: variables
//  $32:6000-7fff: proportional font rendering buffer
//  $33:6000-7fff: pre-rendered name tiledata cache
seek($c0ffd8); db $05  //was $03

//change region from Japan to North America
seek($c0ffd9); db $01  //was $00

//change revision from 1.0 to 1.2
seek($c0ffdb); db $02  //was $00

//erase the ROM checksum
seek($c0ffdc); dw $ffff,$0000

//enable the debugger
if 0 {
  notice "debugger enabled"
  seek($c0ffad); db $00,$ff
  include "cheats.snes.asm"
}

include "macros.snes.asm"
include "insert.snes.asm"
include "constants.snes.asm"

codeCursor = $f00000
include "reset.snes.asm"
include "character-map.snes.asm"
include "strings.snes.asm"
include "palettes.snes.asm"
include "redirection.snes.asm"
include "vsync.snes.asm"
include "base56.snes.asm"
include "render.snes.asm"
include "text.snes.asm"
include "names.snes.asm"
include "title.snes.asm"
include "chapter-large.snes.asm"
include "chapter-credits.snes.asm"
include "chapter-debugger.snes.asm"
include "combat-hdma.snes.asm"
include "combat-large.snes.asm"
include "combat-small.snes.asm"
include "combat-strings.snes.asm"
include "combat-dragons.snes.asm"
include "field-large.snes.asm"
include "field-small.snes.asm"
include "field-strings.snes.asm"
include "field-terrain.snes.asm"
include "field-debugger.snes.asm"
if codeCursor > $f10000 {
  error "code bank $f0 exhausted"
}

codeCursor = $f10000
include "menu-large.snes.asm"
include "menu-small.snes.asm"
include "menu-dispatcher.snes.asm"
include "menu-saves.snes.asm"
include "menu-names.snes.asm"
include "menu-party.snes.asm"
include "menu-dragons.snes.asm"
include "menu-information.snes.asm"
include "menu-equipment.snes.asm"
include "menu-magic-item.snes.asm"
include "menu-overviews.snes.asm"
include "menu-unit.snes.asm"
include "menu-status.snes.asm"
include "menu-shop.snes.asm"
if codeCursor > $f20000 {
  error "code bank $f1 exhausted"
}

if textCursor > $f70000 {
  error "text banks $f2-$f6 exhausted"
}

if sramCursor > $318000 {
  error "sram bank $31 exhausted"
}

//mirror $80-af:8000-ffff to $00-2f:8000-ffff
variable index = 0
while index < 48 {
  copy $008000 + index * $10000, $408000 + index * $10000, $8000
  index = index + 1
}
