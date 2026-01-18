"
Represento un rectángulo que posee un delta respecto de las coordenadas superior izquierda respecto de un punto. Ésto permite posicionarme respecto de un punto que no tiene por que ser el corner superior izquierdo.

Se puede decir que el delta en mi centro.

Generalmente se solicita el rectángulo resultante de transladar el punto superior izquierdo e inferior derecho lo que indica el delta. Pero esto es poco eficiente si hay que hacerlo varias veces. Por ello, mantengo dicho rectángulo resultante listo para ser retornado sin cálculos previos.
"
Class {
	#name : 'RectDelta',
	#superclass : 'Object',
	#instVars : [
		'rect',
		'delta'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'as yet unclassified' }
RectDelta class >> origin: anOriginPoint corner: aCornerPoint delta: aDeltaPoint [

	^ self rect: (Rectangle origin: anOriginPoint corner: aCornerPoint) delta: aDeltaPoint
]

{ #category : 'as yet unclassified' }
RectDelta class >> rect: aRectangle delta: aPointer [

	^ (self new setRect: aRectangle) setDelta: aPointer.
]

{ #category : 'as yet unclassified' }
RectDelta >> getDelta [
	"Retorna el delta"

	^ delta
]

{ #category : 'as yet unclassified' }
RectDelta >> getRect [
	"Retorna el rectángulo. Si se utiliza previamente translateTo: o translateBy:,
	 el rectángulo obtenido por este método ya se encontrará en las coordenadas
	 correctas"

	^ rect
]

{ #category : 'actions' }
RectDelta >> getRectTranslateTo: aPoint [
	"Retorna un objecto Rectangle transladado el mismo
	 al punto que resulta de aPoint + delta"
	
	| p |
	p := aPoint + delta.
	^Rectangle origin: p corner: (rect width + p x)@(rect height + p y)
	 
]

{ #category : 'actions' }
RectDelta >> merge: aRectDelta [
	"Retorna un nuevo RectDelta resultado de circunscribir
	 los dos rectángulos.
	 El delta para el rectDelta resultante se calcula como:
	 El delta el menor x y el delta del menor y."
	
	| r d |
	r := rect merge: (aRectDelta getRect).
	d := (delta x min:(aRectDelta getDelta x))@(delta y min:(aRectDelta getDelta y)).
	^ RectDelta rect: r delta: d.
]

{ #category : 'initialization' }
RectDelta >> setDelta: aPointer [
	"Asigna un delta"

	delta := aPointer.
]

{ #category : 'initialization' }
RectDelta >> setRect: aRectangle [
	"asigna un rectángulo"

	rect := aRectangle.
]

{ #category : 'actions' }
RectDelta >> translateBy: factor [
	"traslada el rectángulo aplicando un factor pasado como
	 parámetro. No es necesario aplicar el delta."
	
	rect := rect translateBy: factor.
]

{ #category : 'actions' }
RectDelta >> translateTo: aPoint [
	"Translada el rectangulo al punto aPoint aplicando el delta."
	
	rect := self getRectTranslateTo: aPoint
	 
]
