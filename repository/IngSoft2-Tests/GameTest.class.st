"
This class contains tests.
Don't run all tests at the same time. You must run them one by one.
In each test is commented how to use each one.
WARNING:
			if you run everything at the same time, you won't know what test is.
ATTENTION:	
make fast clicks in test: testPlayersFinalPositionsWithMixBoardUsingCards.Because the time is short""
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'karen',
		'andre',
		'juli',
		'fran',
		'noEffect10SquaresBoard',
		'diverseEffects20SquaresBoard',
		'gameHandler',
		'deck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> aCancellation [

	^ Cancellation onDeck
]

{ #category : #tests }
GameTest >> aRedo [

	^ Redo onDeck
]

{ #category : #tests }
GameTest >> aRepeat [

	^ Repeat onDeck
]

{ #category : #tests }
GameTest >> aSpeed [

	^ Speed onDeck
]

{ #category : #tests }
GameTest >> anAcceleration [

	^ Acceleration onDeck
]

{ #category : #tests }
GameTest >> anOverload [

	^ Overload onDeck
]

{ #category : #tests }
GameTest >> newDeck [

	| cards |
	cards := Deck assembled.
	^ cards
]

{ #category : #tests }
GameTest >> newGameHandler [

	^ GameHandler new
]

{ #category : #tests }
GameTest >> newPlayer: playerName drawing: cards [

	| player |
	player := Player drawing: cards name: playerName.
	^ player
]

{ #category : #running }
GameTest >> setUp [

	super setUp.
	
	karen := self newPlayer: 'Karen' drawing: self anAcceleration + self aCancellation.
	andre := self newPlayer: 'Andre' drawing: self aSpeed + self anOverload.
	juli := self newPlayer: 'Juli' drawing: self anOverload + self aRedo.
	fran := self newPlayer: 'Fran' drawing: self aRepeat + self aSpeed.
	gameHandler := self newGameHandler.
	deck := self newDeck cards.
	
	noEffect10SquaresBoard := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).
	
	diverseEffects20SquaresBoard := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (SpeedUp on:5) + (SpeedUp on: 6) + (SpeedUp on: 7) + (NoEffect on: 8) + (NoEffect on:9) + (NoEffect on: 10) + (AtomicBomb on: 11) + (SpeedUp on: 12)+ (WormHole on: 13) + (MoonWalk on: 14) + (NoEffect on: 15) + (NoEffect on: 16) + (WormHole on: 17) + (WormHole on: 18) + (WormHole on: 19) + (MoonWalk on: 20).
]

{ #category : #tests }
GameTest >> testBoardDistribution [

	| board |
	board := BoardCreator new withRandomlyDistributed: 100.

	self
		assert: ( board count: [ :square | square type = 'AtomicBomb' ] ) equals: 2;
		assert: ( board count: [ :square | square type = 'DrawCard' ] ) equals: 3;
		assert: ( board count: [ :square | square type = 'MoonWalk' ] ) equals: 10;
		assert: ( board count: [ :square | square type = 'SpeedUp' ] ) equals: 20;
		assert: ( board count: [ :square | square type = 'WormHole' ] ) equals: 20;
		assert: ( board count: [ :square | square type = 'NoEffect' ] ) equals: 45.
]

{ #category : #tests }
GameTest >> testGameCreationFailsWithInvalidBoardSize [

	| players board |
	players := karen + andre.
	board := #().

	self 
		should: [ Game playedBy: players on: board with: 0 using: deck ]
		raise: InstanceCreationFailed
		withMessageText: 'The board must have at least 2 squares'
]

{ #category : #tests }
GameTest >> testGameCreationFailsWithoutPlayers [

	| players |
	players := #().

	self
		should: [ Game playedBy: players on: noEffect10SquaresBoard with: 0 using: deck ]
		raise: InstanceCreationFailed
		withMessageText: 'There must be at least 1 player'


]

{ #category : #tests }
GameTest >> testGameNotOver [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using: deck.
		
	self
		should: [ game whoWon ]
		raise: GameException
		withMessageText: 'Play, you fools!'
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerOne [

	"Select 'No' when prompted (6 times)"
	| players game d5 d6 dice |
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using: deck.
	d5 := Die of: 5 rolling: #(1 4 2 3).
	d6 := Die of: 6 rolling: #(2 3 5 1).
	dice := d5 + d6.
	game play: dice.
	
	self
		assert: karen boardSquare equals: 10;
		assert: andre boardSquare equals: 8;
		assert: game whoWon equals: karen
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerTwo [

	"Select 'No' when prompted (4 times)"
	| players game d5 d6 dice |
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using: deck.
	d5 := Die of: 5 rolling: #(1 5).
	d6 := Die of: 6 rolling: #(2 6).
	dice := d5 + d6.
	game play: dice.
	
	self
		assert: karen boardSquare  equals: 4;
		assert: andre boardSquare  equals: 10;
		assert: game whoWon equals: andre
]

{ #category : #tests }
GameTest >> testPlayerCantExceedMaxPositionOnFinalLap [

	"Select 'No' when prompted (4 times)"
	| players d8 game |
	players := OrderedCollection with: karen.
	d8 := Die of: 8 rolling: #(9 8 7 6 9 8 7 6).
	game := Game playedBy: players on: noEffect10SquaresBoard with: 2 using: deck.
	game play: d8.
	
	self 
		assert: karen boardSquare  equals: 10;
		assert: karen lap equals: 2.

]

{ #category : #tests }
GameTest >> testPlayerDrawsACard [

	"Select 'No' when prompted"
	| players board game |
	players := OrderedCollection with: karen.
	board := BoardCreator new of: 25 with: DrawCard at: 20.
	game := Game playedBy: players on: board with: 2 using: deck.
	self assert: karen hand size equals: 2.
	gameHandler move: karen rolling: 19 within: game.
	self assert: karen hand size equals: 3.
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToAtomicBomb [

	"Select 'No' when prompted (2 times)"
	| players board game |
	players := karen + andre.
	board := BoardCreator new of: 15 with: AtomicBomb at: 11.
	game := Game playedBy: players on: board with: 2 using: deck.
	andre location changeSquare: 4.
	gameHandler move: karen rolling: 10 within: game.
	self
		assert: karen boardSquare  equals: 1;
		assert: andre boardSquare  equals: 1
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToMoonWalk [

	"Select 'No' when prompted (2 times)"
	| players board game |
	players := karen + andre.
	board := BoardCreator new of: 25 with: MoonWalk at: 20.
	game := Game playedBy: players on: board with: 2 using: deck.
	andre location changeSquare: 5.
	gameHandler move: karen rolling: 19 within: game.
	
	self 
		assert: karen boardSquare  equals: 20;
		assert: andre boardSquare  equals: 3.
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToSpeedUp [

	"Select 'No' when prompted"
	| players board game |
	players := OrderedCollection with: karen.
	board := BoardCreator new of: 15 with: SpeedUp at: 5.
	game := Game playedBy: players on: board with: 2 using: deck.
	gameHandler move: karen rolling: 4 within: game.
	
	self assert: karen boardSquare  equals: 9.
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToWormHole [

	"Select 'No' when prompted"
	| players board game |
	players := OrderedCollection with: karen.
	board := BoardCreator new of: 15 with: WormHole at: 10.
	game := Game playedBy: players on: board with: 2 using: deck.
	gameHandler move: karen rolling: 9 within: game.
	
	self assert: karen boardSquare equals: 6.
]

{ #category : #tests }
GameTest >> testPlayerStaysAtSamePositionWhenItArrivesToASquareWithNoEffect [

	"Select 'No' when prompted"
	| players board game |
	players := OrderedCollection with: karen.
	board := BoardCreator new of: 15 with: NoEffect at: 4.
	game := Game playedBy: players on: board with: 2 using: deck.
	gameHandler move: karen rolling: 3 within: game.

	self assert: karen boardSquare  equals: 4.
]

{ #category : #tests }
GameTest >> testPlayersFinalPositionsWithMixBoard [

	"Select 'No' when prompted (6 times)"
	| players game d15 |
	players := andre + karen.
	game := Game playedBy: players on: diverseEffects20SquaresBoard with: 0 using: deck.
	d15 := Die of: 15 rolling: #(12 13 14 15).
	game play: d15.
	
	self
		assert: karen boardSquare  equals: 12;
		assert: andre boardSquare  equals: 20;
		assert: game whoWon equals: andre.
		
	players := game results.
	self 
		assert: players first equals: andre;
		assert: players second equals: karen.

]

{ #category : #tests }
GameTest >> testPlayersFinalPositionsWithSimpleBoard [

	"Select 'No' when prompted (4 times)"
	| players game d10 d12 dice |
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using: deck.
	d10 := Die of: 10 rolling: #(1 2 3 4).
	d12 := Die of: 12 rolling: #(6 7 8 9).
	dice := d10 + d12.
	game play: dice.
	
	self
		assert: karen boardSquare  equals: 8;
		assert: andre boardSquare  equals: 10;
		assert: game whoWon equals: andre.
		
	players := game results.
	self 
		assert: players first equals: andre;
		assert: players second equals: karen.
]
