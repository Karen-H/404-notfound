Extension { #name : #Player }

{ #category : #'*IngSoft2-Tests' }
Player >> + aPlayer [

	| players |
	players := OrderedCollection withAll: ({ self . aPlayer } flattened).
	^ players.

]
