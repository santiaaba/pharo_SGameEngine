"
Represento un evento genérico sobre una entidad
"
Class {
	#name : 'EntityEvent',
	#superclass : 'Object',
	#instVars : [
		'entity'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'initialization' }
EntityEvent >> setEntity: anEntity [

	entity := anEntity.
]
