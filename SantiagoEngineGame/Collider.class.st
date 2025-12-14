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

{ #category : 'accessing' }
Collider class >> position: aPoint [

	^ self new setPosition: aPoint
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
Collider >> addSector: aRectDelta [

	sectors add: aRectDelta.
	boundary merge: aRectDelta.
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

	boundary := RectDelta
		            rect: (Rectangle origin: 0 @ 0 corner: 0 @ 0)
		            delta: 0 @ 0.
	sectors := OrderedCollection new.
	lastPosition := 0 @ 0
]

{ #category : 'accessing' }
Collider >> sectors [

	^ sectors
]

{ #category : 'initialization' }
Collider >> setBoundary: aRectDelta [

	boundary := aRectDelta
]

{ #category : 'initialization' }
Collider >> setPosition: aPoint [

	position := aPoint
]
