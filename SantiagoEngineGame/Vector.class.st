Class {
	#name : 'Vector',
	#superclass : 'Object',
	#instVars : [
		'module',
		'direction'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'as yet unclassified' }
Vector class >> module: aNumber direction: aNomberDirection [

	^ (self new module: aNumber) direction: aNomberDirection
]

{ #category : 'accessing' }
Vector >> direction [

	^ direction
]

{ #category : 'accessing' }
Vector >> direction: aNumber [

	direction := aNumber
]

{ #category : 'actions api' }
Vector >> load: arg1 [

	| tmp1 tmp2 |
	tmp1 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp2 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	module := tmp1 @ tmp2.
	tmp1 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	tmp2 := (arg1 next: 4) floatAt: 1 bigEndian: true.
	direction := tmp1 @ tmp2
]

{ #category : 'accessing' }
Vector >> module [

	^ module
]

{ #category : 'accessing' }
Vector >> module: arg1 [

	module := arg1
]

{ #category : 'actions' }
Vector >> save: arg1 [

	arg1
		nextPutAll: module asFloat asIEEE32BitWord asByteArray;
		nextPutAll: direction asFloat asIEEE32BitWord asByteArray
]
