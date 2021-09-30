"
This class allows to the nodes of one group to expand
"
Class {
	#name : #HExpandGroupMenuItem,
	#superclass : #HGroupMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HExpandGroupMenuItem >> execute [
	visualization canvas selectedShapes do: [ :aShape | aShape model expand ]
]

{ #category : #accessing }
HExpandGroupMenuItem >> label [
	^ 'Expand group'
]

{ #category : #accessing }
HExpandGroupMenuItem >> order [
	^ 2
]
