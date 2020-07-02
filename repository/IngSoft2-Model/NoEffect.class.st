Class {
	#name : #NoEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		type: 'NoEffect'.
]

{ #category : #playing }
NoEffect >> applyEffectOn: player within: game [
]

{ #category : #initialization }
NoEffect >> initialize: boardNumber type: name [

	positionOnBoard := boardNumber.
	type := name.
]
