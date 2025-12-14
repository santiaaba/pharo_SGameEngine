"
Represento un rectángulo que posee un delta respecto de las coordenadas superior izquierda respecto de un punto.
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
RectDelta class >> rect: aSDLRect delta: aPointer [

	^ (self new setRect: aSDLRect) setDelta: aPointer.
]

{ #category : 'converting' }
RectDelta >> asRectTranslated: aPoint [

	"Devuelve un SDL_rect ya transladado al punto indicado
	 por parámetro y habiendole aplicado el delta"
	
	^(rect translateBy: aPoint + aPoint).
]

{ #category : 'as yet unclassified' }
RectDelta >> getDelta [

	^ delta
]

{ #category : 'as yet unclassified' }
RectDelta >> getRect [

	^ rect
]

{ #category : 'initialization' }
RectDelta >> setDelta: aPointer [

	delta := aPointer
]

{ #category : 'initialization' }
RectDelta >> setRect: aEngineRectangle [

	rect := aEngineRectangle
]

{ #category : 'actions' }
RectDelta >> translateTo: arg1 [

	^ (rect translateTo: arg1) translateBy: delta
]
