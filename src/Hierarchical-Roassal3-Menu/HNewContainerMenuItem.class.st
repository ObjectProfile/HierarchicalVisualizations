"
This menu adds a new node into the visualization using ui manager to write its name
"
Class {
	#name : #HNewContainerMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #public }
HNewContainerMenuItem class >> requestName [
	^ UIManager default request: 'Enter a name' initialAnswer: ''
]

{ #category : #execution }
HNewContainerMenuItem >> execute [
	| name root |
	name := self class requestName.
	name ifNil: [ ^ self ].
	root := visualization rootNode.
	root add: (HNode named: name)
]

{ #category : #accessing }
HNewContainerMenuItem >> group [
	^ 1
]

{ #category : #accessing }
HNewContainerMenuItem >> label [
	^ 'Add Container'
]

{ #category : #accessing }
HNewContainerMenuItem >> order [
	^ 10
]
