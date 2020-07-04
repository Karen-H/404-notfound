"
This class contains tests.
Don't run all tests at the same time. You must run them one by one.
In each test is commented how to use each one.
WARNING:
			if you run everything at the same time, you won't know what test is.
"
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
	cards:=Acceleration onDeck + Cancellation onDeck + Overload onDeck + Redo onDeck + 
	Repeat onDeck + Speed onDeck.
	^ Deck assembled:cards.
]

{ #category : #'instance creation' }
CardsTest >> newPlayer: playerName drawing: cards [

	
	^Player drawing: cards name: playerName.
]

{ #category : #running }
CardsTest >> setUp [

	super setUp.
	
	noEffect10SquaresBoard := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).
	deck := self newDeck.

]

{ #category : #tests }
CardsTest >> testCancellationRemovesActiveCardFromKaren [
	"You must CHOOSE first KAREN and second ACCELERATION"
	| karen andre players game |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aCancellation + self anOverload.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self anAcceleration usedBy: karen within: game.
	self aCancellation usedBy: karen in:karen within: game.
	self
		assert: karen activeCards isEmpty;
		assert: andre activeCards isEmpty.
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
	"You must choose first SPEED and second KAREN"
	| karen andre players game card |
	karen := self newPlayer: 'Karen' drawing: self anOverload + self aSpeed.
	andre := self newPlayer: 'Andre' drawing: self aRedo + self aRepeat.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	card:=karen throwCard:'Speed'.
	card usedBy:karen in:karen within:game.
	self 
		assert: karen hand size equals: 1;
		assert: karen effect equals: 1;
		assert: karen activeCards size equals: 1.
]

{ #category : #tests }
CardsTest >> testOverloadAppliesItsEffectOnKaren [
	"Select Karen twice but andre throw all hand"
	| karen andre players game cardFirstSelectAndre cardSecondSelectAndre |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self anOverload + self anOverload.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	cardFirstSelectAndre:=andre throwCard: 'Overload'.
	cardSecondSelectAndre:=andre throwCard: 'Overload'.
	cardFirstSelectAndre  usedBy: andre in:karen within: game.
	cardSecondSelectAndre  usedBy: andre in:karen within: game.
	self assert: karen effect equals: -4.
	self assert: andre hand isEmpty.
]

{ #category : #tests }
CardsTest >> testPermanentCardRemainsActiveDuringTheGame [
	"You must choose first YES and second REPEAT"
	| karen andre players game cardFirstSelectKaren|
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aCancellation + self anOverload.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	self
		assert: karen activeCards isEmpty;
		assert: andre activeCards isEmpty.
	cardFirstSelectKaren :=karen throwCard: 'Acceleration'.
	cardFirstSelectKaren usedBy: karen within: game.
	self
		assert: karen activeCards size equals: 1;
		assert: andre activeCards size equals: 1.
	
]

{ #category : #tests }
CardsTest >> testRedoAppliesSameEffectAsTheLastCardUsed [

	| karen andre players game cardFirstSelectKaren cardFirstSelectAndre |
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aCancellation + self aRedo.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using: deck.
	cardFirstSelectKaren:= karen throwCard: 'Acceleration'.
	cardFirstSelectKaren usedBy: karen within: game.
	cardFirstSelectAndre:=andre throwCard: 'Redo'.
	andre turn:true.
	cardFirstSelectAndre usedBy: andre within: game.
	self 
		assert: andre effect equals: 2;
		assert: karen effect equals: 2.
]

{ #category : #tests }
CardsTest >> testRepeatAppliesSameEffectAsTheLastTileSteppedOn [
	"Select 'No' when prompted"
	| players board game karen gameHandler cardFirstSelectKaren |
	karen := self newPlayer: 'Karen' drawing: self aRepeat + self aSpeed.
	gameHandler := GameHandler new.
	players := OrderedCollection with: karen.
	board := BoardCreator of: 25 with: DrawCard at: 20.
	game := Game playedBy: players on: board with: 2 using: deck.
	gameHandler move: karen rolling: 19 within: game.
	self assert:karen hand size equals:3.
	cardFirstSelectKaren:= karen throwCard: 'Repeat'.
	cardFirstSelectKaren usedBy: karen within: game.
	self assert: karen hand size equals: 3.
]
