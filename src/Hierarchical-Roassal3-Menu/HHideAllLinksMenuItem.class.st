"
This menu item hide all the links for this node and all children
"
Class {
	#name : #HHideAllLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HHideAllLinksMenuItem >> execute [
	shape model hideAllLinks.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HHideAllLinksMenuItem >> group [
	^ 3
]

{ #category : #accessing }
HHideAllLinksMenuItem >> label [
	^ 'Hide All links'
]

{ #category : #accessing }
HHideAllLinksMenuItem >> order [
	^ 60
]
