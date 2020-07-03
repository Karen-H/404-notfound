Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBomb class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize:'AtomicBomb'.
]

{ #category : #playing }
AtomicBomb >> applyEffectOn: player within: game [

	game players do: [ :gamer | gamer square: 1 ].
	game lastSteppedOn: self.
]

{ #category : #initialization }
AtomicBomb >> initialize:name [
	type := name.
]
