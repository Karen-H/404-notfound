Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> test01 [
	^0.
]

{ #category : #tests }
GameTest >> testCreationFailsWithEmptyBoard [

	self
		should:[Game createWithBoard: 0 allPlayers: #(1)]
		raise: InstanceCreationFailed
		withMessageText:'The board must have at least 2 squares'

]

{ #category : #tests }
GameTest >> testCreationFailsWithEmptyPlayers [

	self
		should:[Game createWithBoard: 20 allPlayers: #()]
		raise: InstanceCreationFailed
		withMessageText:'There must be at least 1 player'

]

{ #category : #tests }
GameTest >> testGameCreationComposition [

	| player1 player2 players game |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1 + player2.
	game := Game createWithBoard: 20 allPlayers: players.
	self 
		assert: game returnBoardSquares equals: 20;
		assert: game returnNumberOfPlayers equals: 2.
]

{ #category : #tests }
GameTest >> testGameCreationDiceFirstTurn [
	|player1 player2 game d3 d5 dice board players|
	player1:= Player startingPosition: 1.
	player2:= Player startingPosition: 1.
	players:= player1+player2.
	board:= 20.
	d3:= Die of: 3 rolling:#(1 2).
	d5:= Die of: 5 rolling:#(3 4).
	dice:= d3+d5.
	player1 move: dice roll limit:board.
	player2 move: dice roll limit:board.
	
	game:= Game createWithBoard: board allPlayers:players. 
	self assert: player1 returnPosition equals: 5;
		  assert: player2 returnPosition equals: 7;
		  assert: game returnBoardSquares equals:20;
		  assert: game returnNumberOfPlayers equals:2.
]

{ #category : #tests }
GameTest >> testGameCreationDiceSecondTurn [

	|player1 player2 game d3 d5 dice board players|
	player1:= Player startingPosition: 1.
	player2:= Player startingPosition: 1.
	players:= player1+player2.
	board:= 20.
	d3:= Die of: 3 rolling:#(1 2).
	d5:= Die of: 5 rolling:#(3 4).
	dice:= d3+d5.
	player1 move: dice roll limit:board.
	player2 move: dice roll limit:board.
	game:= Game createWithBoard: board allPlayers:players. 
	
	self assert: player1 returnPosition equals: 5;
		  assert: player2 returnPosition equals: 7;
		  assert: game returnBoardSquares equals:20;
		  assert: game returnNumberOfPlayers equals:2.
	
	player1 move: dice roll limit:board.
	player2 move: dice roll limit:board.
	
	self assert: player1 returnPosition equals: 9;
		  assert: player2 returnPosition equals: 13.
]

{ #category : #tests }
GameTest >> testGameCreationDieFirtTurn [
| player1 player2 players game board die|
	
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1 + player2.
	board:=10.
	game := Game createWithBoard: board allPlayers: players.
	die:= Die of: 4 rolling:#(1 2). 
	player1 move:die roll limit:10.
	player2 move:die roll limit:10.
	self 
		assert: game returnBoardSquares equals: 10;
		assert: game returnNumberOfPlayers equals: 2;
		assert: player1 returnPosition equals:2;
		assert: player2 returnPosition equals:3.
]

{ #category : #tests }
GameTest >> testGameCreationDieSecondTurn [
	| player1 player2 players game board die|
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1 + player2.
	board:=10.
	game := Game createWithBoard: board allPlayers: players.
	die:= Die of: 4 rolling:#(1 2 3 4). 
	
	player1 move:die roll limit:10.
	player2 move:die roll limit:10.
	
	self 
		assert: game returnBoardSquares equals: 10;
		assert: game returnNumberOfPlayers equals: 2.
	
	player1 move:die roll limit:10.
	player2 move:die roll limit:10.
	
	self
		assert: player1 returnPosition equals:5;
		assert: player2 returnPosition equals:7.
]

{ #category : #tests }
GameTest >> testGameIsOverWhenPlayerReacherFinalPosition [

	| player players game d4 |
	player := Player startingPosition: 1.
	players := OrderedCollection with: player.
	game := Game createWithBoard: 20 allPlayers: players.
	d4 := Die of: 4.
	game play: d4.
	self assert: player returnPosition equals: game returnBoardSquares.
]

{ #category : #tests }
GameTest >> testGameNoPlayers [
	|players game|
	players:=OrderedCollection with: 0.
	game:= Game createWithBoard: 10 allPlayers: players.
	self assert: game returnBoardSquares equals:10;
		  assert: players first equals: 0.
]

{ #category : #tests }
GameTest >> testGameNotOver [
	| player players game |
	
	player := Player startingPosition: 1.
	players := OrderedCollection with: player.
	
	game := Game createWithBoard: 20 allPlayers: players.
	"d4 := Die of: 4."
	"game play: d4."
	self assert: (player returnPosition < game returnBoardSquares).
]

{ #category : #tests }
GameTest >> testGameNotOverFourPlayers [
	| player1 player2 player3 player4 players game "d10 d12 dice" |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	player3 := Player startingPosition: 1.
	player4 := Player startingPosition: 1.
	players := player1 + player2 + player3 + player4.
	game := Game createWithBoard: 20 allPlayers: players.
	"d10 := Die of: 10 rolling: #(1 2 3 4 5 1 2 3 4).
	d12 := Die of: 12 rolling: #(6 7 8 9 6 7 8 9 6)."
	"Turno1: ( 8 10 12 14 )	Turno2: ( 19 18 20(22, se pasa) 14(no llega a tirar) )	Gana: player3"		
	"dice := d10 + d12.	
	game play: dice."
	self 
		assert: (player1 returnPosition between: 1 and: game returnBoardSquares);
		assert: (player2 returnPosition between: 1 and: game returnBoardSquares);
		assert: (player3 returnPosition between: 1 and: game returnBoardSquares);
		assert: (player4 returnPosition between: 1 and: game returnBoardSquares).
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverFourPlayers [

	| player1 player2 player3 player4 players game d10 d12 dice |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	player3 := Player startingPosition: 1.
	player4 := Player startingPosition: 1.
	players := player1 + player2 + player3 + player4.
	game := Game createWithBoard: 20 allPlayers: players.
	d10 := Die of: 10 rolling: #(1 2 3 4 5 1 2 3 4).
	d12 := Die of: 12 rolling: #(6 7 8 9 6 7 8 9 6).
	"Turno1: ( 8 10 12 14 )	Turno2: ( 19 18 20(22, se pasa) 14(no llega a tirar) )	Gana: player3."		
	dice := d10 + d12.	
	
	game play: dice.
	self 
		assert: player1 returnPosition equals: 19;
		assert: player2 returnPosition equals: 18;
		assert: player3 returnPosition equals: 20;
		assert: player4 returnPosition equals: 14;
		assert: game whoWon equals: player3.
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerOne [

	| game player1 player2 d10 d15 dice players |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1 + player2.
	game := Game createWithBoard: 20 allPlayers: players.
	d10 := Die of: 10 rolling: #(1 2 10 4 1 2 3).
	d15 := Die of: 15 rolling: #(5 6 7 8 1 2 3).
	"Turno1: ( 7 9 )	Turno2: ( 20(24, se pasa) 9(no llega a tirar) )	Gana: player1"
	dice := d10 + d15.	
	game play: dice.
	self 
		assert: player1 returnPosition equals: 20;
		assert: player2 returnPosition equals: 9;
		assert: game whoWon equals: player1.
]

{ #category : #tests }
GameTest >> testPlayUntilGameOverWinsPlayerTwo [

	| game player1 player2 d4 d8 dice players |
	player1 := Player startingPosition: 1.
	player2 := Player startingPosition: 1.
	players := player1 + player2.
	game := Game createWithBoard: 20 allPlayers: players.
	d4 := Die of: 4 rolling: #(1 2 3 4 1 2 3).
	d8 := Die of: 8 rolling: #(5 6 7 8 1 2 3).
	"Turno1: ( 7 9 )	Turno2: ( 17 20(21, se pasa) )	Gana: player2"
	dice := d4 + d8.	
	game play: dice.
	self 
		assert: player1 returnPosition equals: 17;
		assert: player2 returnPosition equals: 20;
		assert: game whoWon equals: player2.
]

{ #category : #tests }
GameTest >> testPlayerMaxPosition [

	| player players game die|
	player := Player startingPosition: 5.
	players := OrderedCollection with: player.
	game := Game createWithBoard: 20 allPlayers: players.
	die:=Die of: 10 rolling:#(5 10). 
	player move:die roll limit:20.
	player move:die roll limit:20.
	"player move: 30 limit: game returnBoardSquares."
	self assert: player returnPosition equals: 20;
		  assert: game returnBoardSquares equals:20.
]
