Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatePlayersList [

	| player1 player2 players |
	player1 := Player startingPosition: 8.
	player2 := Player startingPosition: 5.
	players := player1 + player2.
	self 
		assert: (players first) equals: player1;
		assert: (players second) equals: player2;
		assert: players size equals: 2.
]

{ #category : #tests }
PlayerTest >> testCreationFailsWithPositionNegative [
	self
	should:[Player startingPosition: -1]
	raise:InstanceCreationFailed
	withMessageText:'A player must start at least in position 1'

]

{ #category : #tests }
PlayerTest >> testPlayerRollDice [

	| player d3 d5 dice |
	player := Player startingPosition: 1.
	d3 := Die of: 3 rolling: #(1 2).
	d5 := Die of: 5 rolling: #(3 4).
	dice := d3 + d5.
	player move: dice roll limit: 10.
	self assert: player returnPosition equals: 5.
	player move: dice roll limit: 10.
	self assert: player returnPosition equals: 10.
]

{ #category : #tests }
PlayerTest >> testPlayerRollDie [

	| player die |
	player := Player startingPosition: 1.
	die := Die of: 4 rolling: #(1 2).
	player move: die roll limit: 10.
	self assert: player returnPosition equals: 2.
	player move: die roll limit: 10.
	self assert: player returnPosition equals: 4.
]
