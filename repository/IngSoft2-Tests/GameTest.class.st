Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameCreationFailsWithInvalidBoardSize [

	| player1 player2 players |
	player1 := Player ready.
	player2 := Player ready.
	players := player1 + player2.

	self
		should: [ Game playedBy: players with: 0 ]
		raise: InstanceCreationFailed
		withMessageText: 'The board must have at least 2 squares'


]

{ #category : #tests }
GameTest >> testGameCreationFailsWithoutPlayers [

	| players |
	players := #().

	self
		should: [ Game playedBy: players with: 20 ]
		raise: InstanceCreationFailed
		withMessageText: 'There must be at least 1 player'


]

{ #category : #tests }
GameTest >> testGameIsOverWhenPlayerReachesFinalPosition [

	| player players game d4 |
	player := Player ready.
	players := OrderedCollection with: player.
	game := Game playedBy: players with: 20.
	d4 := Die of: 4.
	game play: d4.
	
	self assert: player position equals: game boardSquares
]

{ #category : #tests }
GameTest >> testGameNotOver [

	| player players game |
	player := Player ready.
	players := OrderedCollection with: player.
	game := Game playedBy: players with: 20.
		
	self
		should: [ game whoWon ]
		raise: GameException
		withMessageText: 'Play, you fools!'
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerOne [

	| player1 player2 players game d10 d15 dice |
	player1 := Player ready.
	player2 := Player ready.
	players := player1 + player2.
	game := Game playedBy: players with: 20.
	d10 := Die of: 10 rolling: #(1 2 10 4 1 2 3).
	d15 := Die of: 15 rolling: #(5 6 7 8 1 2 3).
	dice := d10 + d15.
	game play: dice.
	
	self
		assert: player1 position equals: 20;
		assert: player2 position equals: 9;
		assert: game whoWon equals: player1
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerTwo [

	| player1 player2 players game d4 d8 dice |
	player1 := Player ready.
	player2 := Player ready.
	players := player1 + player2.
	game := Game playedBy: players with: 20.
	d4 := Die of: 4 rolling: #(1 2 3 4 1 2 3).
	d8 := Die of: 8 rolling: #(5 6 7 8 1 2 3).
	dice := d4 + d8.
	game play: dice.
	
	self
		assert: player1 position equals: 17;
		assert: player2 position equals: 20;
		assert: game whoWon equals: player2
]

{ #category : #tests }
GameTest >> testPlayerCantExceedMaxPosition [

	| player players d8 d9 dice game |
	player := Player ready.
	players := OrderedCollection with: player.
	d8 := Die of: 8 rolling: #(3 6).
	d9 := Die of: 9 rolling: #(5 8).
	dice := d8 + d9.
	game := Game playedBy: players with: 20.
	game play: dice.
	
	self assert: player position equals: 20.

]

{ #category : #tests }
GameTest >> testPlayersFinalPositions [

	| player1 player2 player3 player4 players game d10 d12 dice |
	player1 := Player ready.
	player2 := Player ready.
	player3 := Player ready.
	player4 := Player ready.
	players := player1 + player2 + player3 + player4.
	game := Game playedBy: players with: 20.
	d10 := Die of: 10 rolling: #(1 2 3 4 5 1 2 3 4).
	d12 := Die of: 12 rolling: #(6 7 8 9 6 7 8 9 6).
	dice := d10 + d12.
	game play: dice.
	
	self
		assert: player1 position equals: 19;
		assert: player2 position equals: 18;
		assert: player3 position equals: 20;
		assert: player4 position equals: 14;
		assert: game whoWon equals: player3.
		
	players := game results: players.
	self 
		assert: players first equals: player3;
		assert: players second equals: player1;
		assert: players third equals: player2;
		assert: players last equals: player4.
]
