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

	| layer ground|
	super initialize.
	player1 := StaticEntity new: 'character1.png' render: renderer.
	player1 rectCut: (Rectangle origin: 210@36 corner: 323@326) delta: (-56)@(-145).
	player1 setPosition: 100@100.
	ground := StaticEntity new: 'grounds.jpg' render: renderer.
	ground rectCut: (Rectangle origin: 0@2152 corner: 5004@2751) delta: (0)@(0).
	ground setPosition:(0,300).
	layer := Layer new.
	scene addLayer: layer;
		add: ground intoLayer: 1;
		add: player1 intoLayer:1.
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
