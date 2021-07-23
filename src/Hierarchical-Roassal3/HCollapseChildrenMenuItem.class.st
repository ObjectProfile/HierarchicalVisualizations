"
this menu item, collapses the children of a node
"
Class {
	#name : #HCollapseChildrenMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HCollapseChildrenMenuItem >> collapseChildren [
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

{ #category : #accessing }
HCollapseChildrenMenuItem >> selector [
	^ #collapseChildren
]

{ #category : #accessing }
HCollapseChildrenMenuItem >> target [
	^ self
]
