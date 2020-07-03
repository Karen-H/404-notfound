Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'laps',
		'deck',
		'activeCards',
		'lastCardUsed',
		'lastSquareSteppedOn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assert: players startOn: board [

	(players select: [ :player | player boardSquare > board size ]) isEmpty
		ifFalse: [ InstanceCreationFailed signal: 'The player must start on a valid position' ]

]

{ #category : #validating }
Game class >> assertBoardSquaresGreaterThanOne: board [

	board size > 1
		ifFalse: [ InstanceCreationFailed signal: 'The board must have at least 2 squares' ]
]

{ #category : #asserting }
Game class >> assertDeckIsNotEmpty: deck [

	deck isEmpty
		ifTrue: [ InstanceCreationFailed signal: 'The deck must have cards' ]
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
Game class >> playedBy: players on: board with: rounds using: deck [

	self 
		assertBoardSquaresGreaterThanOne: board;
		assertPlayersGreaterThanZero: players;
		assert: players startOn: board;
		assertLapsGreaterThanZero: rounds;
		assertDeckIsNotEmpty: deck cards.

	^ self new
		initialize: board
		playedBy: players
		with: rounds
		using: deck.
]

{ #category : #accessing }
Game >> active: card [

	activeCards add: card.
]

{ #category : #accessing }
Game >> activeCards [

	^ activeCards.
]

{ #category : #accessing }
Game >> board [

	^ board.
]

{ #category : #accessing }
Game >> deck [

	^ deck.
]

{ #category : #initialization }
Game >> initialize: panel playedBy: playersList with: rounds using: cards [

	board := panel.
	players := playersList.
	laps := rounds.
	deck := cards.
	activeCards := OrderedCollection new.
	lastCardUsed := Card new.
	lastSquareSteppedOn := Effect new.
]

{ #category : #playing }
Game >> isOver [

	^ players anySatisfy: [ :player | player boardSquare = board size and: player lap = laps ].
]

{ #category : #accessing }
Game >> laps [

	^ laps.
]

{ #category : #accessing }
Game >> lastCardUsed [

	^ lastCardUsed.
]

{ #category : #accessing }
Game >> lastSquareSteppedOn [

	^ lastSquareSteppedOn.
]

{ #category : #accessing }
Game >> lastSteppedOn: tile [

	lastSquareSteppedOn := tile.
]

{ #category : #accessing }
Game >> lastUsed: card [ 

	lastCardUsed := card.
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
Game >> whoWon [

	players 
		detect: [ :player | player boardSquare = board size and: player lap = laps ]
		ifFound: [ :winner | ^ winner ]
		ifNone: [ GameException signal: 'Play, you fools!' ]
]
