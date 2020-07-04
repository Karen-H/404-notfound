Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Redo class >> onDeck [

	^ self new 
		initialize: 'Redo'
		type: 'Instant'.
]

{ #category : #playing }
Redo >> cardUsedBy: player within: game [

	player draw: game lastCardUsed.
	game lastCardUsed usedBy: player within: game.
	player remove: self from: player hand.
	game lastUsed: self
]

{ #category : #initialization }
Redo >> initialize: effect type: cardType [

	name := effect.
	type := cardType.
]

{ #category : #testing }
Redo >> isDestroyed:player in:otherPlayer within:game [ 
	
	otherPlayer remove:self from: otherPlayer activeCards.
]

{ #category : #testing }
Redo >> isInstant:player within:game [
	
	self cardUsedBy: player within:game.
]

{ #category : #playing }
Redo >> usedBy: player within: game [
	
	game beAtPlay:player.
	(game deck cards anySatisfy: [ :card | card name = game lastCardUsed name ])
		ifTrue: [ 
			player turn
				ifTrue: [ self cardUsedBy: player within: game ]
				ifFalse: [ game lastCardUsed isInstant:player within:game.]
		].
]
