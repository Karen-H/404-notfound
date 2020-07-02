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

	| card  |
	(game players select:[:member|member activeCards isNotEmpty])ifEmpty: [ ^ self].
	card := (otherPlayer  activeCards)first.
	card ifNil: [^self].
	otherPlayer remove: card from: otherPlayer activeCards.
	player remove: self from: player hand.
	game lastUsed: self
]

{ #category : #playing }
Cancellation >> usedBy: player within: game [

	| card|
	(game players select:[:member|member activeCards isNotEmpty])ifEmpty: [ ^ self].
	card := (player activeCards)first.
	card ifNil: [^self].
	player remove: card from: player activeCards.
	player remove: self from: player hand.
	game lastUsed: self
]
