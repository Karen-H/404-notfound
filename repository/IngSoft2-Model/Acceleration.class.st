Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Acceleration class >> onDeck [

	| effectNumber |
	effectNumber := 1.
			
	^ self new 
		initialize: 'Acceleration'
		with: effectNumber
		type: 'Permanent'.
]

{ #category : #playing }
Acceleration >> usedBy: player within: game [

	game players do: [ :member | member active: self ].
	player remove: self from: player hand.
	game lastUsed: self.
]
