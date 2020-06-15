Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Overload class >> onDeck [

	| effectNumber |
	effectNumber := -2.
			
	^ self new 
		initialize: 'Overload'
		with: effectNumber
		type: 'Permanent'.
]

{ #category : #'as yet unclassified' }
Overload >> usedBy: player within: game [

	| target |
	target := player chooseTargetFrom: game.
	target active: self.
	player remove: self from: player hand.
	game lastUsed: self.
	
]
