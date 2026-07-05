"
##Renderizado
Queremos que se pueda renderizar tan rápido como se pueda hasta una taza máxima de 120 frames por segundo. Pero que con ellono se afecte la velocidad de la lógica o las animaciones de los sprite.

Es decir... que la lógica y animación de los sprite debe ir a un tiempo constante más allá de la velocidad a la que se renderiza la esena.

Para ello nos valemos del deltaTime. Un atributo de la clase GameEngine que tiene como propósito informar a todo el Engine el tiempo promedio que está transcurriendo entre frame y frame.
"
Class {
	#name : 'GameEngine',
	#superclass : 'Object',
	#instVars : [
		'stop',
		'scene',
		'renderer',
		'window'
	],
	#classInstVars : [
		'debug',
		'deltaTime'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'converting' }
GameEngine class >> asIEEE64BitWord: aNumber [
	"Resuelve el problema del método que lleva el mismo nombre para
	 la clase Float. La mejora es que si el float es 0.0, retorna un
	 BitStream completo de tamaño 32"
	
	| a |
	a := aNumber asFloat.
	(a isZero) ifTrue: [
		^ '0000000000000000000000000000000000000000000000000000000000000000' asByteString.
	] ifFalse: [
		^a asIEEE64BitWord
	]
]

{ #category : 'accessing' }
GameEngine class >> debug [

	debug ifNil: [ ^false ].
	^debug.
]

{ #category : 'start' }
GameEngine class >> debug: aBoolean [

	debug := aBoolean.
	Entity debug: aBoolean
]

{ #category : 'accessing' }
GameEngine class >> deltaTime [

	deltaTime ifNil: [	deltaTime := 0.009].
	^deltaTime
]

{ #category : 'streams' }
GameEngine class >> on: aStream nextPutByte: aInteger [
	"Salva un numero entero positivo como un byte
	 siempre y cuando llegue hasta 255"
	| a |
	a := (aInteger asByteArrayOfSize: 1) at:1.
	aStream nextPut: a.
]

{ #category : 'streams' }
GameEngine class >> on: aStream nextPutFloat: aFloat [
	"Salva un numero entero como array de 8 bytes"

	aStream nextPutAll: (self asIEEE64BitWord: aFloat).
	
]

{ #category : 'streams' }
GameEngine class >> on: aStream nextPutLongInt: aNumber [
	"Salva un numero entero como un entero de 4 bytes"
	| bytes |
	bytes := ByteArray new: 4.
	bytes integerAt: 1 put: aNumber size: 4 signed: true.
	aStream nextPutAll: (bytes).
]

{ #category : 'streams' }
GameEngine class >> on: aStream nextPutString: aString [
	"Salva un string"
	
	| a |
	a := ByteArray new: 4.
	a integerAt: 1 put: (aString size) size: 4 signed: false.
	aStream nextBytesPutAll: a.
	aStream nextBytesPutAll: aString.
]

{ #category : 'streams' }
GameEngine class >> readByteOn: aStream [
	"Lee el siguiente byte del stream"
	
	^aStream next.
]

{ #category : 'streams' }
GameEngine class >> readFloatOn: aStream [
	"Lee el siguiente byte del stream"
	
	^(aStream next: 8) doubleAt: 1 bigEndian: false.
]

{ #category : 'streams' }
GameEngine class >> readLongIntOn: aStream [
	"Lee el siguiente byte del stream"
	
	^(aStream next: 4) longAt:1 bigEndian: false.
]

{ #category : 'streams' }
GameEngine class >> readStringOn: aStream [
	"Lee el string"
	
	| s |
	s := (aStream next: 4) longAt:1 bigEndian: false.
	^aStream next: s
]

{ #category : 'initialization' }
GameEngine class >> setDeltaTime: aMilliseconds [

	deltaTime := aMilliseconds.
]

{ #category : 'accessing' }
GameEngine >> doing [
	"Se realizan todas las acciones necesarias para
	 un frame del juego"
	
	"Accionamos sobre las entidades dentro del mismo layer"
	scene layers do:[ :layer | layer entities do:[ :entity | entity do: layer entities] ].

	"Dibujamos el frame. Pueden generarse eventos como
	 por ejemplo, que una animación llegue a su fin"
	renderer color: Color white; clear.
	scene redraw: renderer.
	renderer present.
]

{ #category : 'as yet unclassified' }
GameEngine >> gameLogic [

	^ self subclassResponsibility.
]

{ #category : 'initialization' }
GameEngine >> initialize [ 

	|windowAttr|
	
	windowAttr := OSWindowAttributes new.
	windowAttr
		extent: 640 @ 480;
		resizable: false;
		windowCentered: true.
	window := OSWindowAnimated createWithAttributes: windowAttr.
	renderer := window newGenericRenderer.
	renderer useCompositeAlphaBlending.
	scene := Scene new.
	stop := false.
	window eventHandler: (EngineEventHandle new setEngine: self).
]

{ #category : 'as yet unclassified' }
GameEngine >> onKeyPressEvent: anEvent [

	self subclassResponsibility.
]

{ #category : 'accessing' }
GameEngine >> renderer [

	^ renderer
]

{ #category : 'accessing' }
GameEngine >> scene [
	"Retorna el Objeto escena"
	
	^scene.
]

{ #category : 'initialization' }
GameEngine >> setScene: aScene [

	scene := aScene
]

{ #category : 'accessing' }
GameEngine >> start [
	"Comienza y mantiene el loop del juego hasta
	 que se indique con stop lo contrario"

	| t1 t2 |
	Entity debug ifTrue: [ Transcript clear ].
	[ stop ] whileFalse: [
		t1 := SDL2 ticks.
		self doing.
		t2 := SDL2 ticks.
		GameEngine setDeltaTime: (t2 - t1)/1000.	
		" El límite de FPS lo fijamos en 120"
		(GameEngine deltaTime < 0.009) ifTrue: [
			GameEngine setDeltaTime: 0.009.
			(Delay forMilliseconds: 0.009) wait.
		].
	]
]

{ #category : 'accessing' }
GameEngine >> stop [

	stop := true
]
