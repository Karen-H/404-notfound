Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#instVars : [
		'noEffect10SquaresBoard',
		'deck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> aCancellation [

	^ Cancellation onDeck
]

{ #category : #tests }
CardsTest >> aRedo [

	^ Redo onDeck
]

{ #category : #tests }
CardsTest >> aRepeat [

	^ Repeat onDeck
]

{ #category : #tests }
CardsTest >> aSpeed [

	^ Speed onDeck
]

{ #category : #tests }
CardsTest >> anAcceleration [

	^ Acceleration onDeck
]

{ #category : #tests }
CardsTest >> anOverload [

	^ Overload onDeck
]

{ #category : #tests }
CardsTest >> newDeck [

	| cards |
	cards := Deck assembled.
	^ cards
]

{ #category : #'instance creation' }
CardsTest >> newPlayer: playerName drawing: cards [

	| player |
	player := Player drawing: cards name: playerName.
	^ player
]

{ #category : #running }
CardsTest >> setUp [

	super setUp.
	
	noEffect10SquaresBoard := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).
	deck := self newDeck cards.

]

{ #category : #tests }
CardsTest >> testCancellationRemovesActiveCardFromKaren [

	| karen andre players game |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aCancellation + self anOverload.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self anAcceleration usedBy: karen within: game.
	self aCancellation usedBy: karen within: game.
	self
		assert: karen activeCards isEmpty;
		assert: andre activeCards size equals: 1
]

{ #category : #tests }
CardsTest >> testCardDiscardedFromPlayersHandWhenUsed [

	| karen players game |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	players := OrderedCollection with: karen.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self assert: karen hand size equals: 2.
	self anAcceleration usedBy: karen within: game.
	self assert: karen hand size equals: 1.
]

{ #category : #tests }
CardsTest >> testKarenPicksSpeedFromHandAndUsesItOnHerself [

	| karen andre players game card |
	karen := self newPlayer: 'Karen' drawing: self anOverload + self aSpeed.
	andre := self newPlayer: 'Andre' drawing: self aRedo + self aRepeat.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	card := karen pickACard.
	card usedBy: karen within: game.
	self 
		assert: karen hand size equals: 1;
		assert: karen effect equals: 1;
		assert: karen activeCards size equals: 1.
]

{ #category : #tests }
CardsTest >> testOverloadAppliesItsEffectOnKaren [

	| karen andre players game |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self anOverload + self anOverload.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self anOverload usedBy: andre within: game.
	self anOverload usedBy: andre within: game.
	self assert: karen effect equals: -4.
]

{ #category : #tests }
CardsTest >> testPermanentCardRemainsActiveDuringTheGame [

	| karen andre players game |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aCancellation + self anOverload.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self
		assert: karen activeCards isEmpty;
		assert: andre activeCards isEmpty.
	self anAcceleration usedBy: karen within: game.
	self
		assert: karen activeCards size equals: 1;
		assert: andre activeCards size equals: 1.
	
]

{ #category : #tests }
CardsTest >> testRedoAppliesSameEffectAsTheLastCardUsed [

	| karen andre players game |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aCancellation + self aRedo.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self anAcceleration usedBy: karen within: game.
	andre turn: true.
	self aRedo usedBy: andre within: game.
	self assert: karen effect equals: 2.
]

{ #category : #tests }
CardsTest >> testRepeatAppliesSameEffectAsTheLastTileSteppedOn [

	"Select 'No' when prompted"
	| players board game karen gameHandler |
	karen := self newPlayer: 'Karen' drawing: self aRepeat + self aSpeed.
	gameHandler := GameHandler new.
	players := OrderedCollection with: karen.
	board := Board of: 25 with: DrawCard at: 20.
	game := Game playedBy: players on: board with: 2 using: deck.
	gameHandler move: karen rolling: 19 within: game.
	self assert: karen hand size equals: 3.
	self aRepeat usedBy: karen within: game.
	self assert: karen hand size equals: 3.
]
