"
Soy una escena de un juego. 
"
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

	anEntity setScene: self.
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

{ #category : 'as yet unclassified' }
Scene >> getCamera [

	^camera.
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
Scene >> loadFrom: fileName [

	| aStream amountLayers |
	aStream := fileName asFileReference binaryReadStream.
	aStream position: 1.
	amountLayers := GameEngine readByteOn: aStream.
	1 to: amountLayers do: [
		layers add: (Layer loadFrom: aStream).
	]
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
Scene >> saveOn: fileName [
	"Salva una escena como un archivo de datos binarios."

	| aStream |
	aStream := fileName asFileReference binaryWriteStream.
	aStream position: 1.
	GameEngine on: aStream nextPutByte: layers size.
	(layers at: 1) save: aStream.
	aStream close
]

{ #category : 'initialization' }
Scene >> setGravity: aVector [

	gravity := aVector.
]

{ #category : 'initialization' }
Scene >> setPlayer: anEntity [

	player := anEntity
]

{ #category : 'as yet unclassified' }
Scene >> translateCameraBy: factor [
	"Mueve la cámara aplicando un factor que viene por parámetro"
	camera translateBy: factor
]
