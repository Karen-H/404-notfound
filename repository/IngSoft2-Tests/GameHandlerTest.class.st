Class {
	#name : #GameHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'simpleBoard10',
		'karen',
		'andre',
		'mixBoard20'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameHandlerTest >> newPlayer [
	^ Player ready
]

{ #category : #running }
GameHandlerTest >> setUp [

	super setUp.
	karen := self newPlayer.
	andre := self newPlayer.
	simpleBoard10 := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).

	mixBoard20 := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (SpeedUp on: 5) + (SpeedUp on: 6) + (SpeedUp on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10) + (AtomicBomb on: 11) + (SpeedUp on: 12)+ (WormHole on: 13) + (MoonWalk on: 14) + (NoEffect on: 15) + (NoEffect on: 16) + (WormHole on: 17) + (WormHole on: 18) + (WormHole on: 19) + (MoonWalk on: 20).
]

{ #category : #tests }
GameHandlerTest >> testMovementExceedsFinalPosition [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 5.
	karen goTo: (GameHandler moveForward: karen with: 25 within: game).
	
	self 
		assert: karen lap equals: 2;
		assert: karen position equals: 5.
]

{ #category : #tests }
GameHandlerTest >> testMovementExceedsFinalPositionOnFinalLap [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 0.
	karen goTo: (GameHandler moveForward: karen with: 15 within: game).
	
	self 
		assert: karen lap equals: 0;
		assert: karen position equals: game board size.
]

{ #category : #tests }
GameHandlerTest >> testPlayerDoesntMoveDueToNoEffect [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players with: mixBoard20 laps: 2.
	GameHandler move: karen with: 3 of: game.

	self assert: karen position equals: 4.
]

{ #category : #tests }
GameHandlerTest >> testPlayerFallsBehind [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: (GameHandler fallsBehind: karen with: -5 max: game board size).
	
	self 
		assert: karen lap equals: -1;
		assert: karen position equals: 5.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToAtomicBomb [

	| players game |
	players := karen + andre.
	game := Game playedBy: players with: mixBoard20 laps: 2.
	andre goTo: 4.
	GameHandler move: karen with: 10 of: game.

	self 
		assert: karen position equals: 1;
		assert: andre position equals: 1.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToMoonWalk [

	| players game |
	players := karen + andre.
	game := Game playedBy: players with: mixBoard20 laps: 2.
	andre goTo: 5.
	GameHandler move: karen with: 19 of: game.
	
	self 
		assert: karen position equals: 20;
		assert: andre position equals: 3.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToSpeedUp [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players with: mixBoard20 laps: 2.
	GameHandler move: karen with: 4 of: game.
	
	self assert: karen position equals: 9.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToWormHole [

	| players game |
	players := OrderedCollection with: karen.
	game := Game playedBy: players with: mixBoard20 laps: 2.
	GameHandler move: karen with: 18 of: game.
	
	self assert: karen position equals: 15.
]
