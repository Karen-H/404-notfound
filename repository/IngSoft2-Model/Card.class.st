Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'type',
		'name',
		'effectNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
Card >> initialize: effect with: aNumber type: cardType [

	name := effect.
	effectNumber := aNumber.
	type := cardType.
]

{ #category : #accessing }
Card >> name [

	^ name.
]

{ #category : #accessing }
Card >> type [

	^ type.
]
