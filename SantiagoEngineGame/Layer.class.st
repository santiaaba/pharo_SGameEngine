"
Represento una capa del juego en 2D. Tengo un conjunto de elementos que pueden interactuar entre ellos como ser colisionar.
"
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

{ #category : 'accessing' }
Layer >> entities [

	^ entities.
]

{ #category : 'initialization' }
Layer >> initialize [

	entities := OrderedCollection new.
	background := UndefinedClass.
]

{ #category : 'as yet unclassified' }
Layer >> redraw: aRenderer on: aCamera [
	"Dibuja la parte de la esena visualizada por la cámara."

	| i |
	entities do:[ :entity | 
		i := aCamera viewport getRect.
		(i intersects: entity getMaxBoundary) ifTrue: [
				entity draw: aRenderer using: aCamera
			]]
]
