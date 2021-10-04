"
This menu item relayout the nodes of the group using RSGridLayout
"
Class {
	#name : #HRelayoutGroupMenuItem,
	#superclass : #HGroupMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HRelayoutGroupMenuItem >> execute [
	| selectedShapes layout otherShapes |
	selectedShapes := visualization canvas selectedShapes.
	layout := visualization rootNode layout.
	layout ifNil: [ layout := RSGridLayout new gapSize: 20; yourself ].
	layout on: selectedShapes.
	otherShapes := visualization canvas nodes reject: [ :node | selectedShapes includes: node ].
	"To move to the side the new elements "
	RSHorizontalLineLayout new gapSize: 10; on: { otherShapes. selectedShapes }.
]

{ #category : #accessing }
HRelayoutGroupMenuItem >> label [
	^ 'Relayout'
]

{ #category : #accessing }
HRelayoutGroupMenuItem >> order [
	^ 10
]
