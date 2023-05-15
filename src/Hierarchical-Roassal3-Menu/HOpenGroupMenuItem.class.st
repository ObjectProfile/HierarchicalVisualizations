"
This menu item open the selected menu group in a new canvas window
"
Class {
	#name : #HOpenGroupMenuItem,
	#superclass : #HGroupMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HOpenGroupMenuItem >> execute [
	| listCopy newNode |
	listCopy := visualization canvas selectedShapes collect: [:node | node model copy ].
	newNode := HNode named: 'Group'.
	newNode children: listCopy.
	listCopy do: [ :node | node parent: newNode ].
	newNode fixDependents.
	newNode open.
]

{ #category : #execution }
HOpenGroupMenuItem >> group [
	^ 2
]

{ #category : #execution }
HOpenGroupMenuItem >> label [
	^ 'Open group'
]
