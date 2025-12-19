"
Represento un juego de Plataformas. Donde la gravedad es un factor crucial
"
Class {
	#name : 'GameEnginePlatform',
	#superclass : 'GameEngine',
	#instVars : [
		'gravity'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'accessing' }
GameEnginePlatform >> doing [
	"Realizamos las acciones básicas para un juego de plataformas
	 antes de realizar las acciones para un juego genérico"
	
	super doing.
]

{ #category : 'initialization' }
GameEnginePlatform >> initialize [ 

	super initialize.
	gravity := Vector module: 0 direction: 0.
]

{ #category : 'initialization' }
GameEnginePlatform >> setGravity: aVector [

	gravity := aVector.
]
