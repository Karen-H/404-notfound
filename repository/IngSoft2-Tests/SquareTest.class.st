Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> testSquareCreationFailsWithInvalidNumber [

	-1 to: 0 do: [ :invalidNumber |
	self
		should: [ SpeedUp on: invalidNumber ]
		raise: InstanceCreationFailed
		withMessageText: 'Must assign a positive number to the square' ]
]
