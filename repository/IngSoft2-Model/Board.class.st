Class {
	#name : #Board,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Board class >> distribute: squares of: panel with: tiles using: effect at: index [

	|square panelNew|
	panelNew := panel.
	(squares at: index) timesRepeat: [
		panelNew := panelNew + (effect on: (square := tiles atRandom)).
		tiles remove: square ].
	
	^ panelNew.
]

{ #category : #'instance variables' }
Board class >> distribute: squares with: tiles [

	| square panel |
	panel := OrderedCollection new.
	
	panel := self distribute: squares of: panel with: tiles using: AtomicBomb at: 1. 
	panel := self distribute: squares of: panel with: tiles using: MoonWalk at: 2.
	panel := self distribute: squares of: panel with: tiles using: SpeedUp at: 3.
	panel := self distribute: squares of: panel with: tiles using: WormHole at: 4.
	
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
