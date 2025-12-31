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
	"Dibuja la parte de la esena visualizada por la cámara.
	 De momento, recorre la colección de entidades, enviado
	 a redibujar solo aquellas donde el recuadro que circunscribe
	 su sprite setán total o parcialmente dentro de la cámara"

	| i |
	entities do:[ :entity | 
		i := aCamera viewport getRect.
		(i intersects: entity boundary) ifTrue: [
				entity draw: aRenderer using: aCamera
			]]
]
