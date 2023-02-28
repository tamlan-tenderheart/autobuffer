; Cabalist.ahk
; Automaticall buff cabalists 
; Written by Tamlan Tenderheart

; Usage:
; Press F2 to begin the buff sequence.

; This is probably over-engineered, but I am thinking about future enhancements

#SingleInstance, force
#MaxThreadsPerHotkey 2

StringCaseSense, On
SetKeyDelay,,50
CoordMode, Pixel, Relative
SendMode, InputThenPlay

class Buff {
    __New(name,pclass,target,key,cast_time) {
        this.name := name
        this.pclass := pclass
        this.target := target
        this.key := key
        this.cast_time := cast_time
    }
    Call() {
        key := this.key
        ControlSend,,{Blind}%key%,ahk_exe game.dll
    }
    Start(offset) {
        SetTimer % this, %offset%        
    }
}

class BuffManager {
    __New() {
        this.buffs := []
        this.buffs.Push(new Buff("Nullify Offense", "Cabalist", "Self", "9", 3000))
        this.buffs.Push(new Buff("Barrier of Warding", "Cabalist", "Self", "8", 4000))
        this.buffs.Push(new Buff("Nullifying Ward", "Cabalist", "Self", "7", 3000))
        this.buffs.Push(new Buff("Magnify Dexterity", "Cabalist", "Controlled", "!0", 3000))
        this.buffs.Push(new Buff("Empower Spirit", "Cabalist", "Controlled", "!9", 3000))
        this.buffs.Push(new Buff("Vivify Golem", "Cabalist", "Controlled", "!8", 3000))
        this.buffs.Push(new Buff("Accelerate Golem", "Cabalist", "Controlled", "!7", 3000))
        this.buffs.Push(new Buff("Overcharge Aggression", "Cabalist", "Controlled", "!6", 3500))
        this.buffs.Push(new Buff("Exploit Flaw", "Cabalist", "Controlled", "!5", 3000))
        this.buffs.Push(new Buff("Pursuer Enhancement", "Cabalist", "Controlled", "!4", 3000))            
    }
    Start() {
        offset := -10
        for index,buff in this.buffs {
            buff.Start(offset)
            offset := offset - 0.8 * buff.cast_time
        }
    }
}

global buffManager := new BuffManager()

F2::
buffManager.Start()
Return