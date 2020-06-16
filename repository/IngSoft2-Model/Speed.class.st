Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Speed class >> onDeck [

	| effectNumber |
	effectNumber := 1.
			
	^ self new 
		initialize: 'Speed'
		with: effectNumber
		type: 'Permanent'.
]

{ #category : #'as yet unclassified' }
Speed >> usedBy: player in:otherPlayer within: game [

	otherPlayer active: self.
	player remove: self from: player hand.
	game lastUsed: self.
]

{ #category : #'as yet unclassified' }
Speed >> usedBy: player within: game [

	player active: self.
	player remove: self from: player hand.
	game lastUsed: self.
]
