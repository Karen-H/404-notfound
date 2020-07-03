Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Repeat class >> onDeck [
			
	^ self new 
		initialize: 'Repeat'
		type: 'Instant'.
]

{ #category : #playing }
Repeat >> cardUsedBy: player within: game [

	player draw: game lastCardUsed.
	game lastCardUsed usedBy: player in:player within: game.
	player remove: self from: player hand.
	game lastUsed: self
]

{ #category : #initialization }
Repeat >> initialize: effect type: cardType [

	name := effect.
	type := cardType.
]

{ #category : #testing }
Repeat >> isDestroyed:player in:otherPlayer within:game [ 
	
	otherPlayer remove:self from: otherPlayer activeCards.
]

{ #category : #testing }
Repeat >> isInstant:player within:game [
	
	self cardUsedBy: player within:game.
]

{ #category : #playing }
Repeat >> usedBy: player within: game [

	( game board anySatisfy: [ :tile | tile type = game lastSquareSteppedOn type ] )
		ifTrue: [ ^ self ].
	game lastSquareSteppedOn applyEffectOn: player within: game.
	player remove: self from: player hand.
	game lastUsed: self.
]
