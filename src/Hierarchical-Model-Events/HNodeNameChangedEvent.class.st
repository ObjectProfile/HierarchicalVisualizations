"
TODO
"
Class {
	#name : #HNodeNameChangedEvent,
	#superclass : #HEvent,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'Hierarchical-Model-Events'
}

{ #category : #accessing }
HNodeNameChangedEvent >> newName [

	^ newName
]

{ #category : #accessing }
HNodeNameChangedEvent >> newName: aString [
	newName := aString
]

{ #category : #accessing }
HNodeNameChangedEvent >> oldName [

	^ oldName
]

{ #category : #accessing }
HNodeNameChangedEvent >> oldName: aString [
	oldName := aString
]
