Extension { #name : #Card }

{ #category : #'*IngSoft2-Tests' }
Card >> + aCard [

	| deck |
	deck := OrderedCollection withAll: ({ self . aCard } flattened).
	^ deck.
]
