Class {
	#name : 'GameDemoAnimatedEntity',
	#superclass : 'GameEnginePlatform',
	#instVars : [
		'player1'
	],
	#category : 'SantiagoDemoGame',
	#package : 'SantiagoDemoGame'
}

{ #category : 'accessing' }
GameDemoAnimatedEntity class >> start [

	^ self new start.
]

{ #category : 'as yet unclassified' }
GameDemoAnimatedEntity >> gameLogic [

]

{ #category : 'initialization' }
GameDemoAnimatedEntity >> initialize [

	| layer animation |
	super initialize.
	animation := Animation new.
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 16@16 corner: 51@79 delta: 0@0)).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 61@16 corner: 98@79 delta: 0@0)).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 108@16 corner: 141@79 delta: 0@0)).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 151@16 corner: 188@79 delta: 0@0)).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 197@16 corner: 233@79 delta: 0@0)).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 240@16 corner: 277@79 delta: 0@0)).
	player1 := AnimatedEntity new: '2dcharacterSprite.png' render: renderer.
	player1 addAnimation: animation.
	player1 setPosition: 100@100.
	"ground := StaticEntity new: 'grounds.jpg' render: renderer.
	ground rectCut: (Rectangle origin: 0@2152 corner: 5004@2751) delta: (0)@(0).
	ground setPosition:(0,300)."
	layer := Layer new.
	scene addLayer: layer;
		"add: ground intoLayer: 1;"
		add: player1 intoLayer:1.
]
