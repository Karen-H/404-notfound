Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'position',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> ready [

	^ self new 
		initializeWithPosition: 1
		lap: 0.
]

{ #category : #asserting }
Player >> assertLapsDifferentThanZero: rounds [

	rounds ~= 0
		ifTrue: [ InstanceCreationFailed signal: 'The player can´t start with previous laps' ]
]

{ #category : #asserting }
Player >> assertPositionGreaterThanZero: aPosition [

	aPosition > 0
		ifFalse: [ InstanceCreationFailed signal: 'A player must start at least in position 1' ]
]

{ #category : #accessing }
Player >> changeLap: aNumber [

	lap := aNumber.
]

{ #category : #accessing }
Player >> goTo: aNumber [

	position := aNumber.
]

{ #category : #initialization }
Player >> initializeWithPosition: positionOnBoard lap: round [

	self assertPositionGreaterThanZero: positionOnBoard.
	self assertLapsDifferentThanZero: round.

	position := positionOnBoard.
	lap := round.
]

{ #category : #accessing }
Player >> lap [

	^ lap.
]

{ #category : #accessing }
Player >> position [

	^ position.
]
