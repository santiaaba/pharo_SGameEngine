"
Represento un conjunto de áreas de colisión. Estoy formado por un conjunto de objetos RectDelta respecto de una posición y un RectDelta que los circunscribe a todos llamado Boundary

##Boundary
Su función es ser el primer elemento de detección de ""posible colisión"" para minimizar cálculos. Si ocurre una colisión entre los boundary de dos Coliders, entonces aplicamos esfuerzo de cálculo verificando cual de todos los rectánulos de ambos colaiders son los que realmente colisionaron. Puede pasar que no se encuentre ninguno y entonces no hay colisión aún cuando la hay entre los boundary.

##Actualización
Cuando la posición de una entidad dueña del colider se mueve, solamente se actualizan las coordenadas del Rectangle del boundary. Solo se actualizan todos los rectángulos que definen el colidar si dos boundary colisionan. Mantenemos en el atributo ""lastPosition"" la última posición reportada por la entidad para no realizar catualizaciones inecesarioas del bundary o los demás rectángulos. Solo se actualiza si la posición reportada por la entidad difiere de la conocida por el colider.
"
Class {
	#name : 'Collider',
	#superclass : 'Object',
	#instVars : [
		'boundary',
		'sectors',
		'lasPosition',
		'lastPosition',
		'solid'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
Collider class >> newPosition: aPoint [

	^self new actualizePosition: aPoint.
]

{ #category : 'as yet unclassified' }
Collider >> actualizePosition: newPosition [
	"Actualiza el Boundary según la nueva posición reportada y solo
	 si la misma a cambiado respecto de la que se conoce como la
	 última posición"
	
	(newPosition ~= lastPosition) ifTrue:[
		lastPosition := newPosition.
		boundary translateTo: newPosition.
	]
]

{ #category : 'as yet unclassified' }
Collider >> actualizeSectors [
	"Actualiza los sectores que conforman el boundary."
	
	sectors do: [ :sector | sector translateTo: lastPosition]
]

{ #category : 'adding' }
Collider >> addSectorOrigin: anOrigin corner: aCorner delta: aDelta [
	"Agrego un sector al collider. El delta siempre se ha de considerar respecto
	 del punto que determina la posición del collider. Generalmente vamos
	 a desear que dicho punto concida con el de la Entity que utiliza el collider."

	sectors add: (RectDelta origin: anOrigin corner: aCorner delta: aDelta).
	self recalculateBoundary.
]

{ #category : 'accessing' }
Collider >> boundary [
	"Retorna el rectDelta que representa el boundary
	 ya transladado"
	
	^ boundary getRectTranslateTo: lastPosition
]

{ #category : 'as yet unclassified' }
Collider >> collisionTo: aCollider using: aVector [
	"Utiliza aVector para determinar si self, colisionaría contra aCollider.
	 De ser así, retorna como un objeto Collision, la información sobre dicha
	 colisión. De no producirse una colisión, se retorna nil"
	
	 "Si ambos Collider tiene el atributo solid activado, entonces
	 el vector retornado en el objeto Collision es el vector pasado por parámetro
	 pero con el valor necesario en el módulo para que los colliders no queden
	 superpuestos. Caso contrario, el vector retornado en Collision será el mismo
	 que el recibido por parámetro."
	
	| vector i j |
	vector := nil.
	(aVector collisionBetween: (self boundary) and: aCollider boundary) ifNotNil: [
		"Posible colisión"
		self actualizeSectors.
		aCollider actualizeSectors.
		i := 1.
		[vector isNil and: (i <= sectors size)] whileTrue: [
			j := 1.
			[vector isNil and: (j <= aCollider sectors size)] whileTrue: [
				vector := aVector collisionBetween: (sectors at:i) getRect
				and: (aCollider sectors at:j).
				j := j + 1
			].
			i := i + 1.
		]
	].
	vector ifNil: [ ^nil ].
	(solid not or: aCollider isSolid not) ifTrue: [ vector := aVector ].
	^Collision new: self with: (sectors at: i-1) to: aCollider with: (aCollider sectors at: j-1) using: vector
]

{ #category : 'initialization' }
Collider >> initialize [
	"Inicializa la estructura del collider. A Priori su boundary
	 es simplemente un rectángulo nulo. A medida que se van agregando
	 secciones, el boundary va creciendo circunscribiéndu las secciones."
	
	sectors := GOrderedCollection new.
	boundary := RectDelta origin: 0@0 corner: 0@0 delta: 0@0.
	solid := false.
]

{ #category : 'testing' }
Collider >> isCollisionTo: aCollider [
	"Verifica si dos entidades se encuentran en colisión
	 devolviendo, como par ordenado, las secciones que lo
	 están. Retorna nil si no hay colisión."
	
	| pair |
	(self boundary intersects: aCollider boundary) ifTrue: [
		self actualizeSectors.
		aCollider actualizeSectors. 
		pair := self sectors with: (aCollider sectors) findFirstPair: [ :a :b | a intersects: b ]
	].
	^pair.
]

{ #category : 'as yet unclassified' }
Collider >> isSolid [

	^solid.
]

{ #category : 'as yet unclassified' }
Collider >> recalculateBoundary [
	"En base a los sectores del collider, recalcula el boundary que
	 los circunscribe. Para ello, previamente situa todos los
	 sectores donde corresponde según la posición del colider."
	
	| b |
	b := nil.
	sectors do: [ :s |
		s translateTo: lastPosition.
		b ifNil: [ b := s ] ifNotNil:[ b := b merge: s].
	].
	boundary := b.
]

{ #category : 'accessing' }
Collider >> sectors [
	"Devuelve la lista de sectores que conforman el collider como
	 un conjunto de objetos Rectangle"
	
	^ sectors collect: [ :s | s getRectTranslateTo: lastPosition ]
]

{ #category : 'initialization' }
Collider >> setSolid: aBoolean [

	solid := aBoolean.
]
