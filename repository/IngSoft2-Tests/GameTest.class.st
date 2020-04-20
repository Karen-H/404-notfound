Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testAddPlayers [

	| player1 player2 players |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 5.
	players:=player1 +player2.
	self assert: players size equals: 2.
	self assert: players first equals: player1.
]

{ #category : #tests }
GameTest >> testGameCreation [

	| game player1 player2 players |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players:=player1 +player2.
	game := Game createWithBoard: 20 allPlayers: players.
	self assert: game returnBoardSquares equals: 20.
	self assert: game returnNumberOfPlayers equals: 2.
]

{ #category : #tests }
GameTest >> testOnePlayerRollsUntilGameOver [

	| game player d4 players |
	player := Player startingPosition: 1.
	players := OrderedCollection with:player.
	game := Game createWithBoard: 20 allPlayers: players.
	d4 := Die of: 4.
	game play: d4.
	self assert: player returnPosition equals: game returnBoardSquares.
]

{ #category : #tests }
GameTest >> testPlayUntilGameOver4Players [

	| player1 player2 player3 player4 players game d10 d12 dice |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	player3 := Player startingPosition: 1.
	player4 := Player startingPosition: 1.
	players :=(player1+player2+player3+player4)flattened.
	game := Game createWithBoard: 20 allPlayers: players.
	d10 := Die of: 10 rolling: #(1 2 3 4 5 1 2 3 4).
	d12 := Die of: 12 rolling: #(6 7 8 9 6 7 8 9 6).
	"Turno1: ( 8 10 12 14 )	Turno2: ( 19 18 20(22, se pasa) 14(no llega a tirar) )	Gana: player3"		
	dice := d10 + d12.	
	game play: dice.
	self 
		assert: player1 returnPosition equals: 19;
		assert: player2 returnPosition equals: 18;
		assert: player3 returnPosition equals: 20;
		assert: player4 returnPosition equals: 14;
		assert: (game whoWon: players) equals: player3.
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayer1 [

	| game player1 player2 d10 d15 dice players |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1+player2.
	game := Game createWithBoard: 20 allPlayers: players.
	d10 := Die of: 10 rolling: #(1 2 10 4 1 2 3).
	d15 := Die of: 15 rolling: #(5 6 7 8 1 2 3).
	"Turno1: ( 7 9 )	Turno2: ( 20(24, se pasa) 9(no llega a tirar) )	Gana: player1"
	dice := d10 + d15.	
	game play: dice.
	self 
		assert: player1 returnPosition equals: 20;
		assert: player2 returnPosition equals: 9;
		assert: (game whoWon: players) equals: player1.
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayer2 [

	| game player1 player2 d4 d8 dice players |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1+player2.
	game := Game createWithBoard: 20 allPlayers: players.
	d4 := Die of: 4 rolling: #(1 2 3 4 1 2 3).
	d8 := Die of: 8 rolling: #(5 6 7 8 1 2 3).
	"Turno1: ( 7 9 )	Turno2: ( 17 20(21, se pasa) )	Gana: player2"
	dice := d4 + d8.	
	game play: dice.
	self 
		assert: player1 returnPosition equals: 17;
		assert: player2 returnPosition equals: 20;
		assert: (game whoWon: players) equals: player2.
]

{ #category : #tests }
GameTest >> testPlayerMaxPosition [

	| player players game |
	player := Player startingPosition: 5.
	players := OrderedCollection with: player.
	game := Game createWithBoard: 20 allPlayers: players.
	player move: 30 limit: game returnBoardSquares.
	self assert: player returnPosition equals: 20.
]

{ #category : #tests }
GameTest >> testPlayersPosition [

	| player1 player2 players positions|
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 5.
	positions := OrderedCollection new.
	positions add: 1. 
	positions add: 5.
	players:=(player1+player2)asOrderedCollection .
	self assert: (players collect: [ :player | player returnPosition ]) equals: positions.

]
