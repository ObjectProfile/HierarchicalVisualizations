"
this item changes the visibility of a link, but does not remove the dependency
"
Class {
	#name : #HHideLineMenuItem,
	#superclass : #HLineMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HHideLineMenuItem >> execute [
	shape model key hideLinkTo: shape model value.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HHideLineMenuItem >> label [
	^ 'Hide link'
]
