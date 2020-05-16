Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#instVars : [
		'simpleBoard10'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> testSetOfSquares [

	| board |
	board := (NoEffect on: 1) + (SpeedUp on: 2) + (AtomicBomb on: 3) + (WormHole on: 4) + (MoonWalk on: 5).
	self 
		assert: board size equals: 5;
		assert: ( board at: 1 ) effectNumber equals: 0;
		assert: ( board at: 3 ) number equals: 3;
		assert: ( board at: 5 ) type equals: 'MoonWalk'.
]

{ #category : #tests }
SquareTest >> testSquareCreationFailsWithInvalidNumber [

	-1 to: 0 do: [ :invalidNumber |
	self
		should: [ SpeedUp on: invalidNumber ]
		raise: InstanceCreationFailed
		withMessageText: 'Must assign a positive number to the square' ]
]
