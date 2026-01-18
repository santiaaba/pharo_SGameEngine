"
Represento el resultado de una colisión entre dos rectángulos en dirección de un vector
"
Class {
	#name : 'VectorCollision',
	#superclass : 'Object',
	#instVars : [
		'vector',
		'resultingVector',
		'sideOrigin',
		'sideTarget'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
VectorCollision class >> new: aVector to: anotherVector side: aSide onSide: anotherSide [

	^ (VectorCollision new) vector: aVector; resultingVector: anotherVector; sideOrigin: aSide; sideTarget: anotherSide.
]

{ #category : 'accessing' }
VectorCollision >> resultingVector [

	^ resultingVector
]

{ #category : 'accessing' }
VectorCollision >> resultingVector: anObject [

	resultingVector := anObject
]

{ #category : 'accessing' }
VectorCollision >> sideOrigin [

	^ sideOrigin
]

{ #category : 'accessing' }
VectorCollision >> sideOrigin: anObject [

	sideOrigin := anObject
]

{ #category : 'accessing' }
VectorCollision >> sideTarget [

	^ sideTarget
]

{ #category : 'accessing' }
VectorCollision >> sideTarget: anObject [

	sideTarget := anObject
]

{ #category : 'accessing' }
VectorCollision >> vector [

	^ vector
]

{ #category : 'accessing' }
VectorCollision >> vector: anObject [

	vector := anObject
]
