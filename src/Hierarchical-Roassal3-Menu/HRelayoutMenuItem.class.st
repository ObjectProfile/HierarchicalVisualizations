"
This menu item uses the layout of an HNode to place roassal shapes in their positions
"
Class {
	#name : #HRelayoutMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HRelayoutMenuItem >> execute [
	| node |
	node := shape model.
	node children do: [ :child | child position: nil ].
	visualization rebuildShape: shape.
]

{ #category : #accessing }
HRelayoutMenuItem >> label [
	^ 'Relayout'
]

{ #category : #accessing }
HRelayoutMenuItem >> order [
	^ 70
]
