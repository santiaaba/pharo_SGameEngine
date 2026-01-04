"
Represento un evento donde dos entidades han dejado de colisionar
"
Class {
	#name : 'EntityLostCollisionEvent',
	#superclass : 'EntityEvent',
	#instVars : [
		'anotherEntity'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
EntityLostCollisionEvent class >> newEvent: anEntity collisionTo: anotherEntity [

	^self new setEntity: anEntity;
		setAnotherEntity: anotherEntity.
]

{ #category : 'initialization' }
EntityLostCollisionEvent >> setAnotherEntity: anEntity [ 

	anotherEntity := anEntity.
]
