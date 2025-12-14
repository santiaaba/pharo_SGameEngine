Class {
	#name : 'EngineEventHandle',
	#superclass : 'OSWindowEventVisitor',
	#instVars : [
		'engine'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'initialization' }
EngineEventHandle >> setEngine: anEngine [

	engine := anEngine
]

{ #category : 'visiting' }
EngineEventHandle >> visitKeyDownEvent: anEvent [

	engine onKeyPressEvent: anEvent.
]

{ #category : 'visiting' }
EngineEventHandle >> visitWindowCloseEvent: anEvent [

	engine stop
]
