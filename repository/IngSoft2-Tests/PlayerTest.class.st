Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatePlayersList [

	| player1 player2 players |
	player1 := Player ready.
	player2 := Player ready.
	players := player1 + player2.
	self 
		assert: players first equals: player1;
		assert: players second equals: player2;
		assert: players size equals: 2.
]

{ #category : #tests }
PlayerTest >> testPlayerMove [

	| player |
	player := Player ready.
	Handler move: player with: 5 limit: 10.
	self assert: player position equals: 6.
]

{ #category : #tests }
PlayerTest >> testPlayerMoveToMaxPosition [

	| player |
	player := Player ready.
	Handler move: player with: 15 limit: 10.
	self assert: player position equals: 10.
]

{ #category : #tests }
PlayerTest >> testPlayerRollDice [

	| player d3 d5 dice |
	player := Player ready.
	d3 := Die of: 3 rolling: #(1 2).
	d5 := Die of: 5 rolling: #(3 4).
	dice := d3 + d5.
	Handler move: player with: dice roll limit: 10.
	self assert: player position equals: 5.
	Handler move: player with: dice roll limit: 10.
	self assert: player position equals: 10.
]

{ #category : #tests }
PlayerTest >> testPlayerRollDie [

	| player die |
	player := Player ready.
	die := Die of: 4 rolling: #(1 2).
	Handler move: player with: die roll limit: 10.
	self assert: player position equals: 2.
	Handler move: player with: die roll limit: 10.
	self assert: player position equals: 4.
]

{ #category : #tests }
PlayerTest >> testPlayerStartingPosition [

	| player |
	player := Player ready.
	self assert: player position equals: 1.
]
