"
this menu item, collapses the children of a node
"
Class {
	#name : #HCollapseChildrenMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #testing }
HCollapseChildrenMenuItem >> canBeExecuted [
	^ shape model children isNotEmpty
]

{ #category : #execution }
HCollapseChildrenMenuItem >> execute [
	shape schildren do: [ :child | child model removeInteractionIfPresent: visualization class ].
	shape model collapseChildren.
	visualization rebuildShape: shape.
]

{ #category : #accessing }
HCollapseChildrenMenuItem >> label [
	^ 'Collapse children'
]

{ #category : #accessing }
HCollapseChildrenMenuItem >> order [
	^ 15
]
