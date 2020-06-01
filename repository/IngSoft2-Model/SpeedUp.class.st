Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUp class >> on: boardNumber [

	| effectNumber |
	effectNumber := 4.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		with: effectNumber
		type: 'SpeedUp'.
]

{ #category : #playing }
SpeedUp >> move: player within: game [
	^ self movee:player within: game. 
]
