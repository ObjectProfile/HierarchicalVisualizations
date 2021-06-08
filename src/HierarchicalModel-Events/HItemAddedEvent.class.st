"
todo
"
Class {
	#name : #HItemAddedEvent,
	#superclass : #HEvent,
	#instVars : [
		'oldName',
		'newName',
		'addedItem'
	],
	#category : #'HierarchicalModel-Events'
}

{ #category : #accessing }
HItemAddedEvent >> addedItem [
	^ addedItem
]

{ #category : #accessing }
HItemAddedEvent >> addedItem: anHModel [
	addedItem := anHModel
]
