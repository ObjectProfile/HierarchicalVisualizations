Class {
	#name : #HBorderAndTitleStyle,
	#superclass : #HStyle,
	#instVars : [
		'borderWidth',
		'borderDashArray'
	],
	#category : #'Hierarchical-Roassal3'
}

{ #category : #accessing }
HBorderAndTitleStyle >> borderDashArray [

	^ borderDashArray
]

{ #category : #accessing }
HBorderAndTitleStyle >> borderDashArray: anObject [

	borderDashArray := anObject
]

{ #category : #hooks }
HBorderAndTitleStyle >> borderWidth [

	^ borderWidth
]

{ #category : #accessing }
HBorderAndTitleStyle >> borderWidth: anObject [

	borderWidth := anObject
]

{ #category : #hooks }
HBorderAndTitleStyle >> boxBorderFor: anHNode [

	^ RSBorder new
		  color: Color black;
		  joinMiter;
		  width: self borderWidth;
		  dashArray: self borderDashArray;
		  yourself
]

{ #category : #hooks }
HBorderAndTitleStyle >> buildCompositeEmptyNodeIn: shape [

	| node box rect |
	node := shape model.
	shape add: (self labelFor: node).
	rect := shape children encompassingRectangle.
	box := RSBox new
		       extent: rect extent + 10 + (self borderWidth / 2);
		       color: (self colorFor: node);
		       border: (self boxBorderFor: node);
		       yourself.
	shape add: box.
	box pushBack.
	shape schildren: #(  ).

	shape
		propertyAt: #background put: box;
		adjustToChildren;
		padding: 5 + (self borderWidth / 2)
]

{ #category : #hooks }
HBorderAndTitleStyle >> buildCompositeFullNodeIn: shape [

	| childrenShapes node title children boxChildren |
	node := shape model.
	title := self labelFor: node.

	childrenShapes := node children collect: #asShape as: RSGroup.
	self layoutOn: childrenShapes parent: node.
	shape schildren: childrenShapes.
	children := childrenShapes asShape padding: 10.
	childrenShapes do: [ :child | child model position: child position ].

	title width > children width ifTrue: [ children width: title width ].
	boxChildren := self boxChildrenFor: node.
	boxChildren color: (self colorFor: node).
	self titleLocation move: title on: children.

	shape propertyAt: #background put: boxChildren.
	shape border: (self boxBorderFor: node).
	boxChildren fromRectangle: { 
			title.
			children } asGroup encompassingRectangle.

	shape
		add: boxChildren;
		add: title;
		add: children.
	shape adjustToChildren
]

{ #category : #accessing }
HBorderAndTitleStyle >> initialize [

	super initialize.
	borderWidth := 1.
	borderDashArray := {  }
]

{ #category : #hooks }
HBorderAndTitleStyle >> updateShape: shape with: parent [
	| children title boxChildren |
	children := shape parent.
	children adjustToChildren;
		padding: 10.
	title := parent children second.
	parent schildren do: [ :child | child model position: child position ].
	children width < title width
		ifTrue: [ children width: title width ].
	self titleLocation move: title on: children.
	boxChildren := parent propertyAt: #background.
	boxChildren fromRectangle: ({title. children} asGroup encompassingRectangle).
	
]
