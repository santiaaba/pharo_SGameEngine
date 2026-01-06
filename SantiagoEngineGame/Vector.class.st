"
Soy la repreentación de un vector matemático 2d.
"
Class {
	#name : 'Vector',
	#superclass : 'Object',
	#instVars : [
		'module',
		'direction',
		'xComponent',
		'yComponent'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'as yet unclassified' }
Vector class >> module: aNumber direction: aNomberDirection [

	^ (self new module: aNumber) direction: aNomberDirection
]

{ #category : 'as yet unclassified' }
Vector class >> xMagnitude: magnitude direction: aRadians [

	| aux |
	aux := aRadians cos.
	(aux = 0) ifTrue: [ ^self module: magnitude direction: aRadians ].
	^self module: (magnitude / aRadians cos) direction: aRadians.
]

{ #category : 'as yet unclassified' }
Vector class >> yMagnitude: magnitude direction: aRadians [

	| aux |
	aux := aRadians sin.
	(aux = 0) ifTrue: [ ^self module: magnitude direction: aRadians ].
	^self module: (magnitude / aRadians sin) direction: aRadians.
]

{ #category : 'arithmetic' }
Vector >> + anotherVector [
	"Retorna un nuevo vector resultado de la suma de los dos vectores.
	 Si Alguno de los vectores tiene modulo 0, entonces se retorna el
	 otro vector."
	
	|cx cy d v|
	(anotherVector module = 0) ifTrue: [ ^self ].
	(module = 0) ifTrue: [ ^ anotherVector ].
	
	cx := xComponent + anotherVector x.
	cy := yComponent + anotherVector y.
	" Puede ocurrir que la suma cx 0. en ese caso La dirección
	  y módulo se calculan de distinta forma"
	
	(cx = 0) ifTrue: [
		(cy>=0)ifTrue:[d := Float halfPi] ifFalse:[d := Float halfPi + Float pi].
		v := cy.
	] ifFalse: [
		d := (cy / cx) arcTan.
		(cx < 0) ifTrue:[
			d := d + Float pi.
		] ifFalse: [
			(cy < 0) ifTrue: [ d := d + Float twoPi ]
		].
		v := (((cx**2) + (cy**2)) sqrt).
	].
	^ Vector module: v direction: d.
]

{ #category : 'adapting' }
Vector >> adaptToPoint: anotherPoint andSend: selector [
	" Si el vector se ve involucrado en una operación
	  algebraica donde el segundo parámetro es un punto,
	  se convierte el vector en un punto para poder realizar
	  la operación."
	
	^ anotherPoint perform: selector with: self toPoint.
]

{ #category : 'as yet unclassified' }
Vector >> calculateComponents [
	"Privado. Calcula las componentes de un vector y las almacena
	 entre sus atributos como distancias. Las componentes están
	 expresadas sin signo."
	
	xComponent := module * (direction cos).
	yComponent := module * (direction sin).
]

{ #category : 'as yet unclassified' }
Vector >> collisionBetween: aRectangle and: anotherRectangle [
	"Determina si, moviendo aRectangle según self, colisionaría con
	 anotherRectangle. De ocurrir, retorna un vector con su módulo
	 recortado de tal forma que aRectangle colisione contra anotherRectangle
	 pero no se puperpongan"
	
	(direction between: 0 and: Float halfPi) ifTrue: [
		^ self collisionBottomRightBetween: aRectangle and: anotherRectangle ].
	(direction between: Float halfPi and: Float pi) ifTrue: [
		^ self collisionBottomLeftBetween: aRectangle and: anotherRectangle ].
	(direction between: Float pi and: Float pi + Float halfPi) ifTrue: [
		^ self collisionTopLeftBetween: aRectangle and: anotherRectangle ].
	^ self collisionTopRightBetween: aRectangle and: anotherRectangle.
]

{ #category : 'as yet unclassified' }
Vector >> collisionBottomLeftBetween: aRectangle and: anotherRectangle [

	"Privado. Ya sabiendo que hay una posible colisión entre aRectangle y
	 anotherRectangle, obtiene el vector resultante o retorna nil"
	
	|diff vector p collisionArea|
	
	collisionArea := Rectangle origin: ((aRectangle origin x + xComponent) @ (aRectangle origin y))
			corner: ((aRectangle corner x)@(aRectangle corner y + yComponent)).
	(collisionArea intersects: anotherRectangle) ifFalse: [ ^nil ].
	
	(anotherRectangle corner x <= aRectangle origin x) ifTrue: [
		diff := aRectangle origin x - anotherRectangle corner x.
		vector := Vector xMagnitude: diff direction: direction.
		p := anotherRectangle origin y - vector y.
		(p > aRectangle corner y) ifTrue: [
			"COLISION por ABAJO a la izquierda"
			diff := anotherRectangle origin y - aRectangle corner y.
			^ Vector yMagnitude: diff direction: direction.
		].
		(p + anotherRectangle height < aRectangle origin y) ifTrue: [ ^nil ].  "<= SIN COLISION"
		^ vector.
	] ifFalse: [
		"Posible colisión por debajo"
		diff := anotherRectangle origin y - aRectangle corner y.
		vector := Vector yMagnitude: diff direction: direction.
		p := anotherRectangle origin x + vector x.
		(p > aRectangle corner x) ifTrue: [
			^nil
		].
		^vector
	].
]

{ #category : 'as yet unclassified' }
Vector >> collisionBottomRightBetween: aRectangle and: anotherRectangle [

	"Privado. Ya sabiendo que hay una posible colisión entre aRectangle y
	 anotherRectangle, obtiene el vector resultante o retorna nil"
	
	|diff vector p collisionArea|
	
	collisionArea := Rectangle origin: (aRectangle origin)
			corner: ((aRectangle corner x + xComponent)@(aRectangle corner y + yComponent)).
	(collisionArea intersects: anotherRectangle) ifFalse: [ ^nil ].
	
	(anotherRectangle origin x >= aRectangle corner x) ifTrue: [
		"COLISION por derecha"
		diff := anotherRectangle origin x - aRectangle corner x.
		vector := Vector xMagnitude: diff direction: direction.
		p := anotherRectangle origin y - vector y.
		(p > aRectangle corner y) ifTrue: [
			"COLISION por ABAJO a la derecha"
			diff := anotherRectangle origin y - aRectangle corner y.
			^ Vector yMagnitude: diff direction: direction.
		].
		(p + anotherRectangle height < aRectangle origin y) ifTrue: [ ^nil ].  "<= SIN COLISION"
		^ vector.
	] ifFalse: [
		"Posible colisión por debajo"
		diff := anotherRectangle origin y - aRectangle corner y.
		vector := Vector yMagnitude: diff direction: direction.
		p := anotherRectangle corner x - vector x.
		(p < aRectangle origin x) ifTrue: [
			^nil
		].
		^vector
	].
]

{ #category : 'as yet unclassified' }
Vector >> collisionTopLeftBetween: aRectangle and: anotherRectangle [

	"Privado. Ya sabiendo que hay una posible colisión entre aRectangle y
	 anotherRectangle, obtiene el vector resultante o retorna nil"
	
	|diff vector p collisionArea|
	
	collisionArea := Rectangle origin: ((aRectangle origin x + xComponent) @ (aRectangle origin y + yComponent))
			corner: aRectangle corner.
	(collisionArea intersects: anotherRectangle) ifFalse: [ ^nil ].
	
	(anotherRectangle corner x <= aRectangle origin x) ifTrue: [
		"COLISION por izquierda"
		diff := aRectangle origin x - anotherRectangle corner x.
		vector := Vector xMagnitude: diff direction: direction.
		p := anotherRectangle corner y + vector y.
		(p < aRectangle origin y) ifTrue: [
			"COLISION por ARRIBA a la izquierda"
			diff := aRectangle origin y - anotherRectangle corner y.
			^ Vector yMagnitude: diff direction: direction.
		].
		(p - anotherRectangle height > aRectangle corner y) ifTrue: [ ^nil ].  "<= SIN COLISION"
		^ vector.
	] ifFalse: [
		"Posible colisión por arriba"
		diff := aRectangle origin y - anotherRectangle corner y.
		vector := Vector yMagnitude: diff direction: direction.
		p := anotherRectangle origin x + vector x.
		(p > aRectangle corner x) ifTrue: [
			^nil
		].
		^vector
	].
]

{ #category : 'as yet unclassified' }
Vector >> collisionTopRightBetween: aRectangle and: anotherRectangle [

	"Privado. Ya sabiendo que hay una posible colisión entre aRectangle y
	 anotherRectangle, obtiene el vector resultante o retorna nil"
	
	|diff vector p collisionArea|
	
	collisionArea := Rectangle origin: ((aRectangle origin x) @ (aRectangle origin y + yComponent))
			corner: ((aRectangle corner x + xComponent)@(aRectangle corner y)).
	(collisionArea intersects: anotherRectangle) ifFalse: [ ^nil ].
	
	(anotherRectangle origin x >= aRectangle corner x) ifTrue: [
		"COLISION por derecha"
		diff := anotherRectangle origin x - aRectangle corner x.
		vector := Vector xMagnitude: diff direction: direction.
		p := anotherRectangle corner y + vector y.
		(p < aRectangle origin y) ifTrue: [
			"COLISION por ARRIBA a la derecha"
			diff := aRectangle origin y - aRectangle corner y.
			^ Vector yMagnitude: diff direction: direction.
		].
		(p - anotherRectangle height > aRectangle corner y) ifTrue: [ ^nil ].  "<= SIN COLISION"
		^ vector.
	] ifFalse: [
		"Posible colisión por arriba"
		diff := aRectangle origin y - anotherRectangle corner y.
		vector := Vector yMagnitude: diff direction: direction.
		p := anotherRectangle corner x - vector x.
		(p < aRectangle origin x) ifTrue: [
			^nil
		].
		^vector
	].
]

{ #category : 'accessing' }
Vector >> direction [

	^ direction
]

{ #category : 'accessing' }
Vector >> direction: aNumber [

	direction := aNumber.
	self calculateComponents.
]

{ #category : 'initialization' }
Vector >> initialize [ 
	" Necesario para que, al crear un vector,
	  se pueda calcular sus componentes."
	
	direction := 0.
]

{ #category : 'transformations' }
Vector >> invert [
	"Retorna un Vector con mismo módulo pero dirección opuesta"
	
	| d |
	d := direction + Float pi.
	(d > Float twoPi) ifTrue: [ d := d - Float twoPi ].
	^ Vector module: module direction: d.
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

	module := arg1.
	self calculateComponents.
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

{ #category : 'as yet unclassified' }
Vector >> toPoint [

	"Retorna el punto que determina el vector en
	 representación polar"
	
	^ xComponent @ yComponent.
]

{ #category : 'as yet unclassified' }
Vector >> translateCorner: aRectangle [
	"Retorna un nuevo objeto Rectangle, habiendo translada el punto corner
	 la distancia y dirección que indica el vector."
	
	^Rectangle origin: (aRectangle origin) corner: (aRectangle corner + self).
]

{ #category : 'accessing - structure variables' }
Vector >> x [
	"Retorna la componente X del vector."
	
	^xComponent.
]

{ #category : 'accessing - structure variables' }
Vector >> y [
	"Retorna la componente Y del vector."
	
	^yComponent.
]
