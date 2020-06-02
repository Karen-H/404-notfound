Class {
	#name : #Board,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance variables' }
Board class >> distribute: squares with: tiles [

	| square panel |
	panel := OrderedCollection new.
	
	panel:=self distributing: squares of: panel with: tiles effectAt: AtomicBomb number:1. 
	panel:=self distributing: squares of:panel with: tiles effectAt: MoonWalk number:2.
	panel:=self distributing: squares of:panel with: tiles effectAt: SpeedUp number:3.
	panel:=self distributing: squares of:panel with: tiles effectAt: WormHole number:4.
	
	tiles size timesRepeat: [ 
		panel := panel + ( NoEffect on: (square := tiles atRandom) ).
		tiles remove: square ].
	
	^ panel.

]

{ #category : #accessing }
Board class >> distributing: squares of: panel with: tiles effectAt: effect number:number [
	|square panelNew|
	panelNew:=panel.
	(squares at: number)timesRepeat: [
		panelNew:= panelNew+ (effect on: (square:= tiles atRandom)).
		tiles remove: square] .
	^panelNew.
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
