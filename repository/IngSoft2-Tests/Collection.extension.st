Extension { #name : #Collection }

{ #category : #'*IngSoft2-Tests' }
Collection >> + aPlayer [

	^(OrderedCollection withAll:{self. aPlayer})flattened.
]
