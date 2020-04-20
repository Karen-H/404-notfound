Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerGoTo [

	| player |
	player := Player startingPosition: 1.
	player move: 5 limit: 10.
	self assert: player returnPosition equals: 6.
]

{ #category : #tests }
PlayerTest >> testPlayerGoToAll [
	|players p1 p2|
	p1:=Player startingPosition: 1.
	p2:=Player startingPosition: 1.
	players:=p1+p2.
	self assert: (players first)  equals:p1;
		  assert: (players second) equals:p2.
]

{ #category : #tests }
PlayerTest >> testPlayerGoToMaxPosition [

	| player |
	player := Player startingPosition: 1.
	player move: 15 limit: 10.
	self assert: player returnPosition equals: 10.
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

{ #category : #tests }
PlayerTest >> testPlayerStartingPosition [

	| player |
	player := Player startingPosition: 1.
	self assert: player returnPosition equals: 1.
]
