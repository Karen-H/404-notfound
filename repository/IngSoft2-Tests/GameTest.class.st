Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameCreation [
	| player1 player2 players game |
	player1 := Player ready.
	player2 := Player ready.
	players := player1 + player2.
	game := Game playedBy: players with: 20.
	self
		assert: game boardSquares equals: 20;
		assert: game numberOfPlayers equals: 2
]

{ #category : #tests }
GameTest >> testOnePlayerRollsUntilGameOver [
	| player players game d4 |
	player := Player ready.
	players := OrderedCollection with: player.
	game := Game playedBy: players with: 20.
	d4 := Die of: 4.
	game play: d4.
	self assert: player position equals: game boardSquares
]

{ #category : #tests }
GameTest >> testPlayUntilGameOver4Players [
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
		assert: game whoWon equals: player3
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayer1 [
	| game player1 player2 d10 d15 dice players |
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
GameTest >> testPlayUntilGameOverWinsPlayer2 [
	| game player1 player2 d4 d8 dice players |
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
GameTest >> testPlayersPosition [
"habria que borrarlo? antes se inicializaban con posiciones 1 y 5"
	| player1 player2 players positions |
	player1 := Player ready.
	player2 := Player ready.
	players := player1 + player2.
	positions := OrderedCollection with: 1 with: 1.
	self assert: (players collect: [ :player | player position ]) equals: positions.

]
