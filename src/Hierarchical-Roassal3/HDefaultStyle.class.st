Class {
	#name : #HDefaultStyle,
	#superclass : #HStyle,
	#instVars : [
		'baseLabel',
		'fullCornerRadius',
		'boxChildrenColorPalette',
		'topCornerRadius',
		'bottomCornerRadius',
		'titleLocation'
	],
	#category : #'Hierarchical-Roassal3'
}

{ #category : #accessing }
HDefaultStyle >> baseLabel [

	^ baseLabel
]

{ #category : #accessing }
HDefaultStyle >> baseLabel: anObject [

	baseLabel := anObject
]

{ #category : #hooks }
HDefaultStyle >> borderFor: node [
	^ node hasChildren
		ifTrue: [ RSBorder new 
			width: 2; 
			capSquare;
			joinMiter;
			color: Smalltalk ui theme textColor;
			dashArray: #(5 10);
			yourself  ]
		ifFalse: [ nil ]
]

{ #category : #hooks }
HDefaultStyle >> bottomCornerRadius [
	^ bottomCornerRadius ifNil: [ 
		bottomCornerRadius := RSCornerRadius new 
			bottom: self cornerRadius ]
]

{ #category : #hooks }
HDefaultStyle >> boxChildrenColorFor: anHNode [
	^ boxChildrenColorPalette scale: anHNode level
]

{ #category : #accessing }
HDefaultStyle >> boxChildrenColorPalette [

	^ boxChildrenColorPalette
]

{ #category : #accessing }
HDefaultStyle >> boxChildrenColorPalette: anObject [

	boxChildrenColorPalette := anObject
]

{ #category : #hooks }
HDefaultStyle >> boxChildrenFor: anHNode [
	^ RSBox new
		color: (self boxChildrenColorFor: anHNode);
		yourself.
]

{ #category : #hooks }
HDefaultStyle >> buildCompositeEmptyNodeIn: shape [
	| node box rect |
	node := shape model.
	shape addAll: (self labelAndIconFor: node).
	rect := shape children encompassingRectangle.
	box := RSBox new 
		model: node;
		position: rect floatCenter;
		extent: rect extent + 10;
		cornerRadius: self fullCornerRadius;
		color: (self colorFor: node);
		border: (self borderFor: node);
		yourself.
	shape add: box.
	box pushBack.
	shape schildren: #().
	
	shape 
		propertyAt: #background put: box;
		adjustToChildren
]

{ #category : #hooks }
HDefaultStyle >> buildCompositeFullNodeIn: shape [

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

{ #category : #hooks }
HDefaultStyle >> colorFor: node [

	^ Color colorFrom: (node color ifNil: [ #gray ])
]

{ #category : #hooks }
HDefaultStyle >> cornerRadius [

	^ 7
]

{ #category : #hooks }
HDefaultStyle >> fullCornerRadius [
	^ fullCornerRadius ifNil: [ 
		fullCornerRadius := RSCornerRadius new 
			radius: self cornerRadius ]
]

{ #category : #hooks }
HDefaultStyle >> iconFor: anHNode [
	anHNode iconName ifNil: [ ^ nil ].
	^ RSBitmap new
		form: (self iconNamed: anHNode iconName);
		yourself.
		
]

{ #category : #initialization }
HDefaultStyle >> initialize [

	super initialize.
	baseLabel := RSLabel new.
	self titleLocationAbove.
	baseLabel
		fontSize: 12;
		color: Smalltalk ui theme textColor;
		fontName: 'Source Sans Pro'.
	self boxChildrenColorPalette: (NSScale ordinal range:
			 Smalltalk ui theme roassalHNodeBackgroundColors)
]

{ #category : #hooks }
HDefaultStyle >> labelAndIconFor: anHNode [
	| group icon |
	group := RSGroup new.
	icon := self iconFor: anHNode.
	icon ifNotNil: [ group add: icon ].
	group add: (self labelFor: anHNode).
	
	RSHorizontalLineLayout new alignMiddle; on: group.
	^ group.
]

{ #category : #hooks }
HDefaultStyle >> labelFor: anHNode [

	^ baseLabel copy
		  text: (self textFor: anHNode);
		  yourself
]

{ #category : #hooks }
HDefaultStyle >> layoutOn: aGroupOfShapes parent: anHNode [
	aGroupOfShapes ifEmpty: [ ^ self ].
	
	aGroupOfShapes first model position ifNotNil: [ 
		aGroupOfShapes do: [ :child | child position: (child model position ifNil: [ 0@0 ]) ].
		^ self.
		 ].
	self relayout: aGroupOfShapes parent: anHNode.
	
	
]

{ #category : #hooks }
HDefaultStyle >> relayout: aGroupOfShapes parent: anHNode [
	anHNode layout ifNil: [ 
		RSFlowLayout new
			gapSize: 10;
			on: aGroupOfShapes. 
		^ self ].
	anHNode layout on: aGroupOfShapes.
	
	
]

{ #category : #hooks }
HDefaultStyle >> shapeFor: aHNode [

	| shape |
	shape := RSComposite new
		         model: aHNode;
		         yourself.
	(aHNode isExpanded and: [ aHNode hasChildren ])
		ifTrue: [ self buildCompositeFullNodeIn: shape ]
		ifFalse: [ self buildCompositeEmptyNodeIn: shape ].

	^ shape
]

{ #category : #hooks }
HDefaultStyle >> textFor: aHNode [

	^ aHNode name
]

{ #category : #hooks }
HDefaultStyle >> titleLocation [

	^ titleLocation
]

{ #category : #accessing }
HDefaultStyle >> titleLocation: anObject [

	titleLocation := anObject
]

{ #category : #initialization }
HDefaultStyle >> titleLocationAbove [

	titleLocation := #above
]

{ #category : #initialization }
HDefaultStyle >> titleLocationBelow [

	titleLocation := #below
]

{ #category : #hooks }
HDefaultStyle >> topCornerRadius [
	^ topCornerRadius ifNil: [ 
		topCornerRadius := RSCornerRadius new 
			top: self cornerRadius ]
]
