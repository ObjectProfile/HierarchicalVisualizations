"
this menu allow to the user collase only link but not nodes
"
Class {
	#name : #HExpandCollapseLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #testing }
HExpandCollapseLinksMenuItem >> canBeExecuted [
	^ shape model children isNotEmpty
]

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
		ifTrue: [ 'Collapse external links' ] 
		ifFalse: [ 'Expand external links' ]
]

{ #category : #accessing }
HExpandCollapseLinksMenuItem >> order [
	^ 80
]
