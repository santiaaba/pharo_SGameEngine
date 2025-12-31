"
Represento un conjunto de áreas de colisión.
"
Class {
	#name : 'Collider',
	#superclass : 'Object',
	#instVars : [
		'boundary',
		'sectors',
		'position',
		'lastPosition'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
Collider class >> newPosition: aPoint [

	^self new setPosition: aPoint.
]

{ #category : 'as yet unclassified' }
Collider >> actualize [

	boundary translateTo: position
]

{ #category : 'as yet unclassified' }
Collider >> actualizeSectors [

	position = lastPosition ifFalse: [
		lastPosition = position deepCopy.
		sectors do: [ :arg1 | arg1 translateTo: position ] ]
]

{ #category : 'adding' }
Collider >> addSectorOrigin: anOrigin corner: aCorner delta: aDelta [
	"Agrego un sector al collider. El delta siempre se ha de considerar respecto
	 del punto que determina la posición del collider. Generalmente vamos
	 a desear que dicho punto concida con el de la Entity que utiliza el collider."

	sectors add: (RectDelta origin: anOrigin corner: aCorner delta: aDelta).
	self recalculateBoundary.
]

{ #category : 'accessing' }
Collider >> boundary [

	^ boundary translateTo: position
]

{ #category : 'as yet unclassified' }
Collider >> collisionTo: arg1 [

	| tmp1 |
	(self boundary intersect: arg1 boundary) ifTrue: [
		self actualizeSectors.
		arg1 actualizeSectors.
		tmp1 := sectors
			        search: [ :arg2 :arg3 | arg2 intersect: arg3 ]
			        into: arg1 sectors ].
	^ tmp1
]

{ #category : 'initialization' }
Collider >> initialize [
	"Inicializa la estructura del collider. A Priori su boundary
	 es simplemente un rectángulo nulo. A medida que se van agregando
	 secciones, el boundary va creciendo circunscribiéndu las secciones."
	
	boundary := nil.
	sectors := OrderedCollection new.
	lastPosition := 0@0
]

{ #category : 'as yet unclassified' }
Collider >> recalculateBoundary [
	"En base a los sectores del collider, recalcula el boundary que
	 los circunscribe. Para ello, previamente situa todos los
	 sectores donde corresponde según la posición del colider."
	
	| b |
	b := nil.
	sectors do: [ :s |
		s translateTo: position.
		b ifNil: [ b := s ] ifNotNil:[ b := b merge: s].
	].
	boundary := b.
]

{ #category : 'accessing' }
Collider >> sectors [

	^ sectors
]

{ #category : 'initialization' }
Collider >> setPosition: aPoint [

	position := aPoint
]
