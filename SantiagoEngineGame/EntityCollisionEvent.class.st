"
Represento un evento de colisión entre dos entidades.
"
Class {
	#name : 'EntityCollisionEvent',
	#superclass : 'EntityEvent',
	#instVars : [
		'anotherEntity',
		'colliderOrigin',
		'colliderTarget'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
EntityCollisionEvent class >> newEvent: anEntity collisionTo: anotherEntity colliderOrigin: aCollider colliderTarget: anotherCollider [

	^self new setEntity: anEntity;
		setAnotherEntity: anotherEntity;
		setColliderOrigin: aCollider;
		setColliderTarget: anotherCollider.
]

{ #category : 'initialization' }
EntityCollisionEvent >> setAnotherEntity: anEntity [ 

	anotherEntity := anEntity.
]

{ #category : 'initialization' }
EntityCollisionEvent >> setColliderOrigin: aCollider [

	colliderOrigin := aCollider.
]

{ #category : 'initialization' }
EntityCollisionEvent >> setColliderTarget: aCollider [

	colliderTarget := aCollider.
]
