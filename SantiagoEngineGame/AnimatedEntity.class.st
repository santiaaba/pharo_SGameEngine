"
## Animaciones

Las animaciones están formadas por Frames. Cada animación dura 1 segundo. Así, si una animación está conformada por 2 frames, cada uno debe ser renderizado con 0,5 segundos de diferencia. Si una animación está formada por 20 frames, cada uno deber ser renderizado con 0,05 segundos de diferencia entre ellos. A esto se le suma el deltaTime del Engine, que representa en milisegundos el tiempo en que el motor renderiza cada Fotograma en pantalla.
"
Class {
	#name : 'AnimatedEntity',
	#superclass : 'Entity',
	#instVars : [
		'animations',
		'currentAnimation'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'adding' }
AnimatedEntity >> addAnimation: anAnimation [
	"Agrega una animación a la coleccion de animaciones."
	
	animations add: anAnimation.
	(animations size = 1) ifTrue: [ currentAnimation := anAnimation ]
]

{ #category : 'accessing' }
AnimatedEntity >> boundary [

	^currentAnimation getFrame getRectDelta getRectTranslateTo: position
]

{ #category : 'as yet unclassified' }
AnimatedEntity >> draw: aRenderer using: aCamera [
	" Dibuja la entidad en base a la animación actualmente seleccionada"
	
	| frame rectCut rectDraw|
	frame := currentAnimation getFrame.
	rectCut := frame getRectDelta getRect.
	rectDraw := (frame getRectTranslateTo: position) translateBy: aCamera viewport getRect origin.
	aRenderer drawTexture: texture rectangle: rectCut in: rectDraw.
	Entity debug ifTrue: [ self drawDebug: aRenderer using: aCamera ]
	
	
]

{ #category : 'as yet unclassified' }
AnimatedEntity >> drawDebug: aRenderer using: aCamera [
	"Dibujamos lo siguiente como rectángulos en este oreden:
	 - Rectángulo que circunscribe el sprite
	 - posición del elemento
	 - Coliders si es que tiene"
	
	| rect |
		
	rect := Rectangle origin: position corner: (position + (5@5)).
	rect := rect translateBy: aCamera viewport getRect origin.
	"Transcript show: aCamera viewport getRect origin; cr."
	aRenderer color: Color red;
		drawRectangle: rect.
		
	aRenderer color: Color white.
]

{ #category : 'initialization' }
AnimatedEntity >> initialize [

	super initialize.
	animations := OrderedCollection new.
	currentAnimation := nil.
]

{ #category : 'initialization' }
AnimatedEntity >> setAnimationIndex: anIndex [

	currentAnimation := animations at: anIndex.
]
