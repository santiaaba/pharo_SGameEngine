Class {
	#name : 'GameDemo1',
	#superclass : 'GameEngine',
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

	player1 move: 1@1.
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
