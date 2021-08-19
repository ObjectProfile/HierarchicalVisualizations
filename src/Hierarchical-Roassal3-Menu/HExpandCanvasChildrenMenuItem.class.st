"
This menu item expands the direct children of the root node
"
Class {
	#name : #HExpandCanvasChildrenMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HExpandCanvasChildrenMenuItem >> execute [
	visualization rootNode expandChildren
]

{ #category : #accessing }
HExpandCanvasChildrenMenuItem >> label [
	^ 'Expand children'
]

{ #category : #accessing }
HExpandCanvasChildrenMenuItem >> order [
	^ 5
]
