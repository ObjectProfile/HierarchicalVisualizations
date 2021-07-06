"
A basic visualization based on the video presented by nicolas
"
Class {
	#name : #HSimpleVisualizationBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'rootNode',
		'menuInteraction',
		'highlightable',
		'labeled',
		'colorPalette',
		'topCornerRadius',
		'bottomCornerRadius',
		'boxChildrenColor'
	],
	#category : #'Hierarchical-Roassal3'
}

{ #category : #hooks }
HSimpleVisualizationBuilder >> borderFor: node [
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
HSimpleVisualizationBuilder >> bottomCornerRadius [
	^ bottomCornerRadius ifNil: [ bottomCornerRadius := RSCornerRadius new bottom: 7]
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> boxChildrenColorFor: anHNode [
	^ boxChildrenColor scale: anHNode level
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> boxChildrenColorPalette: aNSOrdinalScale [
	boxChildrenColor := aNSOrdinalScale
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> boxChildrenFor: anHNode [
	^ RSBox new
		color: (self boxChildrenColorFor: anHNode);
		cornerRadius: self bottomCornerRadius;
		yourself.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> buildInCompositeEmptyNode: shape [
	| node |
	node := shape model.
	shape add: (self iconFor: node).
	shape add: (self labelFor: node).
	RSHorizontalLineLayout on: shape children.
	shape schildren: #().
	shape 
		propertyAt: #background put: shape;
		color: (self colorFor: node);
		adjustToChildren;
		padding: 5;
		border: (self borderFor: node) 
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> buildInCompositeFullNode: shape [
	| childrenShapes node icon label title titleBox children boxChildren |
	node := shape model.
	icon := self iconFor: node.
	label := self labelFor: node.
	title := { icon. label } asGroup.
	RSHorizontalLineLayout on: title.
	titleBox := RSBox new
		extent: title extent + 10;
		color: ((self colorFor: node) alpha: 0.7);
		position: title position;
		cornerRadius: self topCornerRadius;
		yourself.
	title := { titleBox. icon. label } asShape.
	shape propertyAt: #background put: titleBox.
	childrenShapes := self childrenFor: node.
	RSFlowLayout new gapSize: 10; on: childrenShapes.
	shape schildren: childrenShapes.
	childrenShapes do: [ :child | child sparent: shape ].
	children := childrenShapes asShape
		padding: 10.
	title width < children width
		ifTrue: [ titleBox width: children width. title adjustToChildren ]
		ifFalse: [ children width: title width ].
	RSVerticalLineLayout new
		gapSize: 0;
		on: { title. children }.
	
	boxChildren := self boxChildrenFor: node.
	boxChildren fromRectangle: children encompassingRectangle.
	shape add: title; add: boxChildren; add: children.
	shape adjustToChildren.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> childrenFor: node [
	^ node children collect: [ :child | self shapeFor: child ] as: RSGroup
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> collapseChildren: shape [
	shape schildren do: [ :child | child model removeInteractionIfPresent: self ].
	shape model collapseChildren.
	self rebuildShape: shape.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> colorFor: node [
	^ Color colorFrom: (colorPalette scale: node level)
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> colorPalette [
	^ colorPalette
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> colorPalette: aNSOrdinalScale [
	colorPalette := aNSOrdinalScale
]

{ #category : #'accessing - defaults' }
HSimpleVisualizationBuilder >> defaultContainer [
	| canvas |
	canvas := RSCanvas new.
	canvas  @ (RSCanvasController new 
		noLegend;
		in: [:i | 
			canvas newAnimation
				duration: 500 milliSeconds;
				onStepDo: [ canvas signalUpdate ];
				when: RSAnimationEndEvent do: [ i configuration noZoomToFitOnExtendChanged  ].
			i configuration
				"useBasicZoom;"
				maxScale: 3;
				minScale: 0.5];
		yourself).
		
	^ canvas
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> expandChildren: shape [
	shape schildren do: [ :child | child model removeInteractionIfPresent: self ].
	shape model expandChildren.
	self rebuildShape: shape.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> highlightable [
	^ highlightable ifNil: [ 
		highlightable := RSHighlightable new
			highlightShapes: [ :shape | 
				| list |
				list := shape connectedLines copy.
				list add: (shape propertyAt: #background).
				list 
				 ];
			when: RSHighlightEvent do: [ :evt |
				| color |
				color := evt shape isNode
					 ifTrue: [ evt shape color muchDarker ]
					 ifFalse: [ Color red ].
				highlightable record: evt shape selector: #color value: color ];
			when: RSUnHighlightEvent do: [ :evt | 
				highlightable restore: evt shape selector: #color ];
			yourself.
		 ].
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> iconFor: node [
	^ RSBitmap new
		form: (self iconNamed: (node iconName ifNil: [#objects]));
		yourself.
		
]

{ #category : #initialization }
HSimpleVisualizationBuilder >> initialize [
	super initialize.
	self colorPalette: NSScale category10.
	self boxChildrenColorPalette: (NSScale ordinal 
		range: Smalltalk ui theme roassalHNodeBackgroundColors).
		
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> labelFor: node [
	^ RSLabel new
		color: Smalltalk ui theme textColor;
		text: node asString;
		yourself
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> menuInteraction [
	^ menuInteraction ifNil: [ 
		menuInteraction := RSMenuActivable new
			menuDo: [ :menu :box | 
				box model hasChildren ifTrue: [ 
					menu 
						add: 'Expand/Collapse'
						target: box model
						selector: #expandCollapse
						argument: nil.
					menu
						add: 'Expand children'
						target: self
						selector: #expandChildren:
						argument: box.
					menu
						add: 'Collapse children'
						target: self
						selector: #collapseChildren:
						argument: box.
				].
				
				menu
					add: 'Inspect'
					target: box model
					selector: #inspect
					argument: nil ];
			yourself 
	]
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> rebuildRootShape: shape [
	| rootShape |
	rootShape := self rootShapeFrom: shape.
	self rebuildShape: rootShape.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> rebuildShape: shape [
	| canvas newShape node |
	node := shape model.
	canvas := shape canvas.
	canvas lines copy do: #remove.
	self removeShapeWithAllChildren: shape.
	newShape := self shapeFor: node.
	newShape position: shape position.
	
	shape parent add: newShape.
	
	"shape sparent schildren add: newShape."
	shape sparent schildren 
		remove: shape;
		add: newShape.
	newShape sparent: shape sparent.
	shape remove.

	self renderLinesIn: canvas.
	canvas signalUpdate.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> removeShapeWithAllChildren: shape [
	
	shape schildren do: [ :child | self removeShapeWithAllChildren: child. ].
	shape model removeInteractionIfPresent: self class.
	shapes remove: shape.
	
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> renderIn: aCanvas [
	| rootShapes |
	aCanvas color: Smalltalk ui theme backgroundColor.
	shapes := RSGroup new.
	rootShapes := rootNode children collect: [:child | (self shapeFor: child) sparent: aCanvas ].
	aCanvas schildren: rootShapes.
	aCanvas addAll: rootShapes.
	self renderLinesIn: aCanvas.
	RSFlowLayout new
		gapSize: 50;
		on: rootShapes.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> renderLinesIn: aCanvas [

	RSLineBuilder line
		"controlPointsController: HVisualizationCPController new;"
		"markerStartEnd: (RSEllipse new size: 3);"
		attachPoint: (RSBorderAttachPoint new endOffset: 5);
		markerEnd: (RSShapeFactory arrow size: 10);
		color: Smalltalk ui theme textColor translucent;
		canvas: aCanvas;
		shapes: shapes;
		connectFromAll: #dependentsFromLinks.
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> rootNode [
	^ rootNode
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> rootNode: aHNode [ 
	rootNode := aHNode
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> rootShapeFrom: shape [
	| parent |
	parent := shape sparent.
	^ parent class = RSCanvas
		ifTrue: [ shape ]
		ifFalse: [ self rootShapeFrom: parent ].
		
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> shapeFor: node [
	| shape |
	shape := RSComposite new
		model: node;
		popup;
		@ RSGhostDraggable new;
		@ self menuInteraction;
		@ self highlightable;
		yourself.
		
	(node isExpanded and: [node hasChildren]) 
		ifTrue: [ self buildInCompositeFullNode: shape ]
		ifFalse: [ self buildInCompositeEmptyNode: shape ].

	node 
		removeInteractionIfPresent: self class;
		when: HNodeAddedEvent do: [ :evt | self rebuildRootShape: shape ];
		when: HCollapseEvent do: [ :evt |	self rebuildShape: shape ];
		when: HExpandEvent do: [ :evt | self rebuildRootShape: shape ].
	shapes add: shape.
	^ shape 
	
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> topCornerRadius [
	^ topCornerRadius ifNil: [ topCornerRadius := RSCornerRadius new top: 7 ]
]
