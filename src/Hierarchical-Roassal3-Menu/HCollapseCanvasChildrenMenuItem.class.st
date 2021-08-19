"
this menu item, collapses direct children of the canvas
"
Class {
	#name : #HCollapseCanvasChildrenMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HCollapseCanvasChildrenMenuItem >> execute [
	visualization rootNode collapseChildren
	
]

{ #category : #accessing }
HCollapseCanvasChildrenMenuItem >> label [
	^ 'Collapse children'
]

{ #category : #accessing }
HCollapseCanvasChildrenMenuItem >> order [
	^ 0
]
