org 08000h
; call 3435
ld hl,04000h
ld (hl),%10101010
ld de,04001h
ld bc,17FFh
ldir

call imp_msj
; call 3582 ; scroll hacia arriba 1 línea
ret

imp_msj ld de,msj
    call 3082
    ret

msj defb #80
    defm "HOLA MUNDO"
    defb " "+#80

end 08000h
