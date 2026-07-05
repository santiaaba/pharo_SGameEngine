Class {
	#name : 'Prehistorik3',
	#superclass : 'GameEnginePlatform',
	#category : 'SantiagoDemoGame',
	#package : 'SantiagoDemoGame'
}

{ #category : 'accessing' }
Prehistorik3 class >> start [

	^ self new start.
]

{ #category : 'initialization' }
Prehistorik3 >> initialize [

	"| layer player ground collider animation |"
	super initialize.
	scene loadFrom: 'scene1.dat'.
	"
	ground := StaticEntity new: 'grounds.jpg' render: renderer.
	ground rectCut: (Rectangle origin: 0@2152 corner: 5004@2751) delta: (0)@(0).
	ground setPosition:(0@280).
	collider := Collider newPosition: ground getPosition.
	collider addSectorOrigin: 0@0 corner: 600@20 delta: (0)@(80).
	collider setSolid: true.
	ground setCollider: collider.
	layer := Layer new.
	
	scene addLayer: layer;
	add: ground intoLayer: 1.
	
	player := AnimatedEntity new:'player.png' render: renderer.
	animation := Animation new.
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 348@10 corner: 375@45 delta:(-10)@(-35))).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 317@10 corner: 343@45 delta:(-10)@(-35))).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 289@10 corner: 312@45 delta:(-10)@(-35))).
	animation addFrame: (Frame new setRectDelta: (RectDelta origin: 317@10 corner: 343@45 delta:(-10)@(-35))).
	animation setSpeedFactor: 1.4.
	player addAnimation: animation.
	player setPosition: 100@100.
	
	scene add: player intoLayer: 1.
	scene saveOn: 'scene1.dat'.
	"
]
