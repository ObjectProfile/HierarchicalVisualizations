Class {
	#name : #HDefaultStyle,
	#superclass : #HStyle,
	#instVars : [
		'fullCornerRadius',
		'topCornerRadius',
		'bottomCornerRadius'
	],
	#category : #'Hierarchical-Roassal3'
}

{ #category : #hooks }
HDefaultStyle >> bottomCornerRadius [
	^ bottomCornerRadius ifNil: [ 
		bottomCornerRadius := RSCornerRadius new 
			bottom: self cornerRadius ]
]

{ #category : #hooks }
HDefaultStyle >> buildCompositeEmptyNodeIn: shape [
	| node box rect |
	node := shape model.
	shape addAll: (self labelAndIconFor: node).
	rect := shape children encompassingRectangle.
	box := RSBox new 
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
	children useRTree.
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
	self titleLocationAbove
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

{ #category : #hooks }
HDefaultStyle >> updateShape: shape with: parent [
	| children title titleBox boxChildren list style |
	children := shape parent.
	children
		adjustToChildren;
		padding: 10.
	parent schildren do: [ :child | child model position: child position ].
	
	title := parent children first.
	titleBox := title children first.
	titleBox extent: title children allButFirst extent + 10.
	title adjustToChildren.
	boxChildren := parent children second.
	"boxChildren := parent propertyAt: #background."
	title width < children width
		ifTrue: [ 
			titleBox width: children width.
			title adjustToChildren ]
		ifFalse: [ children width: title width ].
	list := { 
		        title.
		        children }.
	style := shape model style.
	style titleLocation = #below ifTrue: [ 
		list := { 
			        children.
			        title } ].
	RSVerticalLineLayout new
		gapSize: 0;
		on: list.
	boxChildren fromRectangle: children encompassingRectangle
]
