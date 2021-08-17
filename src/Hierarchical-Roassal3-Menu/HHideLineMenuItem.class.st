"
this item changes the visibility of a link, but does not remove the dependency
"
Class {
	#name : #HHideLineMenuItem,
	#superclass : #HLineMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HHideLineMenuItem >> hideLink [
	shape model key hideLinkTo: shape model value.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HHideLineMenuItem >> label [
	^ 'Hide link'
]

{ #category : #accessing }
HHideLineMenuItem >> selector [
	^ #hideLink
]

{ #category : #accessing }
HHideLineMenuItem >> target [
	^ self
]
