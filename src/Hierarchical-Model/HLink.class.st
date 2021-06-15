"
this class defines a basic link between nodes
"
Class {
	#name : #HLink,
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Hierarchical-Model'
}

{ #category : #accessing }
HLink >> from [

	^ from
]

{ #category : #accessing }
HLink >> from: anObject [

	from := anObject
]

{ #category : #accessing }
HLink >> to [

	^ to
]

{ #category : #accessing }
HLink >> to: anObject [

	to := anObject
]
