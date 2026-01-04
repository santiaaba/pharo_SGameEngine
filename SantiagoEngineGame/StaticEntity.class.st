"
Soy una Entidad Estática en cuanto al sprite que me define. No tengo animación alguna
"
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
	^ rectDraw getRectTranslateTo: position.
]

{ #category : 'undo - undo' }
StaticEntity >> do: aGameEngine [
	"Realiza acciones propias de una StaticEntity"
	
	(super do: aGameEngine) ifTrue: [
		rectDraw translateTo: position.
		collider ifNotNil: [
			collider actualizePosition: position.
		]
	]
]

{ #category : 'as yet unclassified' }
StaticEntity >> draw: aRenderer using: aCamera [
	" Dibuja la entidad estática. La entidad posee coorenadas
	  de la escena. Pero debe ser dibujada en el screen del renderer.
	  Utilizamos las coordenadas de la cámara para hacer el mapeo"
	
	| rect |
	rectDraw translateTo: position.
	rect := rectDraw getRect translateBy: aCamera viewport getRect origin.
	aRenderer drawTexture: texture rectangle: rectCut in: rect.
	Entity debug ifTrue: [ self drawDebug: aRenderer using: aCamera ]
]

{ #category : 'as yet unclassified' }
StaticEntity >> drawDebug: aRenderer using: aCamera [
	"Dibujamos lo siguiente como rectángulos en este oreden:
	 - Rectángulo que circunscribe el sprite
	 - posición del elemento
	 - Coliders si es que tiene"
	
	| rect cameraRect|
	super drawDebug: aRenderer using: aCamera.
	
	"Dibujamos el rectángulo que circunscribe el sprite"
	cameraRect := aCamera viewport getRect origin.
	rect := rectDraw getRect translateBy: cameraRect.
	aRenderer color: Color yellow;
		drawRectangle: rect.
	
	"Dibujamos los colliders"	
	collider ifNotNil: [
		rect := collider boundary.
		rect translateBy: cameraRect.
		aRenderer color: Color blue; drawRectangle: rect
	].
	aRenderer color: Color white.
]

{ #category : 'as yet unclassified' }
StaticEntity >> getCollider [

	^ collider
]

{ #category : 'as yet unclassified' }
StaticEntity >> getMaxBoundary [

	^self boundary.
]

{ #category : 'initialization' }
StaticEntity >> initialize [

	super initialize.
]

{ #category : 'as yet unclassified' }
StaticEntity >> rectCut: aRectangle delta: aPoint [
	"Define el área ed corte en el sprite y el delta respecto del
	 centro de la entidad en la escena. Finalmente, translada
	 el rectángulo de dibujo a la poaisicón que corresponde en
	 la escena. "
		
	rectCut := aRectangle.
	rectDraw := RectDelta rect: aRectangle delta: aPoint.
	rectDraw translateTo: position.
]

{ #category : 'actions' }
StaticEntity >> save: aSteam [

	aSteam nextPutAll: 0 asByteArray.
	super save: aSteam
]

{ #category : 'initialization' }
StaticEntity >> setCollider: aCollider [

	collider := aCollider.
]
