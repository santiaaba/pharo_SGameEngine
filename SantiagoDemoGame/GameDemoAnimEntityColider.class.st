Class {
	#name : 'GameDemoAnimEntityColider',
	#superclass : 'GameEnginePlatform',
	#instVars : [
		'player1'
	],
	#category : 'SantiagoDemoGame',
	#package : 'SantiagoDemoGame'
}

{ #category : 'accessing' }
GameDemoAnimEntityColider class >> start [

	^ self new start.
]

{ #category : 'as yet unclassified' }
GameDemoAnimEntityColider >> gameLogic [

]

{ #category : 'initialization' }
GameDemoAnimEntityColider >> initialize [

	| layer animation ground column|
	super initialize.
	animation := Animation new
	addFrame: (Frame new setRectDelta: (RectDelta origin: 16@16 corner: 51@79 delta: -14@(-60)));
	addFrame: (Frame new setRectDelta: (RectDelta origin: 61@16 corner: 98@79 delta: -14@(-60)));
	addFrame: (Frame new setRectDelta: (RectDelta origin: 108@16 corner: 141@79 delta: -14@(-60)));
	addFrame: (Frame new setRectDelta: (RectDelta origin: 151@16 corner: 188@79 delta: -14@(-60)));
	addFrame: (Frame new setRectDelta: (RectDelta origin: 197@16 corner: 233@79 delta: -14@(-60)));
	addFrame: (Frame new setRectDelta: (RectDelta origin: 240@16 corner: 277@79 delta: -14@(-60)));
	setSpeedFactor: 1.3.
	player1 := AnimatedEntity new: '2dcharacterSprite.png' render: renderer.
	player1 addAnimation: animation.
	player1 setPosition: 100@390.
	
	column := StaticEntity new: 'columna.png' render: renderer.
	column rectCut: (Rectangle origin: 0@0 corner: 86@186) delta: (-43)@(-186).
	column setPosition: 300@400.
	
	ground := StaticEntity new: 'grounds.jpg' render: renderer.
	ground rectCut: (Rectangle origin: 0@2152 corner: 5004@2751) delta: (0)@(0).
	ground setPosition:(0,280).
	
	layer := Layer new.
	scene addLayer: layer;
		add: ground intoLayer: 1.
	layer := Layer new.
	scene addLayer: layer;
		add: player1 intoLayer:2;
		add: column intoLayer:2.
]

{ #category : 'as yet unclassified' }
GameDemoAnimEntityColider >> onKeyPressEvent: anEvent [

	"Arriba"
	(anEvent scanCode = 82 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float halfPi + Float pi))].
	
	"Abajo"
	(anEvent scanCode = 81 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float halfPi))].
	
	"Derecha"
	(anEvent scanCode = 79 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(0))].
	
	"Izquierda"
	(anEvent scanCode = 80 ) ifTrue: [ player1 addDirection: (Vector module:1  direction:(Float pi))].
]
