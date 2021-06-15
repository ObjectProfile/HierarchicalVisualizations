"
todo
"
Class {
	#name : #HNodeAddedEvent,
	#superclass : #HEvent,
	#instVars : [
		'newChild'
	],
	#category : #'Hierarchical-Model-Events'
}

{ #category : #accessing }
HNodeAddedEvent >> newChild [

	^ newChild
]

{ #category : #accessing }
HNodeAddedEvent >> newChild: anObject [

	newChild := anObject
]
