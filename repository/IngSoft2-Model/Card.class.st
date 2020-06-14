Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Card >> initializeWith:typeCard [
	type:=typeCard.
]

{ #category : #accessing }
Card >> type [
	^type.
]
