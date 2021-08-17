"
expand the node and its children
"
Class {
	#name : #HExpandChildrenMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HExpandChildrenMenuItem >> expandChildren [
	shape schildren do: [ :child | child model removeInteractionIfPresent: visualization class ].
	shape model expandChildren.
	visualization rebuildShape: shape.
]

{ #category : #accessing }
HExpandChildrenMenuItem >> label [
	^ 'Expand children'
]

{ #category : #accessing }
HExpandChildrenMenuItem >> order [
	^ 10
]

{ #category : #accessing }
HExpandChildrenMenuItem >> selector [
	^ #expandChildren
]

{ #category : #accessing }
HExpandChildrenMenuItem >> target [
	^ self
]
