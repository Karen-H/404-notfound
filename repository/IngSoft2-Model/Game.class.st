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

{ #category : #'instance creation' }
Game class >> playedBy: players on: board with: rounds [

	self 
		assertBoardSquaresGreaterThanOne: board;
		assertPlayersGreaterThanZero: players;
		assert: players startOn: board;
		assertLapsGreaterThanZero: rounds.

	^ self new
		initialize: board
		playedBy: players
		with: rounds.
]

{ #category : #accessing }
Game >> board [

	^ board.
]

{ #category : #initialization }
Game >> initialize: panel playedBy: playersList with: rounds [

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
			self isOver ifFalse: [ GameHandler new move: player rolling: dice roll within: self ] ] ]
]

{ #category : #accessing }
Game >> players [

	^ players.
]

{ #category : #playing }
Game >> results [
	
	^ players sort: [ :aPlayer :anotherPlayer |
		aPlayer position > anotherPlayer position
			or: [ aPlayer position = anotherPlayer position
				and: [ aPlayer position > anotherPlayer lap ] ] ]
]

{ #category : #playing }
Game >> whoWon [

	players 
		detect: [ :player | player position = board size and: player lap = laps ]
		ifFound: [ :winner | ^ winner ]
		ifNone: [ GameException signal: 'Play, you fools!' ]
]
