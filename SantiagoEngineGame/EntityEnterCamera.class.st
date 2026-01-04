"
Represento un evento para una entidad que ha comenzado a entrar en cámara
"
Class {
	#name : 'EntityEnterCamera',
	#superclass : 'EntityEvent',
	#instVars : [
		'camera'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
EntityEnterCamera class >> newEvent: anEntity leaveCamera: aCamera [

	^self new setEntity: anEntity;
		setCemera: aCamera.
]

{ #category : 'initialization' }
EntityEnterCamera >> setCamera: aCamera [

	camera := aCamera.
]
