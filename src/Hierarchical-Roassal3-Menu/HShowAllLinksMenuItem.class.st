"
this menu item show all the links of the node and all children
"
Class {
	#name : #HShowAllLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HShowAllLinksMenuItem >> execute [
	shape model showAllLinks.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HShowAllLinksMenuItem >> label [
	^ 'Show All links'
]

{ #category : #accessing }
HShowAllLinksMenuItem >> order [
	^ 50
]
