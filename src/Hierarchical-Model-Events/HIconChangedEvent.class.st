"
Callled when the icon named change
"
Class {
	#name : #HIconChangedEvent,
	#superclass : #HEvent,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'Hierarchical-Model-Events'
}

{ #category : #accessing }
HIconChangedEvent >> newName [

	^ newName
]

{ #category : #accessing }
HIconChangedEvent >> newName: anObject [

	newName := anObject
]

{ #category : #accessing }
HIconChangedEvent >> oldName [

	^ oldName
]

{ #category : #accessing }
HIconChangedEvent >> oldName: anObject [

	oldName := anObject
]
