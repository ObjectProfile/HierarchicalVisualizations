"
this class defines a basic link between nodes
"
Class {
	#name : #HLink,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'visible',
		'rawModel'
	],
	#category : #'Hierarchical-Model-Core'
}

{ #category : #accessing }
HLink >> from [

	^ from
]

{ #category : #accessing }
HLink >> from: anObject [

	from := anObject
]

{ #category : #initialization }
HLink >> initialize [
	super initialize.
	self isVisible: true
]

{ #category : #testing }
HLink >> isVisible [
	^ visible
]

{ #category : #testing }
HLink >> isVisible: aBoolean [
	visible := aBoolean
]

{ #category : #accessing }
HLink >> rawModel [
	^ rawModel
]

{ #category : #accessing }
HLink >> rawModel: aClass [ 
	rawModel := aClass
]

{ #category : #accessing }
HLink >> to [

	^ to
]

{ #category : #accessing }
HLink >> to: anObject [

	to := anObject
]
