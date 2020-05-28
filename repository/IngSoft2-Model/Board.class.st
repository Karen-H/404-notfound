Class {
	#name : #Board,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variables' }
Board class >> distribute: squares with: tiles [

	| square panel |
	panel := OrderedCollection new.
	
	(squares at: 1) timesRepeat: [ 
		panel := panel + ( AtomicBomb on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	(squares at: 2) timesRepeat: [ 
		panel := panel + ( MoonWalk on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	(squares at: 3) timesRepeat: [ 
		panel := panel + ( SpeedUp on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	(squares at: 4) timesRepeat: [ 
		panel := panel + ( WormHole on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	tiles size timesRepeat: [ 
		panel := panel + ( NoEffect on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	^ panel.
]

{ #category : #'instance creation' }
Board class >> of: squares with: squareType at: position [

	| board tiles square |
	board := OrderedCollection new.
	tiles := (1 to: squares) asOrderedCollection.
	squares timesRepeat: [ 
		square := tiles first.
		board := square = position
			ifTrue: [ board + (squareType on: position) ]
			ifFalse: [ board + (NoEffect on: square) ].
		tiles remove: square ].
	^ board
]

{ #category : #'instance creation' }
Board class >> withRandomlyDistributed: squares [

	| tiles atomicBombNum moonWalkNum speedUpNum wormHoleNum panel |
	tiles := (1 to: squares) asOrderedCollection.
	atomicBombNum := (2 percent * squares) asInteger.
	moonWalkNum := (10 percent * squares) asInteger.
	speedUpNum := (20 percent * squares) asInteger.
	wormHoleNum := (20 percent * squares) asInteger.
	panel := { atomicBombNum. moonWalkNum. speedUpNum. wormHoleNum }.
	^ self distribute: panel with: tiles.
]
