"
expand the node and its children
"
Class {
	#name : #HExpandChildrenMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #testing }
HExpandChildrenMenuItem >> canBeExecuted [
	^ shape model children isNotEmpty
]

{ #category : #execution }
HExpandChildrenMenuItem >> execute [
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
