Class {
	#name : 'Layer',
	#superclass : 'Object',
	#instVars : [
		'entities',
		'background'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'adding' }
Layer >> add: anEntity [

	entities add: anEntity.
]

{ #category : 'initialization' }
Layer >> initialize [

	entities := OrderedCollection new.
	background := UndefinedClass.
]

{ #category : 'as yet unclassified' }
Layer >> redraw: aRenderer on: aCamera [

	entities do:[ :entity | (aCamera viewport intersects: entity boundary) ifTrue: [
				entity draw: aRenderer using: aCamera
			]]
]
