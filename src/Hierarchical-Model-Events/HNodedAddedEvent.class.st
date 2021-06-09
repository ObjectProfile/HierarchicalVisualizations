"
todo
"
Class {
	#name : #HNodedAddedEvent,
	#superclass : #HEvent,
	#instVars : [
		'newChild'
	],
	#category : #'Hierarchical-Model-Events'
}

{ #category : #accessing }
HNodedAddedEvent >> newChild [

	^ newChild
]

{ #category : #accessing }
HNodedAddedEvent >> newChild: anObject [

	newChild := anObject
]
