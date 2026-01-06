"
Represento una colisión entre dos colliders. Entre mis atributos ofrezco:

- directionVector: El vector dirección a reemplazar por el original para que se produzca la colisión pero no queden superpuestos los coliders. Se utiliza cuando ambos coliders están declarados como solidos.
- originCollider: Es el collider que se mueve gracias al vector dirección y genera la colisión contra el segundo collider.
- targetColider: Es el collider contra el cual choca el originCollider.
- originSector: Es el sector del originCollider que choca contra el targetSector del segundo collider.
- targetSector: Es el sector del targetCollider contra el que choca el originSector.

"
Class {
	#name : 'Collision',
	#superclass : 'Object',
	#instVars : [
		'originalVector',
		'resultingVector',
		'originCollider',
		'originSector',
		'targetCollider',
		'targetSector'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'accessing' }
Collision >> originCollider [

	^ originCollider
]

{ #category : 'initialization' }
Collision >> originCollider: aCollider [

	originCollider := aCollider.
]

{ #category : 'accessing' }
Collision >> originSector [

	^ originSector
]

{ #category : 'initialization' }
Collision >> originSector: aSector [

	originSector := aSector.
]

{ #category : 'accessing' }
Collision >> originalVector [

	^ originalVector
]

{ #category : 'accessing' }
Collision >> originalVector: anObject [

	originalVector := anObject
]

{ #category : 'accessing' }
Collision >> resultingVector [

	^ resultingVector
]

{ #category : 'accessing' }
Collision >> resultingVector: anObject [

	resultingVector := anObject
]

{ #category : 'accessing' }
Collision >> targetCollider [

	^ targetCollider
]

{ #category : 'initialization' }
Collision >> targetCollider: aCollider [

	targetCollider := aCollider.
]

{ #category : 'accessing' }
Collision >> targetSector [

	^ targetSector
]

{ #category : 'initialization' }
Collision >> targetSector: aSector [

	targetSector := aSector.
]
