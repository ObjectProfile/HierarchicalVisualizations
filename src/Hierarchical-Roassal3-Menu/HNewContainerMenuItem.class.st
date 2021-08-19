Class {
	#name : #HNewContainerMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HNewContainerMenuItem >> execute [
	| name root |
	name := UIManager default request: 'Enter a name' initialAnswer: ''.
	name ifNil: [ ^ self ].
	root := visualization rootNode.
	root add: (HNode new name: name; yourself).
]

{ #category : #accessing }
HNewContainerMenuItem >> label [
	^ 'Add Container'
]

{ #category : #accessing }
HNewContainerMenuItem >> order [
	^ 10
]
