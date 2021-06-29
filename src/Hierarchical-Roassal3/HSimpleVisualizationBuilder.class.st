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
		'colorPalette'
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
HSimpleVisualizationBuilder >> childrenFor: node [
	^ node children collect: [ :child | self shapeFor: child ]
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> colorFor: node [
	^ colorPalette scale: node level
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
				useBasicZoom ];
		yourself).
		
	^ canvas
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> highlightable [
	^ highlightable ifNil: [ 
		highlightable := RSHighlightable new
			withLines;
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
	self colorPalette: NSScale category10.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> labeled [
	^ labeled ifNil: [ 
		labeled := RSLabeled new.
		labeled shapeBuilder labelShape color: Smalltalk ui theme textColor. 
		labeled 
			 ]
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
						argument: #()
				].
				
				menu
					add: 'Inspect'
					target: box model
					selector: #inspect
					argument: #() ];
			yourself 
	]
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> rebuild: node shape: shape [
	| canvas newShape |
	canvas := shape canvas.
	canvas lines copy do: #remove.
	shapes removeAll: (shape withAllChildren select: [:s | s class = RSComposite]).
	newShape := self shapeFor: node.
	newShape position: shape position.
	shape parent add: newShape.
	shape remove.

	self renderLinesIn: canvas.
	canvas signalUpdate.
		
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> renderIn: aCanvas [
	| rootShapes |
	aCanvas color: Smalltalk ui theme backgroundColor.
	shapes := RSGroup new.
	rootShapes := rootNode children collect: [:child | self shapeFor: child ].
	aCanvas addAll: rootShapes.
	self renderLinesIn: aCanvas.
	RSFlowLayout new
		gapSize: 50;
		on: rootShapes.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> renderLinesIn: aCanvas [

	RSLineBuilder line "bezier"
		"controlPointsController: HVisualizationCPController new;"
		"markerStartEnd: (RSEllipse new size: 3);"
		attachPoint: (RSBorderAttachPoint new endOffset: 5);
		markerEnd: (RSShapeFactory arrow size: 10);
		color: Smalltalk ui theme textColor;
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
HSimpleVisualizationBuilder >> shapeFor: node [
	| shape |
	shape := RSComposite new
		model: node;
		color: (self colorFor: node);
		popup;
		draggable;
		@ self menuInteraction;
		@ self highlightable;
		yourself.
		
	(node isExpanded and: [node hasChildren]) ifTrue: [ 
		| childrenShapes |
		shape addAll: (childrenShapes := self childrenFor: node).
		RSFlowLayout new gapSize: 10; on: childrenShapes.
		shape @ self labeled.
		shape
			withBorder;
			adjustToChildren;
			padding: 10.
	] ifFalse: [ 
		shape add: (RSLabel new
			color: Smalltalk ui theme textColor;
			text: node asString;
			yourself).
		shape 
			adjustToChildren;
			padding: 5;
			border: (self borderFor: node) ].

	node 
		removeInteractionIfPresent: self class;
		when: HCollapseEvent do: [ :evt |
			self rebuild: evt node shape: shape ];
		when: HExpandEvent do: [ :evt |
			self rebuild: evt node shape: shape ].
	shapes add: shape.
	^ shape 
	
]
