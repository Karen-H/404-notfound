Class {
	#name : #BoardCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
BoardCreator >> distribute: squares of: panel with: tiles using: effect at: index [

	|square panelNew|
	panelNew := panel.
	(squares at: index) timesRepeat: [
		panelNew := panelNew + (effect on: (square := tiles atRandom)).
		tiles remove: square ].
	
	^ panelNew.
]

{ #category : #'instance variables' }
BoardCreator >> distribute: squares with: tiles [

	| square panel |
	panel := OrderedCollection new.
	panel := self distribute: squares of: panel with: tiles using: AtomicBomb at: 1. 
	panel := self distribute: squares of: panel with: tiles using: DrawCard at: 2.
	panel := self distribute: squares of: panel with: tiles using: MoonWalk at: 3.
	panel := self distribute: squares of: panel with: tiles using: SpeedUp at: 4.
	panel := self distribute: squares of: panel with: tiles using: WormHole at: 5.
	tiles size timesRepeat: [ 
		panel := panel + (NoEffect on: (square := tiles atRandom)).
		tiles remove: square ].
	^ panel.

]

{ #category : #'instance creation' }
BoardCreator >> of: squares with: squareType at: position [

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
BoardCreator >> withRandomlyDistributed: squares [

	| tiles atomicBombNum moonWalkNum speedUpNum wormHoleNum panel drawCardNum |
	tiles := (1 to: squares) asOrderedCollection.
	atomicBombNum := (2 percent * squares) asInteger.
	drawCardNum := (3 percent * squares) asInteger.
	moonWalkNum := (10 percent * squares) asInteger.
	speedUpNum := (20 percent * squares) asInteger.
	wormHoleNum := (20 percent * squares) asInteger.
	panel := { atomicBombNum. drawCardNum. moonWalkNum. speedUpNum. wormHoleNum }.
	^ self distribute: panel with: tiles.
]
