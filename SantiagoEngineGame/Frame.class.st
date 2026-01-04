"
Soy un fram de una animación. Represento un cuadro de animación.

## RectDelta
Ofrezco tanto el rectángulo de recorte en el sprite como lo necesario para calcular el rectángulo donde pegarlo en el screen. Para ello tengo un rectDelta. Del mismo obtengo el rectángulo que es la zona de recorte en el sprite. El delta determina la posición relativa del mismo rectángulo en base a la posición de la entidad en la escena.

## Colider
Mi atributo collider indica mediante el objeto Collider, cuales son mis secciones a detectar colisiones.
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
Frame >> getCollider [

	^ collider
]

{ #category : 'accessing' }
Frame >> getRectDelta [

	^ rectCut
]

{ #category : 'accessing' }
Frame >> getRectTranslateTo: aPoint [

	^ rectCut getRectTranslateTo: aPoint
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

{ #category : 'actions' }
Frame >> save: arg1 [

	arg1
		nextPutAll: rectCut origin x asFloat asIEEE32BitWord asByteArray;
		nextPutAll: rectCut origin y asFloat asIEEE32BitWord asByteArray;
		nextPutAll: rectCut corner x asFloat asIEEE32BitWord asByteArray;
		nextPutAll: rectCut origin y asFloat asIEEE32BitWord asByteArray
]

{ #category : 'as yet unclassified' }
Frame >> setRectDelta: aRectDelta [

	rectCut := aRectDelta.
]
