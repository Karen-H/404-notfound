Extension { #name : #Effect }

{ #category : #'*IngSoft2-Tests' }
Effect >> + aSquare [

	| board |
	board := OrderedCollection withAll: ({ self . aSquare } flattened).
	^ board.
]
