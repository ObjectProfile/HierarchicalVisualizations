"
this menu allow to the user collase only link but not nodes
"
Class {
	#name : #HCollapseLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HCollapseLinksMenuItem >> execute [
	shape model collapseLinks.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HCollapseLinksMenuItem >> group [
	^ 3
]

{ #category : #accessing }
HCollapseLinksMenuItem >> label [
	^ 'Collapse links'
]

{ #category : #accessing }
HCollapseLinksMenuItem >> order [
	^ 80
]
