Class {
	#name : 'GameDemo1Camera',
	#superclass : 'GameDemo1',
	#category : 'SantiagoDemoGame',
	#package : 'SantiagoDemoGame'
}

{ #category : 'as yet unclassified' }
GameDemo1Camera >> onKeyPressEvent: anEvent [

	"Arriba"
	(anEvent scanCode = 82 ) ifTrue: [ scene translateCameraBy: (Vector module:1  direction:(Float halfPi + Float pi))].
	
	"Abajo"
	(anEvent scanCode = 81 ) ifTrue: [ scene translateCameraBy: (Vector module:1  direction:(Float halfPi))].
	
	"Derecha"
	(anEvent scanCode = 79 ) ifTrue: [ scene translateCameraBy: (Vector module:1  direction:(0))].
	
	"Izquierda"
	(anEvent scanCode = 80 ) ifTrue: [ scene translateCameraBy: (Vector module:1  direction:(Float pi))].
]
