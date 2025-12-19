Class {
	#name : 'Vector',
	#superclass : 'Object',
	#instVars : [
		'module',
		'direction'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'as yet unclassified' }
Vector class >> module: aNumber direction: aNomberDirection [

	^ (self new module: aNumber) direction: aNomberDirection
]

{ #category : 'arithmetic' }
Vector >> + anotherVector [

	"Retorna la suma de los dos vectores como un nuevo vector. Si Alguno de los
	 vectores tiene modulo 0, entonces se retorna el otro vector."
	
	| ax bx ay by cx cy d v|
	
	(module = 0) ifTrue: [ ^ anotherVector ].
	(anotherVector module = 0) ifTrue: [  ^self ].
	
	ax := module * (direction cos).
	ay := module * (direction sin).
	bx := (anotherVector module) * (anotherVector direction cos).
	by := (anotherVector module) * (anotherVector direction sin).
	
	cx := ax + bx.
	cy := ay + by.
	" Puede ocurrir que la suma cx 0. en ese caso La dirección
	  y módulo se calculan de distinta forma"
	
	(cx = 0) ifTrue: [
		d:= (cy>=0)ifTrue:[^Float halfPi] ifFalse:[^Float halfPi + Float pi].
		v := cy.
	] ifFalse: [
		d := (cy / cx) arcTan.
		(d < 0) ifTrue: [ d := Float pi + d ].
		v := (((cx**2) + (cy**2)) sqrt).
	].
	^ Vector module: v direction: d.
]

{ #category : 'accessing' }
Vector >> direction [

	^ direction
]

{ #category : 'accessing' }
Vector >> direction: aNumber [

	direction := aNumber
]

{ #category : 'actions api' }
Vector >> load: arg1 [

	| tmp1 tmp2 |
	tmp1 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp2 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	module := tmp1 @ tmp2.
	tmp1 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp2 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	direction := tmp1 @ tmp2
]

{ #category : 'accessing' }
Vector >> module [

	^ module
]

{ #category : 'accessing' }
Vector >> module: arg1 [

	module := arg1
]

{ #category : 'as yet unclassified' }
Vector >> movePoint: aPoint [
	"Retorna un nuevo punto moviendo el punto pasado por
	 parámetro usando el vector self"
	
	^ (aPoint x + (module * direction cos))@(aPoint y + (module * direction sin))
	
]

{ #category : 'actions' }
Vector >> save: arg1 [

	arg1
		nextPutAll: module asFloat asIEEE32BitWord asByteArray;
		nextPutAll: direction asFloat asIEEE32BitWord asByteArray
]
