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
Card >> isInstant [
	
	(type = 'Instant')
		ifTrue:[^true].
	^false.
]

{ #category : #accessing }
Card >> name [

	^ name.
]

{ #category : #accessing }
Card >> type [

	^ type.
]
