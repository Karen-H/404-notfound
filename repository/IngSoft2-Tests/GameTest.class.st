Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'karen',
		'andre',
		'simpleBoard10',
		'juli',
		'fran',
		'mixBoard20',
		'noEffect10SquaresBoard',
		'diverseEffects20SquaresBoard',
		'gameHandler'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> newGameHandler [
	^ GameHandler new
]

{ #category : #tests }
GameTest >> newPlayer [
	
	^ Player new initializeWith:(Overload new+Overload new).
]

{ #category : #running }
GameTest >> setUp [

	super setUp.
	karen := self newPlayer.
	andre := self newPlayer.
	juli := self newPlayer.
	fran := self newPlayer.
	gameHandler := self newGameHandler.
	
	noEffect10SquaresBoard := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).
	
	diverseEffects20SquaresBoard := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (SpeedUp on:5) + (SpeedUp on: 6) + (SpeedUp on: 7) + (NoEffect on: 8) + (NoEffect on:9) + (NoEffect on: 10) + (AtomicBomb on: 11) + (SpeedUp on: 12)+ (WormHole on: 13) + (MoonWalk on: 14) + (NoEffect on: 15) + (NoEffect on: 16) + (WormHole on: 17) + (WormHole on: 18) + (WormHole on: 19) + (MoonWalk on: 20).
]

{ #category : #tests }
GameTest >> testBoardDistribution [

	| board |
	board := Board withRandomlyDistributed: 100.

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

	| players board deck|
	players := karen + andre.
	board := #().
	deck:=Deck new initialize.
	self
		should: [ Game playedBy: players on: board with: 0 using:deck]
		raise: InstanceCreationFailed
		withMessageText: 'The board must have at least 2 squares'
		
]

{ #category : #tests }
GameTest >> testGameCreationFailsWithInvalidDeck [

	| players board deck|
	players := karen + andre.
	board := #(1 2).
	deck:=#().
	self
		should: [ Game playedBy: players on: board with: 0 using:deck]
		raise: InstanceCreationFailed
		withMessageText: 'The deck must have cards'
		
]

{ #category : #tests }
GameTest >> testGameCreationFailsWithoutPlayers [

	| players deck|
	players := #().
	deck:=Deck new initialize.
	self
		should: [ Game playedBy: players on: noEffect10SquaresBoard with: 0 using:deck]
		raise: InstanceCreationFailed
		withMessageText: 'There must be at least 1 player'


]

{ #category : #tests }
GameTest >> testGameNotOver [

	| player players game cards deck|
	cards:=(Speed new)+(Speed new).
	deck:=Deck new initialize.
	player := Player new initializeWith:cards.
	players := OrderedCollection with: player.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using:(deck cards).
		
	self
		should: [ game whoWon ]
		raise: GameException
		withMessageText: 'Play, you fools!'
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerOne [

	| players game d5 d6 dice deck|
	deck:=Deck new initialize.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using:deck cards.
	d5 := Die of: 5 rolling: #(1 4 2 3).
	d6 := Die of: 6 rolling: #(2 3 5 1).
	dice := d5 + d6.
	game play: dice.
	
	self
		assert: karen position equals: 10;
		assert: andre position equals: 8;
		assert: game whoWon equals: karen.
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerTwo [

	| players game d5 d6 dice deck|
	deck:=Deck new initialize.
	players := karen + andre.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 0 using:deck cards.
	d5 := Die of: 5 rolling: #(1 5).
	d6 := Die of: 6 rolling: #(2 6).
	dice := d5 + d6.
	game play: dice.
	
	self
		assert: karen position equals: 4;
		assert: andre position equals: 10;
		assert: game whoWon equals: andre
]

{ #category : #tests }
GameTest >> testPlayerCantExceedMaxPositionOnFinalLap [

	| players d8 game deck|
	players := OrderedCollection with: karen.
	d8 := Die of: 8 rolling: #(3 6 2 7 5 2 4 8).
	deck:= Deck new initialize.
	game := Game playedBy: players on: noEffect10SquaresBoard with:2 using:deck cards.
	game play: d8.
	
	self 
		assert: karen position equals: 10;
		assert: karen lap equals: 2.

]

{ #category : #tests }
GameTest >> testPlayerMovesDueToAtomicBomb [

	| players board game deck|
	deck:=Deck new initialize.
	players := karen + andre.
	board := Board of: 15 with: AtomicBomb at: 11.
	game := Game playedBy: players on: board with: 2 using:deck cards.
	andre location changeSquare: 4.
	gameHandler move: karen rolling: 10 within: game.
	self
		assert: karen position equals: 1;
		assert: andre position equals: 1
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToMoonWalk [

	| players board game deck|
	deck:=Deck new initialize.
	players := karen + andre.
	board := Board of: 25 with: MoonWalk at: 20.
	game := Game playedBy: players on: board with: 2 using:deck cards.
	andre location changeSquare: 5.
	gameHandler move: karen rolling: 19 within: game.
	
	self 
		assert: karen position equals: 20;
		assert: andre position equals: 3.
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToSpeedUp [

	| players board game deck|
	deck:=Deck new initialize.
	players := OrderedCollection with: karen.
	board := Board of: 15 with: SpeedUp at: 5.
	game := Game playedBy: players on: board with: 2 using:deck cards.
	gameHandler move: karen rolling: 4 within: game.
	
	self assert: karen position equals: 9.
]

{ #category : #tests }
GameTest >> testPlayerMovesDueToWormHole [

	| players board game deck|
	deck:=Deck new initialize.
	players := OrderedCollection with: karen.
	board := Board of: 15 with: WormHole at: 10.
	game := Game playedBy: players on: board with: 2 using:deck cards.
	gameHandler move: karen rolling: 9 within: game.
	
	self assert: karen position equals: 6.
]

{ #category : #tests }
GameTest >> testPlayerStaysAtSamePositionWhenItArrivesToASquareWithNoEffect [

	| players board game deck|
	deck:=Deck new initialize.
	players := OrderedCollection with: karen.
	board := Board of: 15 with: NoEffect at: 4.
	game := Game playedBy: players on: board with: 2 using:deck cards.
	gameHandler move: karen rolling: 3 within: game.

	self assert: karen position equals: 4.
]

{ #category : #tests }
GameTest >> testPlayersFinalPositionsWithMixBoard [

	| players game d12 deck|
	deck:=Deck new initialize.
	players := andre + karen.
	game := Game playedBy: players on: diverseEffects20SquaresBoard with: 1 using:deck cards.
	d12 := Die of: 12 rolling: #(6 7 8 9).
	game play: d12.
	
	self
		assert: karen position equals: 14;
		assert: andre position equals: 20;
		assert: karen lap equals: 1;
		assert: andre lap equals: 1;
		assert: game whoWon equals: andre.
		
	players := game results.
	self 
		assert: players first equals: andre;
		assert: players second equals: karen.

]

{ #category : #tests }
GameTest >> testPlayersFinalPositionsWithSimpleBoard [

	| players game d10 d12 dice deck|
	deck:=Deck new initialize.
	players := karen + andre + juli + fran.
	game := Game playedBy: players on: noEffect10SquaresBoard with: 1 using:deck cards.
	d10 := Die of: 10 rolling: #(1 2 3 4 5 1 2 3 4).
	d12 := Die of: 12 rolling: #(6 7 8 9 6 7 8 9 6).
	dice := d10 + d12.
	game play: dice.
	
	self
		assert: karen position equals: 9;
		assert: andre position equals: 8;
		assert: juli position equals: 10;
		assert: fran position equals: 4;
		assert: game whoWon equals: juli.
		
	players := game results.
	self 
		assert: players first equals: juli;
		assert: players second equals: karen;
		assert: players third equals: andre;
		assert: players last equals: fran.
]
