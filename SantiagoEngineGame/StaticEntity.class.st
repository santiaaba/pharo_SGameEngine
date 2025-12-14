Class {
	#name : 'StaticEntity',
	#superclass : 'Entity',
	#instVars : [
		'rectCut',
		'rectDraw',
		'collider',
		'onCollision'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'accessing' }
StaticEntity >> boundary [
	
	"Retorna el rectángulo que circunscribe el sprite"
	^ rectDraw asRectTranslated: position.
]

{ #category : 'undo - undo' }
StaticEntity >> do [

	super do
]

{ #category : 'as yet unclassified' }
StaticEntity >> draw: aRenderer using: aCamera [

	aRenderer drawTexture: texture rectangle: rectCut in: (rectDraw asRectTranslated:position).
	
	" No logro que funcione
	debug ifTrue: [ self drawDebug: aRenderer using: aCamera andRectangle: rect]
	"
]

{ #category : 'as yet unclassified' }
StaticEntity >> drawDebug: aRenderer using: aCamera andRectangle: aRectangle [

	| rect |
	aRenderer color: Color blue;
		drawRectangle: aRectangle;
		color: Color red;
		drawPoint: position - aCamera viewport origin.
		
	collider ifNotNil: [
		rect := collider boundary translateTo: position - aCamera viewport origin.
		aRenderer color: Color yellow; drawRectangle: rect
	]
]

{ #category : 'as yet unclassified' }
StaticEntity >> getCollider [

	^ collider
]

{ #category : 'initialization' }
StaticEntity >> initialize [

	super initialize.
	collider := UndefinedClass.
]

{ #category : 'as yet unclassified' }
StaticEntity >> rectCut: aEngineRectangle delta: aPoint [
	"Las entidades estáticas, al no tener animaciones, no requieren
	 de Frames para determinar las secciones de corte en el sprite.
	 El parámetro aRectangle, define la sección del sprite y el
	 área de dibujo"
		
	rectCut := aEngineRectangle.
	rectDraw := RectDelta rect: aEngineRectangle delta: aPoint.
]

{ #category : 'actions' }
StaticEntity >> save: aSteam [

	aSteam nextPutAll: 0 asByteArray.
	super save: aSteam
]
