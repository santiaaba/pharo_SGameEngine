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
		'directionVector',
		'originCollider',
		'originSector',
		'targetCollider',
		'targetSector'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
Collision class >> new: anOriginCollider with: anOriginSector to: aTargetCollider with: aTargetSector using: aVector [

	^ self new setOriginCollider: anOriginCollider;
	  setTargetCollider: aTargetCollider;
	  setOriginSector: anOriginSector;
	  setTargetSector: aTargetSector;
	  setDirectionVector: aVector.
]

{ #category : 'accessing' }
Collision >> directionVector [

	^ directionVector
]

{ #category : 'accessing' }
Collision >> originCollider [

	^ originCollider
]

{ #category : 'accessing' }
Collision >> originSector [

	^ originSector
]

{ #category : 'initialization' }
Collision >> setDirectionVector: aVector [

	directionVector := aVector.
]

{ #category : 'initialization' }
Collision >> setOriginCollider: aCollider [

	originCollider := aCollider.
]

{ #category : 'initialization' }
Collision >> setOriginSector: aSector [

	originSector := aSector.
]

{ #category : 'initialization' }
Collision >> setTargetCollider: aCollider [

	targetCollider := aCollider.
]

{ #category : 'initialization' }
Collision >> setTargetSector: aSector [

	targetSector := aSector.
]

{ #category : 'accessing' }
Collision >> targetCollider [

	^ targetCollider
]

{ #category : 'accessing' }
Collision >> targetSector [

	^ targetSector
]
