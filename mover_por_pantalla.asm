;
; Prueba de codigo ensamblador
;
; Radastan

        ORG 32768
	
; RUTINA DE PREPARACION DE PANTALLA

	ld a, 19	; papel azul y tinta en blanco
	ld (23693),a	; actualizamos ATTR
	ld (23624),a	; variable del sistema BORDCR, parte baja de la pantalla
	call 3503
	ld a, 1		; borde azul, para actualización inmediata
	out (254), a

; BC será la posición del cursor

	ld d, 10
	ld e, 10

; rutina de movimiento

	call impri

inici	ld bc, 64510
	in a, (c)	; leemos Q a T
	rr a		; verificamos la tecla Q
	jp c,tecl2
	call borra
	dec d		; subimos el cursor
	call impri
tecl2	ld bc, 65022
	in a, (c)	; leemos A a G
	rr a		; verificamos la tecla A
	jp c,tecl3
	call borra
	inc d		; bajamos el cursor
	call impri
tecl3	ld bc, 57342
	in a, (c)	; leemos P a Y
	rr a		; verificamos la tecla P
	jp c,tecl4
	call borra
	inc e		; subimos el cursor
	call impri
tecl4	ld bc, 57342
	in a, (c)	; leemos P a Y
	rr a		; verificamos la tecla O
	rr a
	jp c,final
	call borra
	dec e		; bajamos el cursor
	call impri
final	halt		; sincronizamos la rutina con la pantalla
	halt
	jp inici

	ret


; RUTINA DE BORRADO DE CARACTER

borra	call posic
	ld a, 32
	rst 16
	
	ret

; RUTINA DE POSICION DEL CURSOR

posic	LD a, 22	; comando AT
	RST 16
	LD a, d		; fila
	RST 16
	LD a, e		; columna
	RST 16
	
	ret

; RUTINA DE IMPRESION DE CARACTER

impri	call posic
	ld a, 79
	ld bc,32
	rst 16
	
	ret
END 32768