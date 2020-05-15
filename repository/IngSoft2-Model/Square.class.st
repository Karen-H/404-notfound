Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'number',
		'effectNumber',
		'type'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Square class >> assertNumberGreaterThanZero: boardNumber [

	boardNumber > 0
		ifFalse: [ InstanceCreationFailed signal: 'Must assign a positive number to the square' ]
]

{ #category : #arithmetic }
Square >> + aSquare [

	| board |
	board := OrderedCollection withAll: ({ self . aSquare } flattened).
	^ board.
]

{ #category : #accessing }
Square >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
Square >> initializeWith: boardNumber effect: aNumber type: name [

	number := boardNumber.
	effectNumber := aNumber.
	type := name.
]

{ #category : #accessing }
Square >> number [ 

	^ number.
]

{ #category : #accessing }
Square >> type [

	^ type.
]
