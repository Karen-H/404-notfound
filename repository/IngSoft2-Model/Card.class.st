Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #arithmetic }
Card >> + aCard [

	| deck |
	deck := OrderedCollection withAll: ({ self . aCard } flattened).
	^ deck.
]
