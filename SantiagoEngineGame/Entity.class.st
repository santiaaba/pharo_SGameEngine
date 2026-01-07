"
Represento las características más generales de una entidad.

###Dirección
Es un vector que indica la dirección y velocidad a la que se mueve la entidad. El vector
puede verse afectado por otros vectores como por ejemplo la fuerza de gravedad.


###Estado de colisión
El atributo collisions es una colección de las colisiones que se están produciéndo contra otras entidades.
"
Class {
	#name : 'Entity',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position',
		'texture',
		'gravity',
		'direction',
		'aceleration',
		'input',
		'tag',
		'handlers',
		'renderer',
		'onCamera',
		'scene',
		'collisions'
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

{ #category : 'initialization' }
Entity >> aceleration [

	^aceleration.
]

{ #category : 'initialization' }
Entity >> addDirection: aVector [
	"Suma a la dirección actual de la entidad un nuevo vector
	 dirección"
	
	direction := direction + aVector.
]

{ #category : 'accessing' }
Entity >> boundary [

	" Retorna el SDL_Rect que circunscribe al sprite "
	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
Entity >> collisionTo: anotherEntity using: aVector [
	"Verifica si se ha dado una colisión entre dos entidades
	 que poseen collider. De producirse, se genera un evento
	 y se recuerda que la entidad está colisionando con otra
	 para no volver a evaluar la colisión en el siguiente loop
	 y además para poder reconocer el evento cuando dejan de colisionar"
	
	|c1 c2 collision |
	(collisions includes: anotherEntity) ifTrue: [ ^nil ].
	c1 := self getCollider.
	c2 := anotherEntity getCollider.
	(c1 isNotNil and: c2 isNotNil) ifTrue:[
		collision := c1 collisionTo: c2 using: aVector.
		collision ifNotNil:[
			collisions add: anotherEntity. 
		]
	].
	^collision.
]

{ #category : 'undo - undo' }
Entity >> do: anotherEntities [
	"Representa un conjunto de acciones que la entidad ha
	 de realizar en el fotograma actual el juego. Retorna true
	 si ha cambiado su posición"
	
	| changePosition newPoint collision |
	
	direction := direction + (gravity * (GameEngine deltaTime)).
	(direction module ~= 0) ifTrue: [
		anotherEntities do: [ :e |
			collision := self collisionTo: e using: (direction * (GameEngine deltaTime)).
			"Actualizamos el vector dirección con el potencial nuevo vector"
			collision ifNotNil: [ direction := collision resultingVector	].
		] without: self.
	].
	 
	newPoint := (direction * (GameEngine deltaTime)) movePoint: position.
	changePosition := position ~= newPoint.
	position := newPoint.
		
	"Verificamos si sale o entra en cámara"
	self isLeaveOrEnterCamera.
		
	"Verificamos si deja de chocar con otra entidad"
	collisions do: [ :e | self notCollisionTo: e ].
	
	^changePosition.
]

{ #category : 'as yet unclassified' }
Entity >> drawDebug: aRenderer using: aCamera [
	"Dibujamos el punto posición de la entidad"
	
	| rect |
	rect := Rectangle origin: position corner: (position + (5@5)).
	rect := rect translateBy: aCamera viewport getRect origin.
	aRenderer color: Color red;
		drawRectangle: rect.
]

{ #category : 'accessing' }
Entity >> getCollider [

	^ self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
Entity >> getMaxBoundary [

	^self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
Entity >> getPosition [
	"Retorna su posición actual dentro de la escena "
	
	^ position
]

{ #category : 'initialization' }
Entity >> initialize [

	name := 'Entidad'.
	position := 0@0.
	gravity := Vector module: 0 direction: 0.
	direction := Vector module: 0 direction: 0.
	aceleration := Vector module: 0 direction: 0.
	collisions := OrderedCollection new.
]

{ #category : 'testing' }
Entity >> isLeaveOrEnterCamera [

	| a |
	a := (scene getCamera viewport getRect) intersects: self getMaxBoundary.
	onCamera ifNil: [
		"Seteamos el estado inicial del elemento pero
		 no generamos evento alguno."
		onCamera := a.
	] ifNotNil: [
		onCamera ifTrue: [
			a ifFalse:[
				"Estaba en cámara y ha dejado de estarlo"
				onCamera := a.
			]
		] ifFalse: [
			a ifTrue:[
				"No estaba en camara y ahora ha comenzado a estarlo"
				onCamera := a.
			]
		]
	]
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

{ #category : 'as yet unclassified' }
Entity >> notCollisionTo: anotherEntity [
	"Verifica que no esté colisionado contra la entidad anotherEntity.
	 De producirse, se genera un evento y se deja de recordar que
	 la entidad está colisionando con la otra"
	
	|c1 c2|
	c1 := self getCollider.
	c2 := anotherEntity getCollider.
	((c1 isNil or: c2 isNil) or:((c1 isCollisionTo: c2) isNil)) ifTrue:[
		collisions remove: anotherEntity.
		^ EntityLostCollisionEvent
				newEvent: self 
				collisionTo: anotherEntity.
	].
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
Entity >> setAceleration: aVector [

	aceleration := aVector.
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
Entity >> setName: aString [

	name := aString.
]

{ #category : 'initialization' }
Entity >> setPosition: aPoint [
	"Posiciona el punto que representa su localización en en la escena"
	
	position := aPoint
]

{ #category : 'initialization' }
Entity >> setScene: aScene [

	scene := aScene.
]

{ #category : 'initialization' }
Entity >> setTexture: pathTextureFile with: aRenderer [
	"Le asigna un sprite como textura"
	
	renderer := aRenderer.
	texture := renderer createStaticTextureFromForm: (ImageReadWriter formFromFileNamed: pathTextureFile)
]
