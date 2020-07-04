Class {
	#name : #NoEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: 'NoEffect'.
]

{ #category : #playing }
NoEffect >> applyEffectOn: player within: game [
	
	game beAtPlay:player.
]

{ #category : #initialization }
NoEffect >> initialize: name [

	type := name.
]
