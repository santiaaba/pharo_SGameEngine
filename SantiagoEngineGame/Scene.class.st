Class {
	#name : 'Scene',
	#superclass : 'Object',
	#instVars : [
		'layers',
		'ground',
		'player',
		'camera',
		'gravity'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'adding' }
Scene >> add: anEntity intoLayer: index [

	(layers at: index) add: anEntity.
]

{ #category : 'adding' }
Scene >> addLayer: aLayer [

	layers add: aLayer
]

{ #category : 'undo - undo' }
Scene >> do [

	layers do: [ :arg1 |
		arg1
			doInPairs: [ :arg2 :arg3 | arg2 collisionTo: arg3 ];
			do: [ :arg4 | arg4 do ] ]
]

{ #category : 'initialization' }
Scene >> initialize [

	layers := OrderedCollection new.
	camera := Camera new.
	gravity := Vector module: 0 direction: 0.
]

{ #category : 'accessing' }
Scene >> layers [

	^layers
]

{ #category : 'private' }
Scene >> loadFrom: arg1 [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := arg1 asFileReference binaryReadStream.
	tmp1 position: 1.
	tmp2 := (tmp1 next: 2) asNumber.
	tmp4 := tmp2.
	0 to: tmp4 do: [ :tmp5 |
		tmp3 := (tmp1 next: 1) asNumber.
		tmp3 = 1
			ifTrue: [ (layers at: 1) add: (AnimatedEntity new load: tmp1) ]
			ifFalse: [ (layers at: 1) add: (StaticEntity new load: tmp1) ] ]
]

{ #category : 'as yet unclassified' }
Scene >> moveCamera: aPoint [

	camera position: aPoint
]

{ #category : 'accessing' }
Scene >> player [

	^ player
]

{ #category : 'as yet unclassified' }
Scene >> redraw: aRenderer [

	layers do: [ :layer |	layer redraw: aRenderer on: camera ]
]

{ #category : 'as yet unclassified' }
Scene >> saveOn: arg1 [

	| tmp1 |
	tmp1 := arg1 asFileReference binaryWriteStream.
	tmp1 position: 1.
	(layers at: 1) do: [ :arg2 | arg2 save: tmp1 ].
	tmp1 close
]

{ #category : 'initialization' }
Scene >> setGravity: aVector [

	gravity := aVector.
]

{ #category : 'initialization' }
Scene >> setPlayer: anEntity [

	player := anEntity
]
