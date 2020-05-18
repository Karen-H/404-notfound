Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assert: players startOn: board [

	(players select: [ :player | player position > board size ]) isEmpty
		ifFalse: [ InstanceCreationFailed signal: 'The player must start on a valid position' ]

]

{ #category : #validating }
Game class >> assertBoardSquaresGreaterThanOne: board [

	board size > 1
		ifFalse: [ InstanceCreationFailed signal: 'The board must have at least 2 squares' ]
]

{ #category : #validating }
Game class >> assertLapsGreaterThanZero: rounds [

	rounds negative
		ifTrue: [ InstanceCreationFailed signal: 'The winner must move around the board at least once' ]
]

{ #category : #validating }
Game class >> assertPlayersGreaterThanZero: players [

	players isEmpty
		ifTrue: [ InstanceCreationFailed signal: 'There must be at least 1 player' ]
]

{ #category : #'instance variables' }
Game class >> boardWith: squares [

	| tiles atomicBombNum moonWalkNum speedUpNum wormHoleNum panel |
	tiles := (1 to: squares) asOrderedCollection.
	atomicBombNum := (2 percent * squares) asInteger.
	moonWalkNum := (10 percent * squares) asInteger.
	speedUpNum := (20 percent * squares) asInteger.
	wormHoleNum := (20 percent * squares) asInteger.
	panel := { atomicBombNum. moonWalkNum. speedUpNum. wormHoleNum }.
	^ self distribute: panel with: tiles.
]

{ #category : #'instance variables' }
Game class >> distribute: squares with: tiles [

	| square panel |
	panel := OrderedCollection new.
	
	(squares at: 1) timesRepeat: [ 
		panel := panel + ( AtomicBomb on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	(squares at: 2) timesRepeat: [ 
		panel := panel + ( MoonWalk on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	(squares at: 3) timesRepeat: [ 
		panel := panel + ( SpeedUp on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	(squares at: 4) timesRepeat: [ 
		panel := panel + ( WormHole on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	tiles size timesRepeat: [ 
		panel := panel + ( NoEffect on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	^ panel.
]

{ #category : #'instance creation' }
Game class >> playedBy: players with: board laps: rounds [

	self 
		assertBoardSquaresGreaterThanOne: board;
		assertPlayersGreaterThanZero: players;
		assert: players startOn: board;
		assertLapsGreaterThanZero: rounds.

	^ self new
		initializeWith: board
		players: players
		laps: rounds.
]

{ #category : #accessing }
Game >> board [

	^ board.
]

{ #category : #initialization }
Game >> initializeWith: panel players: playersList laps: rounds [

	board := panel.
	players := playersList.
	laps := rounds.
]

{ #category : #playing }
Game >> isOver [

	^ players anySatisfy: [ :player | player position = board size and: player lap = laps ].
]

{ #category : #accessing }
Game >> laps [

	^ laps.
]

{ #category : #playing }
Game >> play: dice [

	[ self isOver ] whileFalse: [
		players do: [ :player | 
			self isOver ifFalse: [ GameHandler move: player with: dice roll of: self ] ] ]
]

{ #category : #accessing }
Game >> players [

	^ players.
]

{ #category : #playing }
Game >> results: playersList [
	
	^ playersList sort: [ :aPlayer :anotherPlayer |
		aPlayer position > anotherPlayer position
			or: [ aPlayer position = anotherPlayer position and: [ aPlayer lap > anotherPlayer lap ] ] ]
]

{ #category : #playing }
Game >> whoWon [

	players 
		detect: [ :player | player position = board size and: player lap = laps ]
		ifFound: [ :winner | ^ winner ]
		ifNone: [ GameException signal: 'Play, you fools!' ]
]
