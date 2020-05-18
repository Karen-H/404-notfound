Extension { #name : #Square }

{ #category : #'*IngSoft2-Tests' }
Square >> + aSquare [

	| board |
	board := OrderedCollection withAll: ({ self . aSquare } flattened).
	^ board.
]
