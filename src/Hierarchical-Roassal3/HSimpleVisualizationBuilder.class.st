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
		'boxChildrenColor',
		'labeler',
		'fullCornerRadius',
		'baseNode',
		'linkStyler'
	],
	#category : #'Hierarchical-Roassal3-Visualization'
}

{ #category : #hooks }
HSimpleVisualizationBuilder >> baseNode [
	^ baseNode
]

{ #category : #'public - hooks' }
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

{ #category : #'accessing - attributes' }
HSimpleVisualizationBuilder >> bottomCornerRadius [
	^ bottomCornerRadius ifNil: [ 
		bottomCornerRadius := RSCornerRadius new 
			bottom: self cornerRadius ]
]

{ #category : #'public - hooks' }
HSimpleVisualizationBuilder >> boxChildrenColorFor: anHNode [
	^ boxChildrenColor scale: anHNode level
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> boxChildrenColorPalette: aNSOrdinalScale [
	boxChildrenColor := aNSOrdinalScale
]

{ #category : #'public - hooks' }
HSimpleVisualizationBuilder >> boxChildrenFor: anHNode [
	^ RSBox new
		color: (self boxChildrenColorFor: anHNode);
		yourself.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> buildCompositeEmptyNodeIn: shape [
	| node box rect |
	node := shape model.
	shape addAll: (self labeler labelAndIconFor: node).
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
HSimpleVisualizationBuilder >> buildCompositeFullNodeIn: shape [
	| childrenShapes node titleGroup title titleBox children 
	boxChildren titleRadius boxChildrenRadius list |
	node := shape model.
	titleGroup := self labeler labelAndIconFor: node.
	titleBox := RSBox new
		extent: titleGroup extent + 10;
		model: node;
		color: ((self colorFor: node) alpha: 0.7);
		position: titleGroup position;
		yourself.
	title := RSComposite new
		add: titleBox; 
		addAll: titleGroup;
		adjustToChildren;
		yourself.
	shape propertyAt: #background put: titleBox.
	childrenShapes := self childrenFor: node.
	self layoutOn: childrenShapes parent: node.
	
	shape schildren: childrenShapes.
	childrenShapes do: [ :child | child sparent: shape ].
	children := childrenShapes asShape
		padding: 10.
	childrenShapes do: [ :child | child model position: child position ].
	title width < children width
		ifTrue: [ titleBox width: children width. title adjustToChildren ]
		ifFalse: [ children width: title width ].
	boxChildren := self boxChildrenFor: node.
	titleRadius := self topCornerRadius.
	boxChildrenRadius := self bottomCornerRadius.
	list := { title. children }.
	self labeler position = #below ifTrue: [ 
		titleRadius := self bottomCornerRadius.
		boxChildrenRadius := self topCornerRadius.
		list := { children. title }.
		 ].
	RSVerticalLineLayout new
		gapSize: 0;
		on: list.
	titleBox cornerRadius: titleRadius.
	boxChildren
		cornerRadius: boxChildrenRadius;
		fromRectangle: children encompassingRectangle.
	
	shape add: title; add: boxChildren; add: children.
	shape adjustToChildren.
	
]

{ #category : #'public - hooks' }
HSimpleVisualizationBuilder >> childrenFor: node [
	^ node children collect: [ :child | self shapeFor: child ] as: RSGroup
]

{ #category : #'public - hooks' }
HSimpleVisualizationBuilder >> colorFor: node [
	^ Color colorFrom: (node color ifNil: [ #gray ])
]

{ #category : #'accessing - attributes' }
HSimpleVisualizationBuilder >> cornerRadius [
	^ 7
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

{ #category : #'accessing - attributes' }
HSimpleVisualizationBuilder >> fullCornerRadius [
	^ fullCornerRadius ifNil: [ 
		fullCornerRadius := RSCornerRadius new 
			radius: self cornerRadius ]
]

{ #category : #'accessing - attributes' }
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

{ #category : #initialization }
HSimpleVisualizationBuilder >> initialize [
	super initialize.
	self labeler: HLabeler new.
	self linkStyler: HLinkStyler new.
	self boxChildrenColorPalette: (NSScale ordinal 
		range: Smalltalk ui theme roassalHNodeBackgroundColors).
		
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> labeler [
	^ labeler
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> labeler: anHLabeler [
	labeler := anHLabeler
]

{ #category : #layout }
HSimpleVisualizationBuilder >> layoutOn: aGroupOfShapes parent: shape [
	aGroupOfShapes ifEmpty: [ ^ self ].
	
	aGroupOfShapes first model position ifNotNil: [ 
		aGroupOfShapes do: [ :child | child position: (child model position ifNil: [ 0@0 ]) ].
		^ self.
		 ].
	self relayout: aGroupOfShapes parent: shape.
	
	
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> lineBuilder [
	^ self linkStyler lineBuilder
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> linkStyler [
	^ linkStyler
]

{ #category : #accessing }
HSimpleVisualizationBuilder >> linkStyler: anHLinkStyler [
	linkStyler :=anHLinkStyler
]

{ #category : #'accessing - attributes' }
HSimpleVisualizationBuilder >> menuInteraction [
	^ menuInteraction ifNil: [ 
		menuInteraction := RSMenuActivable new
			menuDo: [ :menu :aShape | HAbstractMenuItem 
				buildIn: menu 
				shape: aShape 
				visualization: self ];
			yourself 
	]
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> nodeAnnouncer [
	baseNode ifNotNil: [ ^ baseNode announcer ].
	baseNode := RSComposite new
		@ self nodePopup;
		@ (RSGhostDraggable new 
			color: Smalltalk ui theme caretColor);
		@ self menuInteraction;
		@ self highlightable;
		
		@ (HResizeParentWhenChildMoves new labeler: self labeler);
		yourself.
	^ baseNode announcer
	
]

{ #category : #'accessing - attributes' }
HSimpleVisualizationBuilder >> nodePopup [
	^ RSPopup new
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> rebuildLines: shape [
	| canvas |
	canvas := shape canvas.
	canvas lines copy do: #remove.
	self renderLinesIn: canvas.
	canvas signalUpdate.
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

{ #category : #layout }
HSimpleVisualizationBuilder >> relayout: aGroupOfShapes parent: shape [
	shape layout ifNil: [ 
		RSFlowLayout new
			gapSize: 10;
			on: aGroupOfShapes. 
		^ self ].
	shape layout on: aGroupOfShapes.
	
	
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
	rootShapes := rootNode children 
		collect: [:child | (self shapeFor: child) sparent: aCanvas ]
		as: RSGroup.
	aCanvas schildren: rootShapes.
	aCanvas addAll: rootShapes.
	aCanvas @ self menuInteraction.
	rootNode when: HNodeAddedEvent do: [ :evt | | newShape |
		newShape := (self shapeFor: evt newChild) sparent: aCanvas.
		newShape position: aCanvas camera position.
		rootShapes add: newShape.
		aCanvas add: newShape.
		aCanvas signalUpdate.
		 ].
	self renderLinesIn: aCanvas.
	self layoutOn: rootShapes parent: rootNode.
	
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> renderLinesIn: aCanvas [
	| announcer high |
	self lineBuilder
		canvas: aCanvas;
		shapes: shapes;
		connectFromAll: #dependentsFromLinks.
	announcer := Announcer new.
	high := RSHighlightable red.
	high onShape: announcer.
	self menuInteraction onShape: announcer.
	aCanvas lines do: [ :line| line announcer: announcer ].
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
		announcer: self nodeAnnouncer;
		yourself.
	(node isExpanded and: [node hasChildren]) 
		ifTrue: [ self buildCompositeFullNodeIn: shape ]
		ifFalse: [ self buildCompositeEmptyNodeIn: shape ].
	
	node 
		removeInteractionIfPresent: self class;
		when: HNodeAddedEvent do: [ :evt | self rebuildRootShape: shape ];
		when: HCollapseEvent do: [ :evt |	self rebuildShape: shape ];
		when: HExpandEvent do: [ :evt | self rebuildRootShape: shape ];
		when: HIconChangedEvent do: [ :evt | self rebuildShape: shape ].
	shapes add: shape.
	^ shape 
	
]

{ #category : #'accessing - attributes' }
HSimpleVisualizationBuilder >> topCornerRadius [
	^ topCornerRadius ifNil: [ 
		topCornerRadius := RSCornerRadius new 
			top: self cornerRadius ]
]
