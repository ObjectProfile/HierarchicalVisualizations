"
This menu item open a new request dialog to get the name of the new node of the selected node
"
Class {
	#name : #HNewEntityMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HNewEntityMenuItem >> execute [
	| name node |
	name := UIManager default request: 'Enter a name' initialAnswer: ''.
	name ifNil: [ ^ self ].
	node := shape model.
	node add: (HNode new name: name; yourself).
]

{ #category : #accessing }
HNewEntityMenuItem >> label [
	^ 'New Entity'
]

{ #category : #accessing }
HNewEntityMenuItem >> order [
	^ 30
]
