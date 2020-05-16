Class {
	#name : #GameHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'simpleBoard10',
		'karen',
		'andre'
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

]

{ #category : #tests }
GameHandlerTest >> testMovementExceedsFinalPosition [

	| players game |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 5.
	karen goTo: (GameHandler exceedsMovement: karen with: 25 max: game).
	self 
		assert: karen lap equals: 2;
		assert: karen position equals: 5.
]

{ #category : #tests }
GameHandlerTest >> testMovementExceedsFinalPositionOnFinalLap [

	| players game |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 0.
	karen goTo: (GameHandler exceedsMovement: karen with: 15 max: game).
	self 
		assert: karen lap equals: 0;
		assert: karen position equals: game boardSquares.
]

{ #category : #tests }
GameHandlerTest >> testNumberExceedsFinalPosition [

	| result |
	result := GameHandler exceedsFinalPosition: 15 max: 10.
	self assert: result equals: true.
	
]

{ #category : #tests }
GameHandlerTest >> testPlayerFallsBehind [

	| players game |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: (GameHandler fallsBehind: karen with: -5 max: game boardSquares).
	self 
		assert: karen lap equals: -1;
		assert: karen position equals: 5.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMoves [

	| players game d8 |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	d8 := Die of: 8 rolling: #(3 6).
	GameHandler move: karen with: d8 roll of: game.
	self 
		assert: karen lap equals: 0;
		assert: karen position equals: 4.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToAtomicBomb [

	| players game effect |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: 5.
	effect := (AtomicBomb on: 5) effectNumber.
	GameHandler move: karen due: 'AtomicBomb' with: effect within: game.
	self 
		assert: karen lap equals: 0;
		assert: karen position equals: 1.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToMoonWalk [

	| players game effect |

	players := karen + andre.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: 6.
	andre goTo: 5.
	effect := (MoonWalk on: 6) effectNumber.
	GameHandler move: karen due: 'MoonWalk' with: effect within: game.
	self 
		assert: karen lap equals: 0;
		assert: karen position equals: 6;
		assert: andre position equals: 3.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToNoEffect [

	| players game effect |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: 2.
	effect := (simpleBoard10 at: 2) effectNumber.
	GameHandler move: karen due: 'NoEffect' with: effect within: game.
	self 
		assert: karen lap equals: 0;
		assert: karen position equals: 2.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToSpeedUp [

	| players game effect |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: 8.
	effect := (SpeedUp on: 8) effectNumber.
	GameHandler move: karen due: 'SpeedUp' with: effect within: game.
	self 
		assert: karen lap equals: 1;
		assert: karen position equals: 2.
]

{ #category : #tests }
GameHandlerTest >> testPlayerMovesDueToWormHole [

	| players game effect |

	players := OrderedCollection with: karen.
	game := Game playedBy: players with: simpleBoard10 laps: 2.
	karen goTo: 2.
	effect := (WormHole on: 2) effectNumber.
	GameHandler move: karen due: 'WormHole' with: effect within: game.
	self 
		assert: karen lap equals: -1;
		assert: karen position equals: 8.
]
