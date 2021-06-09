"
todo
"
Class {
	#name : #HEvent,
	#superclass : #Announcement,
	#instVars : [
		'node'
	],
	#category : #'Hierarchical-Model-Events'
}

{ #category : #accessing }
HEvent >> node [

	^ node
]

{ #category : #accessing }
HEvent >> node: anObject [

	node := anObject
]
