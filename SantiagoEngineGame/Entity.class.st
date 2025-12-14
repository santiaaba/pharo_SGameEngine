Class {
	#name : 'Entity',
	#superclass : 'Object',
	#instVars : [
		'position',
		'texture',
		'gravity',
		'direction',
		'input',
		'tag',
		'handlers',
		'renderer'
	],
	#classInstVars : [
		'debug'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'accessing' }
Entity class >> debug [

	^debug
]

{ #category : 'accessing' }
Entity class >> debug: aBoolean [

	debug := aBoolean
]

{ #category : 'instance creation' }
Entity class >> new: aTexture render: aRenderer [

	^ self new setTexture: aTexture with: aRenderer
]

{ #category : 'accessing' }
Entity >> boundary [

	" Retorna el SDL_Rect que circunscribe al sprite "
	self subclassResponsibility.
]

{ #category : 'undo - undo' }
Entity >> do [

	"Representa un conjunto de acciones que la entidad ha
	 de realizar en el fotograma actual el juego"
	
	position := (position addVector: gravity) addVector: direction
]

{ #category : 'as yet unclassified' }
Entity >> getPosition [
	"Retorna su posición actual dentro de la escena "
	
	^ position
]

{ #category : 'initialization' }
Entity >> initialize [

	position := 0 @ 0.
	gravity := Vector module: 0 direction: 0.
	direction := Vector module: 0 direction: 0
]

{ #category : 'actions api' }
Entity >> load: aStream [
	"Setea las características de la entidad en base a un Stream de datos"
	
	| x y |
	x := (aStream next: 4) floatAt: 1 bigEndian: true.
	y := (aStream next: 4) floatAt: 1 bigEndian: true.
	position := x @ y.
	direction load: aStream.
	gravity load: aStream
]

{ #category : 'accessing' }
Entity >> move: aPoint [

	"Incrementa las coordenadas de la posición de la entidad sumando
	 los valores de los ejes indicados en el parámetro aPoint"
	
	position := position translateBy: aPoint.
]

{ #category : 'actions' }
Entity >> save: aStream [
	"Retorna la información de la entidad en array de bytes para
	 podes ser posteriormente salvado en un archivo"
	aStream
		nextPutAll: position x asFloat asIEEE32BitWord asByteArray;
		nextPutAll: position y asFloat asIEEE32BitWord asByteArray.
	gravity save: aStream.
	direction save: aStream
]

{ #category : 'initialization' }
Entity >> setDirection: aVector [
	"Asigna un vector dirección"
	
	direction := aVector
]

{ #category : 'initialization' }
Entity >> setGravity: aVector [
	"Asigna un vector gravedad"
	
	gravity := aVector
]

{ #category : 'initialization' }
Entity >> setPosition: aPoint [
	"Posiciona el punto que representa su localización en en la escena"
	
	position := aPoint
]

{ #category : 'initialization' }
Entity >> setTexture: pathTextureFile with: aRenderer [
	"Le asigna un sprite como textura"
	
	renderer := aRenderer.
	texture := renderer createStaticTextureFromForm: (ImageReadWriter formFromFileNamed: pathTextureFile)
]
