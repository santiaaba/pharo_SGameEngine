Class {
	#name : 'GameEngine',
	#superclass : 'Object',
	#instVars : [
		'stop',
		'scene',
		'renderer',
		'window'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'start' }
GameEngine class >> debug: aBoolean [

	Entity debug: aBoolean
]

{ #category : 'as yet unclassified' }
GameEngine >> gameLogic [

	^ self subclassResponsibility.
]

{ #category : 'initialization' }
GameEngine >> initialize [ 

	|windowAttr|
	
	windowAttr := OSWindowAttributes new.
	windowAttr
		extent: 640 @ 480;
		resizable: false;
		windowCentered: true.
	window := OSWindowAnimated createWithAttributes: windowAttr.
	renderer := window newGenericRenderer.
	scene := Scene new.
	stop := false.
	window eventHandler: (EngineEventHandle new setEngine: self).
]

{ #category : 'accessing' }
GameEngine >> renderer [

	^ renderer
]

{ #category : 'initialization' }
GameEngine >> setScene: aScene [

	scene := aScene
]

{ #category : 'accessing' }
GameEngine >> start [

	[  stop ] whileFalse: [
		self gameLogic.
		renderer color: Color white; clear.
		scene redraw: renderer.
		renderer present.
		(Delay forMilliseconds: 33) wait 
	 ]
]

{ #category : 'accessing' }
GameEngine >> stop [

	stop := true
]
