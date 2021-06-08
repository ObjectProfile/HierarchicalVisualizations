"
TODO
"
Class {
	#name : #HItemNameChangedEvent,
	#superclass : #HEvent,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'HierarchicalModel-Events'
}

{ #category : #accessing }
HItemNameChangedEvent >> newName [

	^ newName
]

{ #category : #accessing }
HItemNameChangedEvent >> newName: aString [
	newName := aString
]

{ #category : #accessing }
HItemNameChangedEvent >> oldName [

	^ oldName
]

{ #category : #accessing }
HItemNameChangedEvent >> oldName: aString [
	oldName := aString
]
