Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'karen',
		'andre',
		'simpleBoard10',
		'juli',
		'fran',
		'mixBoard20'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> newPlayer [
	^ Player ready
]

{ #category : #running }
GameTest >> setUp [

	super setUp.
	karen := self newPlayer.
	andre := self newPlayer.
	juli := self newPlayer.
	fran := self newPlayer.
	
	simpleBoard10 := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).
	
	mixBoard20 := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (SpeedUp on:5) + (SpeedUp on: 6) + (SpeedUp on: 7) + (NoEffect on: 8) + (NoEffect on:9) + (NoEffect on: 10) + (AtomicBomb on: 11) + (SpeedUp on: 12)+ (WormHole on: 13) + (MoonWalk on: 14) + (NoEffect on: 15) + (NoEffect on: 16) + (WormHole on: 17) + (WormHole on: 18) + (WormHole on: 19) + (MoonWalk on: 20).
]

{ #category : #tests }
GameTest >> testBoardDistribution [

	| board |
	board := Game boardWith: 100.
	
	self
		assert: ( board select: [ :square | square type = 'AtomicBomb' ] ) size equals: 2;
		assert: ( board select: [ :square | square type = 'MoonWalk' ] ) size equals: 10;
		assert: ( board select: [ :square | square type = 'SpeedUp' ] ) size equals: 20;
		assert: ( board select: [ :square | square type = 'WormHole' ] ) size equals: 20;
		assert: ( board select: [ :square | square type = 'NoEffect' ] ) size equals: 48.
]

{ #category : #tests }
GameTest >> testGameCreationFailsWithInvalidBoardSize [

	| players board |
	players := karen + andre.
	board := #().
	
	self
		should: [ Game playedBy: players with: board laps: 0 ]
		raise: InstanceCreationFailed
		withMessageText: 'The board must have at least 2 squares'
]

{ #category : #tests }
GameTest >> testGameCreationFailsWithoutPlayers [

	| players |
	players := #().

	self
		should: [ Game playedBy: players with: simpleBoard10 laps: 0 ]
		raise: InstanceCreationFailed
		withMessageText: 'There must be at least 1 player'


]

{ #category : #tests }
GameTest >> testGameNotOver [

	| player players game |
	player := Player ready.
	players := OrderedCollection with: player.
	game := Game playedBy: players with: simpleBoard10 laps: 0.
		
	self
		should: [ game whoWon ]
		raise: GameException
		withMessageText: 'Play, you fools!'
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerOne [

	| players game d5 d6 dice |
	players := karen + andre.
	game := Game playedBy: players with: simpleBoard10 laps: 0.
	d5 := Die of: 5 rolling: #(1 4 2 3).
	d6 := Die of: 6 rolling: #(2 3 5 1).
	dice := d5 + d6.
	game play: dice.
	
	self
		assert: karen position equals: 10;
		assert: andre position equals: 8;
		assert: game whoWon equals: karen
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerTwo [

	| players game d5 d6 dice |
	players := karen + andre.
	game := Game playedBy: players with: simpleBoard10 laps: 0.
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

	| players d8 game |
	players := OrderedCollection with: karen.
	d8 := Die of: 8 rolling: #(3 6 2 7 5 2 4 8).
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	game play: d8.
	
	self 
		assert: karen position equals: 10;
		assert: karen lap equals: 2.

]

{ #category : #tests }
GameTest >> testPlayersFinalPositionsWithMixBoard [

	| players game d12 |
	players := andre + karen.
	game := Game playedBy: players with: mixBoard20 laps: 1.
	d12 := Die of: 12 rolling: #(6 7 8 9 6 7 8 9 6).
	game play: d12.
	
	self
		assert: karen position equals: 20;
		assert: andre position equals: 18;
		assert: karen lap equals: 1;
		assert: andre lap equals: 0;
		assert: game whoWon equals: karen.
		
	players := game results: players.
	self 
		assert: players first equals: karen;
		assert: players second equals: andre.

]

{ #category : #tests }
GameTest >> testPlayersFinalPositionsWithSimpleBoard [

	| players game d10 d12 dice |
	players := karen + andre + juli + fran.
	game := Game playedBy: players with: simpleBoard10 laps: 1.
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
		
	players := game results: players.
	self 
		assert: players first equals: juli;
		assert: players second equals: karen;
		assert: players third equals: andre;
		assert: players last equals: fran.
]
