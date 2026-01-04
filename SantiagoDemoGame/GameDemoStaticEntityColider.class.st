Class {
	#name : 'GameDemoStaticEntityColider',
	#superclass : 'GameEnginePlatform',
	#instVars : [
		'player1'
	],
	#category : 'SantiagoDemoGame',
	#package : 'SantiagoDemoGame'
}

{ #category : 'accessing' }
GameDemoStaticEntityColider class >> start [

	^ self new start.
]

{ #category : 'as yet unclassified' }
GameDemoStaticEntityColider >> gameLogic [

]

{ #category : 'initialization' }
GameDemoStaticEntityColider >> initialize [

	| layer ground column collider|
	super initialize.
	player1 := StaticEntity new: '2dcharacterSprite.png' render: renderer.
	player1 rectCut: (Rectangle origin: 16@16 corner: 51@79) delta: -14@(-60).
	player1 setPosition: 100@390.
	collider := Collider newPosition: player1 getPosition.
	collider addSectorOrigin: 19@19 corner: 48@76 delta: (-14)@(-60).
	collider setSolid: true.
	player1 setCollider: collider.
	"player1 setDirection: (Vector module: 10 direction: 0)."
	
	column := StaticEntity new: 'columna.png' render: renderer.
	column rectCut: (Rectangle origin: 0@0 corner: 86@186) delta: (-43)@(-186).
	column setPosition: 300@400.
	collider := Collider newPosition: column getPosition.
	collider addSectorOrigin: 0@0 corner: 83@183 delta: (-43)@(-186).
	collider setSolid: true.
	column setCollider: collider. 
	
	ground := StaticEntity new: 'grounds.jpg' render: renderer.
	ground rectCut: (Rectangle origin: 0@2152 corner: 5004@2751) delta: (0)@(0).
	ground setPosition:(0@280).
	
	layer := Layer new.
	scene addLayer: layer;
		add: ground intoLayer: 1.
	layer := Layer new.
	scene addLayer: layer;
		add: player1 intoLayer:2;
		add: column intoLayer:2.
]

{ #category : 'as yet unclassified' }
GameDemoStaticEntityColider >> onKeyPressEvent: anEvent [

	"Arriba"
	(anEvent scanCode = 82 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float halfPi + Float pi))].
	
	"Abajo"
	(anEvent scanCode = 81 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float halfPi))].
	
	"Derecha"
	(anEvent scanCode = 79 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(0))].
	
	"Izquierda"
	(anEvent scanCode = 80 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float pi))].
]
