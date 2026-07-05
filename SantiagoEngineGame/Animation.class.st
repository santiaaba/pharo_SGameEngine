"
##Los Frames por segundo

Una animación está compuesta por frames. Todos los frames deben ser dibujados en su toralidad en 1 segundo. Así pues, si la animación está compuesta por 2 frames, los mismos deben ser dibujados con un intervalo de 0.5 segundos. Si la animación tiene 10 frames, los mismos deben ser dibujados con un intervalo de 0.1 segundos de diferencia entre ellos.

Nos valemos del deltaTime de la Clase GameEngine el cual es el tiempo en milisegundos entre que se dibuja un frame y otro. Es prácticamente la velocidad del juego en su loop principal.

La clase Animation debe entregar los frame mediante el método getFrame de tal forma que se pase al siguiente frame cuando .... completar

##Boundary
Es el rectángulo que circunscribe a lo que ocupan todos los frames de la animación. SE utiliza para detectar una posible colisión o para determinar cuando entra o sale de cámara una entidad.
"
Class {
	#name : 'Animation',
	#superclass : 'Object',
	#instVars : [
		'frames',
		'currentFrame',
		'deliveryTime',
		'loop',
		'index',
		'timeBetweenFrame',
		'speedFactor',
		'boundary'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'private' }
Animation class >> loadFrom: aStream [

	| amountOfFrames frame frames |
	frames := OrderedCollection new.
	amountOfFrames := GameEngine readByteOn: aStream.
	1 to: amountOfFrames do: [ :f |
		frame := Frame loadFrom: aStream.
		frames add: frame.
	].
	^(self new) setFrames: frames.
]

{ #category : 'adding' }
Animation >> addFrame: aFrame [
	"Agrega un frame a la animación. Recalculamos el boundary
	 que circunscribe a todos los frames."
	
	frames add: aFrame.
	index := 1.
	timeBetweenFrame := 1000 / frames size.
	self recalculateBoundary.
]

{ #category : 'as yet unclassified' }
Animation >> boundary: aPoint [
	"Retorna el rectángulo que determina en el contorno
	del frame actual"
	
	^(frames at: index) rectCut translateTo: aPoint.
]

{ #category : 'as yet unclassified' }
Animation >> getAnimationBoundary: aPoint [
	"Retorna el rectángulo que determina el contorno
	 de toda la animación"
	
	^ boundary getRectTranslateTo: aPoint
]

{ #category : 'private - display' }
Animation >> getFrame [
	"Retorna el frame actual sin avanzar al siguiente"
	
	^currentFrame
]

{ #category : 'private - display' }
Animation >> getFrameAndNext [
	"Retorna el frame actual y al hacerlo, avanza al siguiente frame.
	 Si loop es falso, allí se detiene. Si loop es verdadero, al llegar
	 al último frame, regresa al primero."
	
	(Time now asMilliSeconds - deliveryTime >= (timeBetweenFrame / speedFactor)) ifTrue: [  
		currentFrame := frames at: index.
		deliveryTime := Time now asMilliSeconds.
		index = frames size
			ifTrue: [ loop ifTrue: [ index := 1 ] ]
			ifFalse: [ index := index + 1 ].
	].
	^currentFrame
]

{ #category : 'initialization' }
Animation >> initialize [

	frames := OrderedCollection new.
	index := 0.
	loop := true.
	deliveryTime := 0.
	timeBetweenFrame := 0.
	speedFactor := 1.
]

{ #category : 'testing' }
Animation >> isEnded [

	^ index = frames size
]

{ #category : 'as yet unclassified' }
Animation >> recalculateBoundary [
	"Método privado. En base a los frames de la animación,
	 recalcula el boundary a todos ellos."
	
	| b r |
	b := nil.
	frames do: [ :frame |
		r := frame getRectDelta.
		b ifNil: [ b := r ] ifNotNil:[ b := b merge: r].
	].
	boundary := r.
]

{ #category : 'initialization' }
Animation >> resetAnimation [

	(frames size > 0) ifTrue: [index := 1] ifFalse: [index := 0]
]

{ #category : 'actions' }
Animation >> save: aStream [
	
	GameEngine on: aStream nextPutByte: (frames size).
	frames do: [ :f | f save: aStream ]
]

{ #category : 'initialization' }
Animation >> setFrames: aOrderedCollection [

	frames := aOrderedCollection.
	
]

{ #category : 'accessing' }
Animation >> setLoop: aBoolean [

	loop := aBoolean
]

{ #category : 'initialization' }
Animation >> setSpeedFactor: aFloat [
	"Determino el factor de velocidad de la animación.
	 Permite que una tira completa de frames se renderize
	 en exactamente 1000 milisegundos (speedFactor := 1) o
	 al dople de velocidad (speedFactor := 2) o a la mitad
	 (speedFactor := 0.5) o a la velocidad que convenga."
	
	speedFactor := aFloat.
]
