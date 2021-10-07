"
this menu allow to the user collase only link but not nodes
"
Class {
	#name : #HExpandCollapseLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HExpandCollapseLinksMenuItem >> execute [
	| node |
	node := shape model.
	shape model isLinksExpanded
		ifTrue: [ node collapseLinks ]
		ifFalse: [ node expandLinks ].
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HExpandCollapseLinksMenuItem >> group [
	^ 3
]

{ #category : #accessing }
HExpandCollapseLinksMenuItem >> label [
	^ shape model isLinksExpanded
		ifTrue: [ 'Collapse links' ] 
		ifFalse: [ 'Expand links' ]
]

{ #category : #accessing }
HExpandCollapseLinksMenuItem >> order [
	^ 80
]
