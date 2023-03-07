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
	shape add: (RSLabel new
			 text: node name;
			 color: Smalltalk ui theme textColor yourself).
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
		padding: 5 + (self borderWidth / 2);
		border: (self borderFor: node)
]

{ #category : #hooks }
HBorderAndTitleStyle >> buildCompositeFullNodeIn: shape [

	| childrenShapes node titleGroup title titleBox children boxChildren titleRadius boxChildrenRadius list |
	node := shape model.
	titleGroup := self labelAndIconFor: node.
	titleBox := RSBox new
		            extent: titleGroup extent + 10;
		            color: ((self colorFor: node) alpha: 0.7);
		            position: titleGroup position;
		            yourself.
	title := RSComposite new
		         add: titleBox;
		         addAll: titleGroup;
		         adjustToChildren;
		         yourself.
	shape propertyAt: #background put: titleBox.
	childrenShapes := node children collect: #asShape as: RSGroup.
	self layoutOn: childrenShapes parent: node.

	shape schildren: childrenShapes.
	childrenShapes do: [ :child | child sparent: shape ].
	children := childrenShapes asShape padding: 10.
	childrenShapes do: [ :child | child model position: child position ].
	title width < children width
		ifTrue: [ 
			titleBox width: children width.
			title adjustToChildren ]
		ifFalse: [ children width: title width ].
	boxChildren := self boxChildrenFor: node.
	titleRadius := self topCornerRadius.
	boxChildrenRadius := self bottomCornerRadius.
	list := { 
		        title.
		        children }.

	self titleLocation = #below ifTrue: [ 
		titleRadius := self bottomCornerRadius.
		boxChildrenRadius := self topCornerRadius.
		list := { 
			        children.
			        title } ].
	RSVerticalLineLayout new
		gapSize: 0;
		on: list.
	titleBox cornerRadius: titleRadius.
	boxChildren
		cornerRadius: boxChildrenRadius;
		fromRectangle: children encompassingRectangle.

	shape
		add: title;
		add: boxChildren;
		add: children.
	shape adjustToChildren
]

{ #category : #accessing }
HBorderAndTitleStyle >> initialize [

	super initialize.
	borderWidth := 1.
	borderDashArray := {  }
]
