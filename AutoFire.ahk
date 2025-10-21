#Requires AutoHotkey v1

#SingleInstance Force

#include <HeckerFunc>

;-------------------------------------------------------

Hotkey +AppsKey, holdKeyDown
Hotkey ^AppsKey, toggleAutoFire, T2
Hotkey +^AppsKey, setAutoFireKey
;#BUG: Due to some unknown bug (probably in AutoHotkey, but not sure), holding down keys while clicks are being spammed causes lagging and gets stuck occasionally when too many of the "cursorMover" hotkeys are set [Last tested in AutoHotkey 1.1.33.02]
; Hotkey AppsKey, heldAutoFire

;-------------------------------------------------------

; Global variables
autoFire_fireFlag := false
autoFire_key := "vk1" ;Set in setAutoFireKey()

;-------------------------------------------------------

toggleAutoFire() {
    global autoFire_fireFlag
    global autoFire_key

    autoFire_fireFlag := !autoFire_fireFlag
    while autoFire_fireFlag {
        SendInput {Blind}{%autoFire_key%}
    }
}

heldAutoFire(key) {
    global autoFire_fireFlag
    global autoFire_key

    autoFire_fireFlag := false

    while GetKeyState(key, "P") {
        SendInput { %autoFire_key% }
    }
}

setAutoFireKey() {
    global autoFire_key

    autoFire_key := readSingleKey(true, 0)
    tmpToolTip("Rapid fire key is set to: " . autoFire_key, 2000, 0, 0)
}

holdKeyDown() {
    keyToHold := readSingleKey(true, 0)

    Send {%keyToHold% down}
    tmpToolTip(keyToHold . " is being held down", 2000, 0, 0)
}
