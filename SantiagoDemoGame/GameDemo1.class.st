Class {
	#name : 'GameDemo1',
	#superclass : 'GameEnginePlatform',
	#instVars : [
		'player1'
	],
	#category : 'SantiagoDemoGame',
	#package : 'SantiagoDemoGame'
}

{ #category : 'accessing' }
GameDemo1 class >> start [

	^ self new start.
]

{ #category : 'as yet unclassified' }
GameDemo1 >> gameLogic [

]

{ #category : 'initialization' }
GameDemo1 >> initialize [ 

	| layer|
	super initialize.
	player1 := StaticEntity new: 'character1.png' render: renderer.
	player1 rectCut: (Rectangle origin: 210@36 corner: 323@326) delta: 0@0.
	player1 setPosition: 10@10.
	layer := Layer new.
	scene addLayer: layer; add: player1 intoLayer:1.
]

{ #category : 'as yet unclassified' }
GameDemo1 >> onKeyPressEvent: anEvent [

	"Arriba"
	(anEvent scanCode = 82 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float halfPi + Float pi))].
	
	"Abajo"
	(anEvent scanCode = 81 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float halfPi))].
	
	"Derecha"
	(anEvent scanCode = 79 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(0))].
	
	"Izquierda"
	(anEvent scanCode = 80 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float pi))].
]
