Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#instVars : [
		'karen',
		'andre',
		'simpleBoard10'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> newPlayer [
	^ Player ready
]

{ #category : #running }
PlayerTest >> setUp [

	super setUp.
	karen := self newPlayer.
	andre := self newPlayer.
	simpleBoard10 := (NoEffect on: 1) + (NoEffect on: 2) + (NoEffect on: 3) + (NoEffect on: 4) + (NoEffect on: 5) + (NoEffect on: 6) + (NoEffect on: 7) + (NoEffect on: 8) + (NoEffect on: 9) + (NoEffect on: 10).

]

{ #category : #tests }
PlayerTest >> testPlayerCreationFailsWithInvalidStartingLap [

	self
		should: [ Player new initializeWithPosition: 1 lap: 3 ]
		raise: InstanceCreationFailed
		withMessageText: 'The player can´t start with previous laps'
]

{ #category : #tests }
PlayerTest >> testPlayerCreationFailsWithInvalidStartingPosition [

	-1 to: 0 do: [ :invalidNumber |
	self
		should: [ Player new initializeWithPosition: invalidNumber lap: 0 ]
		raise: InstanceCreationFailed
		withMessageText: 'A player must start at least in position 1' ]
]
