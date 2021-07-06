"
TODO
"
Class {
	#name : #HNodeBuilder,
	#superclass : #Object,
	#instVars : [
		'rootNode'
	],
	#category : #'Hierarchical-Builder'
}

{ #category : #building }
HNodeBuilder >> build [ 
	self subclassResponsibility
]

{ #category : #accessing }
HNodeBuilder >> rootNode [

	^ rootNode
]

{ #category : #accessing }
HNodeBuilder >> rootNode: anObject [

	rootNode := anObject
]
