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
	"Retorna el rectángulo. El cual ya tiene aplicado el delta. Ya que
	 al trasladarlo le aplicamos el delta."

	^ rect
]

{ #category : 'actions' }
RectDelta >> getRectTranslateTo: aPoint [
	"Retorna un objecto Rectangle transladado el mismo
	 al punto que resulta de aPoint + delta"
	
	| with height p |
	with := rect width.
	height := rect height.
	p := aPoint + delta.
	^Rectangle origin: (aPoint + delta) corner: (with + p x)@(height + p y)
	 
]

{ #category : 'actions' }
RectDelta >> merge: aRectDelta [
	"Retorna un nuevo RectDelta resultado de circunscribir
	 los dos rectángulos. El delta se obtiene considerando que
	 los dos rectángulos poseen un mismo punto de referencia
	 desde el cual arrancaría el punto origin."
	
	|r d|
	r := rect merge: (aRectDelta getRect).
	
	"El delta será el punto resultante del X más a
	 la izquierda (el menor X) y el Y más arriba (el menor Y)"
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
	
	| with height p |
	with := rect width.
	height := rect height.
	p := aPoint + delta.
	rect := Rectangle origin: (aPoint + delta) corner: (with + p x)@(height + p y)
	 
]
