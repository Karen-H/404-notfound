Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Cancellation class >> onDeck [

	| effectNumber |
	effectNumber := 0.
			
	^ self new 
		initialize: 'Cancellation'
		with: effectNumber
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

{ #category : #accessing }
Cancellation >> pickActiveCardFrom: target [

	| card |
	card := UIManager default
		chooseFrom: (target activeCards collect: [ :cardboard | cardboard name ])
		values: target activeCards
		title: 'Pick a card'.
	^ card
]

{ #category : #accessing }
Cancellation >> usedBy: player within: game [

	| target card players |
	"players := game players
		collect: [ :member | member activeCards isNotEmpty ].
	players isEmpty
		ifTrue: [ ^ self ]."
	players := game players.
	target := self chooseTargetBetween: players.
	[ target isNil ] whileTrue: [ self chooseTargetBetween: players ].
	card := self pickActiveCardFrom: target.
	[ card isNil ] whileTrue: [ card := self pickActiveCardFrom: target ].
	target remove: card from: target activeCards.
	player remove: self from: player hand.
	game lastUsed: self
]
