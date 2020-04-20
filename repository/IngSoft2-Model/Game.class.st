Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'position',
		'players',
		'board'
	],
	#category : #'IngSoft2-Model'
}

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
Game class >> createWithBoard: numberOfSquares allPlayers: players [

	self 
		assertBoardSquaresGreaterThanOne: numberOfSquares;
		assertPlayersGreaterThanZero: players.

	^ self new
		initializeWithBoard: numberOfSquares
		players: players.
]

{ #category : #initialization }
Game >> initializeWithBoard: numberOfSquares players: playersList [

	board := numberOfSquares.
	players := playersList.
]

{ #category : #playing }
Game >> isOver [

	^ players anySatisfy: [ :player | player returnPosition == board ].
]

{ #category : #playing }
Game >> play: dice [
	
	[ self isOver ] 
		whileFalse:
			[ players do: 
				[ :player | players 
				detect: 
					[ :gamer | gamer returnPosition == board ]
				ifNone: 
					[ player move: dice roll limit: board ] ] ] .
	
]

{ #category : #accessing }
Game >> returnBoardSquares [

	^ board.
]

{ #category : #accessing }
Game >> returnNumberOfPlayers [

	^ players size.
]

{ #category : #playing }
Game >> whoWon [

	| winner |
	winner := players detect: [ :player | player returnPosition == board ].
	^ winner.
]
