Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'type',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Card >> isInstant:player within:game [
	
	self subclassResponsibility.
]

{ #category : #accessing }
Card >> name [

	^ name.
]

{ #category : #accessing }
Card >> type [

	^ type.
]
