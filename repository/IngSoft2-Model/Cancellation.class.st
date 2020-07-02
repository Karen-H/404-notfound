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

{ #category : #accessing }
Cancellation >> chooseTargetBetween: players [

	| target |
	target := UIManager default
		chooseFrom: (players collect: [ :gamer | gamer name ])
		values: players
		title: 'Remove active card from'.
	^ target
]

{ #category : #initialization }
Cancellation >> initialize: effect type: cardType [

	name := effect.
	type := cardType.
]

{ #category : #accessing }
Cancellation >> pickActiveCardFrom: target [

	| card |
	card := UIManager default
		chooseFrom: (target activeCards collect: [ :cardboard | cardboard name ])
		values: target activeCards
		title: 'Pick a card'.
	^ card
]

{ #category : #playing }
Cancellation >> usedBy: player in:otherPlayer within: game [

	| target card players |
	players := game players
		select:[:member|member activeCards isNotEmpty].
	players isEmpty
	   ifTrue: [ ^ self].
	target := otherPlayer.
	card := (target activeCards)first.
	[ card isNil ] whileTrue: [^self].
	target remove: card from: target activeCards.
	player remove: self from: player hand.
	game lastUsed: self
]

{ #category : #playing }
Cancellation >> usedBy: player within: game [

	| target card players |
	players := game players
		select:[:member|member activeCards isNotEmpty].
	players isEmpty
	   ifTrue: [ ^ self].
	target := player.
	card := (player activeCards)first.
	[ card isNil ] whileTrue: [^self].
	target remove: card from: target activeCards.
	player remove: self from: player hand.
	game lastUsed: self
]
