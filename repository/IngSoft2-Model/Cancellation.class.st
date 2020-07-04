Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Cancellation class >> onDeck [

	^ self new 
		initialize: 'Cancellation'
		type: 'Instant'.
]

{ #category : #playing }
Cancellation >> cardUsedBy: player within: game [

	player draw: game lastCardUsed.
	game lastCardUsed usedBy: player in:player within: game.
	player remove: self from: player hand.
	game lastUsed: self
]

{ #category : #initialization }
Cancellation >> initialize: effect type: cardType [

	name := effect.
	type := cardType.
]

{ #category : #testing }
Cancellation >> isInstant:player within:game [
	
	self cardUsedBy: player within:game.
]

{ #category : #playing }
Cancellation >> usedBy: player in:otherPlayer within: game [

	| card  |
	game beAtPlay:player.
	(game players select:[:member|member activeCards isNotEmpty])
		ifNotEmpty: [  
		card := (otherPlayer  activeCards)first.
		card ifNotNil: [
			card isDestroyed: player in: otherPlayer within: game.
			player remove: self from: player hand.
			game lastUsed: self.
				]
		].
]
