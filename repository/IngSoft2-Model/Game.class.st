Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'boardSize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assert: players startInside: board [

	(players select: [ :player | player position > board ]) isEmpty
		ifFalse: [ InstanceCreationFailed signal: 'The player must start on a valid position' ]

]

{ #category : #validating }
Game class >> assertBoardSquaresGreaterThanOne: numberOfSquares [

	numberOfSquares > 1
		ifFalse: [ InstanceCreationFailed signal: 'The board must have at least 2 squares' ]
]

{ #category : #validating }
Game class >> assertPlayersGreaterThanZero: players [

	players isEmpty
		ifTrue: [ InstanceCreationFailed signal: 'There must be at least 1 player' ]
]

{ #category : #'instance creation' }
Game class >> playedBy: players with: numberOfSquares [

	self 
		assertBoardSquaresGreaterThanOne: numberOfSquares;
		assertPlayersGreaterThanZero: players;
		assert: players startInside: numberOfSquares.

	^ self new
		initializeWithBoard: numberOfSquares
		players: players.
]

{ #category : #accessing }
Game >> boardSquares [

	^ boardSize.
]

{ #category : #initialization }
Game >> initializeWithBoard: numberOfSquares players: playersList [

	boardSize := numberOfSquares.
	players := playersList.
]

{ #category : #playing }
Game >> isOver [

	^ players anySatisfy: [ :player | player position = boardSize ].
]

{ #category : #accessing }
Game >> numberOfPlayers [

	^ players size.
]

{ #category : #playing }
Game >> play: dice [

	[ self isOver ] whileFalse: [
		players do: [ :player | 
			self isOver ifFalse: [ GameHandler move: player with: dice roll limit: boardSize ] ] ]
]

{ #category : #playing }
Game >> results: playersList [

	^ playersList asSortedCollection: [ :aPlayer :anotherPlayer | aPlayer position > anotherPlayer position ]
]

{ #category : #playing }
Game >> whoWon [

	players 
		detect: [ :player | player position == boardSize ]
		ifFound: [ :winner | ^ winner ]
		ifNone: [ GameException signal: 'Play, you fools!' ]
]
