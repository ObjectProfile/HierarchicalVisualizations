"
A basic visualization based on the video presented by nicolas
"
Class {
	#name : #HSimpleVisualizationBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'rootNode',
		'colors'
	],
	#category : #'Hierarchical-Spec'
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
HSimpleVisualizationBuilder >> colorFor: node [
	^ colors scale: node
]

{ #category : #initialization }
HSimpleVisualizationBuilder >> initialize [
	super initialize.
	colors := NSScale category20c.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> menuInteraction [
	^ RSMenuActivableInteraction new
		menuDo: [ :menu :box | 
			menu 
				add: 'Expand/Collapse'
				target: box model
				selector: #expandCollapse
				argument: #();
				
				add: 'Show dependencies'
				target: self
				selector: #showDependencies:
				argument: {box};
				
				add: 'Inspect'
				target: box model
				selector: #inspect
				argument: #() ];
		yourself.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> renderIn: aCanvas [
	| shape |
	aCanvas color: Smalltalk ui theme backgroundColor.
	shape := self shapeFor: rootNode.
	aCanvas add: shape.
	aCanvas @ (RSCanvasControllerInteraction new 
		in: [:i | i configuration useBasicZoom ];
		yourself).
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
	^ RSBox new
		size: 50;
		model: node;
		color: (self colorFor: node);
		border: (self borderFor: node);
		addInteraction: self menuInteraction;
		addInteraction: RSLabeledInteraction;
		yourself.
]

{ #category : #hooks }
HSimpleVisualizationBuilder >> showDependencies: aBox [
]
