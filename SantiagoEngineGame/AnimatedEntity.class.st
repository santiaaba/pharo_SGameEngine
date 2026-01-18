"
## Animaciones

Las animaciones están formadas por Frames. Cada animación dura 1 segundo. Así, si una animación está conformada por 2 frames, cada uno debe ser renderizado con 0,5 segundos de diferencia. Si una animación está formada por 20 frames, cada uno deber ser renderizado con 0,05 segundos de diferencia entre ellos. A esto se le suma el deltaTime del Engine, que representa en milisegundos el tiempo en que el motor renderiza cada Fotograma en pantalla.

## Boundary y AnimatedBoundary
Tenemos dos boundary. El del frame actual y el de la animación toda (el boundary que circunscribe a todos los frames). El primero es utilizado para detectar colisiones. El segundo para determinar si una entidad ha salido por completo de la cámara o está ingresando a la misma.
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
	"Retorna el Rectangle que ocupa en la escena el frame
	 actual de la animación en curso."
	
	^currentAnimation getFrame getRectDelta getRectTranslateTo: position
]

{ #category : 'undo - undo' }
AnimatedEntity >> do: aGameEngine [
	"Realiza acciones propias de una entidad animada"
	
	(super do: aGameEngine) ifTrue: [
		| c |
		c := currentAnimation getFrameAndNext getCollider.
		c ifNotNil: [ c actualizePosition: position]
	]
]

{ #category : 'as yet unclassified' }
AnimatedEntity >> draw: aRenderer using: aCamera [
	" Dibuja la entidad en base a la animación actualmente seleccionada"
	
	| frame rectCut rectDraw|
	frame := currentAnimation getFrameAndNext.
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
	
	| frame rectDraw |
	super drawDebug: aRenderer using: aCamera.
	frame := currentAnimation getFrameAndNext.
	rectDraw := (frame getRectTranslateTo: position) translateBy: aCamera viewport getRect origin.
	aRenderer color: Color yellow;
		drawRectangle: rectDraw.
	aRenderer color: Color white.
]

{ #category : 'accessing' }
AnimatedEntity >> getCollider [
	"Retorna el collider en base al frame actual.
	 Cada frame tiene su propio collider."
	
	 ^currentAnimation getFrame.
]

{ #category : 'as yet unclassified' }
AnimatedEntity >> getMaxBoundary [
	"Retorna el Rectángulo que circunscribe a todos los frames de
	 la animación en curso. "
	
	^currentAnimation getAnimationBoundary: position
]

{ #category : 'initialization' }
AnimatedEntity >> initialize [

	super initialize.
	animations := OrderedCollection new.
	currentAnimation := nil.
]

{ #category : 'initialization' }
AnimatedEntity >> setAnimationIndex: anIndex [
	"Determina cual de todas las animaciones que reconoce la entidad
	 es la que se debe comenzar a utilizar."
	
	currentAnimation := animations at: anIndex.
]
