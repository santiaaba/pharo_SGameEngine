"
Soy un fram de una animación. Represento un cuadro de animación. Indico la sección de sprite a recortar de la textura. Mi atributo collider indica mediante el objeto Collider, cuales son mis secciones a detectar colisiones.
"
Class {
	#name : 'Frame',
	#superclass : 'Object',
	#instVars : [
		'rectCut',
		'collider'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'accessing' }
Frame >> collider [

	^ collider
]

{ #category : 'initialization' }
Frame >> initialize [ 

	collider := Collider new.
]

{ #category : 'actions api' }
Frame >> load: arg1 [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp3 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp4 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp1 := tmp3 @ tmp4.
	tmp3 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp4 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp2 := tmp3 @ tmp4.
	rectCut origin: tmp1 corner: tmp2
]

{ #category : 'accessing' }
Frame >> rectCut [

	^ rectCut
]

{ #category : 'as yet unclassified' }
Frame >> rectCut: aSDLRect delta: aPointer [

	rectCut := RectDelta rect: aSDLRect delta: aPointer
]

{ #category : 'actions' }
Frame >> save: arg1 [

	arg1
		nextPutAll: rectCut origin x asFloat asIEEE32BitWord asByteArray;
		nextPutAll: rectCut origin y asFloat asIEEE32BitWord asByteArray;
		nextPutAll: rectCut corner x asFloat asIEEE32BitWord asByteArray;
		nextPutAll: rectCut origin y asFloat asIEEE32BitWord asByteArray
]
