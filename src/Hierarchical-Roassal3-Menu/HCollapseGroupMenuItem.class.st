"
This class allows to the nodes of one group to collapse
"
Class {
	#name : #HCollapseGroupMenuItem,
	#superclass : #HGroupMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HCollapseGroupMenuItem >> execute [
	visualization canvas selectedShapes do: [ :aShape | aShape model collapse ].

]

{ #category : #accessing }
HCollapseGroupMenuItem >> label [
	^ 'Collapse group'
]

{ #category : #accessing }
HCollapseGroupMenuItem >> order [
	^ 0
]
