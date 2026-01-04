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

{ #category : 'start' }
GameEngine class >> debug: aBoolean [

	debug := aBoolean.
	Entity debug: aBoolean
]

{ #category : 'accessing' }
GameEngine class >> deltaTime [

	deltaTime ifNil: [	deltaTime := Time now asMilliSeconds].
	^deltaTime
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

	| d |
	Entity debug ifTrue: [ Transcript clear ].
	[ stop ] whileFalse: [
		d := Time now asMilliSeconds.
		self doing.
		self class setDeltaTime: Time now asMilliSeconds - d.		
		" El límite de FPS lo fijamos en 120"
		(self class deltaTime < 9) ifTrue: [
			(Delay forMilliseconds: 9) wait.
		]
	]
]

{ #category : 'accessing' }
GameEngine >> stop [

	stop := true
]
