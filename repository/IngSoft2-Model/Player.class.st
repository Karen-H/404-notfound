
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> ready [

	^ self new initializeWithPosition: 1.
]

{ #category : #asserting }
Player >> assertPositionGreaterThanZero: aPosition [

	aPosition > 0
		ifFalse: [ InstanceCreationFailed signal: 'A player must start at least in position 1' ]
]

{ #category : #accessing }
Player >> goTo: newPosition [

	position := newPosition.
]

{ #category : #initialization }
Player >> initializeWithPosition: positionOnBoard [

	self assertPositionGreaterThanZero: positionOnBoard.

	position := positionOnBoard.
]

{ #category : #accessing }
Player >> position [

	^ position.
]
