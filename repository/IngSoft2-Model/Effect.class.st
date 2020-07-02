Class {
	#name : #Effect,
	#superclass : #Object,
	#instVars : [
		'type',
		'positionOnBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Effect class >> assertNumberGreaterThanZero: boardNumber [

	boardNumber > 0
		ifFalse: [ InstanceCreationFailed signal: 'Must assign a positive number to the square' ]
]

{ #category : #playing }
Effect >> applyEffectOn: player within: game [

	self subclassResponsibility.
]

{ #category : #accessing }
Effect >> type [

	^ type.
]
