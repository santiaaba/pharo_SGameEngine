Class {
	#name : 'Animation',
	#superclass : 'Object',
	#instVars : [
		'frames',
		'loop',
		'index'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'adding' }
Animation >> addFrame: aFrame [

	frames add: aFrame.
	index := 1
]

{ #category : 'as yet unclassified' }
Animation >> boundary: aPoint [
	"Retorna el rectángulo que determina en el contorno
	del frame actual"
	
	^(frames at: index) rectCut translateTo: aPoint.
]

{ #category : 'private - display' }
Animation >> getFrame [
	"Retorna el frame actual y al hacerlo, avanza al siguiente frame.
	 Si loop es falso, allí se detiene. Si loop es verdadero, al llegar
	 al último frame, regresa al primero."
	
	| f |
	f := frames at: index.
	
	index = frames size
		ifTrue: [ loop ifTrue: [ index := 1 ] ]
		ifFalse: [ index := index + 1 ].
	^f
]

{ #category : 'initialization' }
Animation >> initialize [

	frames := OrderedCollection new.
	index := 0.
	loop := true
]

{ #category : 'testing' }
Animation >> isEnded [

	^ index = frames size
]

{ #category : 'actions api' }
Animation >> load: arg1 [

	| tmp1 tmp2 |
	tmp1 := (arg1 next: 1) byteAt: 1 asNumber.
	tmp2 := tmp1.
	0 to: tmp2 do: [ :tmp3 | frames add: (Frame new load: arg1) ]
]

{ #category : 'accessing' }
Animation >> loop: aBoolean [

	loop := aBoolean
]

{ #category : 'as yet unclassified' }
Animation >> nextFrame [

	index = frames size
		ifTrue: [ loop ifTrue: [ index := 1 ] ]
		ifFalse: [ index := index + 1 ]
]

{ #category : 'initialization' }
Animation >> resetAnimation [

	(frames size > 0) ifTrue: [index := 1] ifFalse: [index := 0]
]

{ #category : 'actions' }
Animation >> save: arg1 [

	arg1 nextPutAll: frames size asByteArray.
	frames do: [ :f | f save: arg1 ]
]
