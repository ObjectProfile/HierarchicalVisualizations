"
TODO
"
Class {
	#name : #HVisualizationBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'hspace',
		'colors'
	],
	#category : #'Hierarchical-Spec'
}

{ #category : #accessing }
HVisualizationBuilder >> backgroundColor [
	^ '2a2a2a'
]

{ #category : #hooks }
HVisualizationBuilder >> classShapeFor: cls [
	^ RSBox new
		model: cls;
		popupText: #name;
		size: 20;
		yourself
]

{ #category : #hooks }
HVisualizationBuilder >> collapse: aRSComposite [
	| c childrenLines box children title newP newLines |
	c := aRSComposite.
	title := c children first.
	c propertyAt: #box put: (box := c children second).
	c propertyAt: #hchildren put: (children := c children third).
	childrenLines := children children flatCollect: #connectedLines as: RSGroup.
	newLines := Set new.
	children children do: [ :child |
		child connectedLines 
			select: [ :line | line from parent ~= children ]
			thenDo: [ :line | newLines add: line from model -> c model ].
		child connectedLines 
			select: [ :line | line to parent ~= children ]
			thenDo: [ :line | newLines add: c -> c to model ]
		 ].
	newLines inspect.
	box remove.
	childrenLines do: #remove.
	children remove.
	title children first cornerRadius: 7.
	newP := title positionInCanvas.
	c adjustToChildren.
	c position: newP.
	c signalUpdate.
]

{ #category : #hooks }
HVisualizationBuilder >> configureCanvas: aCanvas [
	aCanvas 
		addInteraction: (RSCanvasControllerInteraction new 
			in: [:i | i configuration useBasicZoom];
			yourself)
]

{ #category : #hooks }
HVisualizationBuilder >> expand: aRSComposite [
	self inform: 'expand'
]

{ #category : #accessing }
HVisualizationBuilder >> hspace [
	^ hspace
]

{ #category : #accessing }
HVisualizationBuilder >> hspace: anHSpace [
	hspace := anHSpace
]

{ #category : #initialization }
HVisualizationBuilder >> initialize [
	super initialize.
	colors := NSScale category20c.
]

{ #category : #hooks }
HVisualizationBuilder >> packageShapeFor: hpackage [ 
	| box label title icon g comp borderRadius children |
	borderRadius := 7.
	label := RSLabel new
		text: hpackage name;
		color: #white;
		yourself.
	icon := hpackage icon.
	icon when: RSMouseClick send: #expandCollapse to: hpackage.
	g := { icon. label } asGroup.
	RSHorizontalLineLayout on: g.
	box := RSBox new
		extent: g extent +10;
		color: ((colors scale: hpackage) alpha: 0.7);
		position: g position;
		cornerRadius: (RSCornerRadius new top: borderRadius);
		yourself.
	title := 	{ box. icon. label } asShape.
		
	children := hpackage classes 
		collect: [ :cls | self classShapeFor: cls ]
		as: RSGroup.
	RSGridLayout on: children.
	children := children asShape
		padding: 10.
	title width < children width 
		ifTrue: [ box width: children width. title adjustToChildren ]
		ifFalse: [ children width: title width ].
	
	RSVerticalLineLayout new
		gapSize: 0;
		on: { title. children }.
		
	box := RSBox new
		fromRectangle: children encompassingRectangle;
		color: '404040';
		cornerRadius: (RSCornerRadius new bottom: borderRadius);
		yourself.
		
	comp := { title. box. children }  asShapeFor: hpackage.
	
	hpackage 
		when: HCollapseEvent do: [ self collapse: comp ];
		when: HExpandEvent do: [ self expand: comp ].
	comp 
		adjustToChildren;
		draggable;
		popupText: #name.
	^ comp

]

{ #category : #hooks }
HVisualizationBuilder >> renderIn: aCanvas [
	| packages classes |
	aCanvas color: self backgroundColor.
	self configureCanvas: aCanvas.
	hspace ifNil: [ ^ self ].
	colors := NSScale category20c.
	packages := hspace packages 
		collect: [ :p | self packageShapeFor: p ].
	classes := packages flatCollect: [ :p | p children third children ] as: RSGroup.
	aCanvas addAll: packages.
	aCanvas nodes 
		when: RSMouseDragStart do: [ :evt | 
			evt shape pushFront.
			evt shape children size >2 ifTrue: [ 
				(evt shape children third children flatCollect: #connectedEdges as: RSGroup) pushFront
			] ].
	
	RSLineBuilder horizontalBezier
		canvas: aCanvas;
		shapes: classes;
		connectToAll: #dependentClasses.
	classes @ RSHighlightableInteraction red withLines.
	aCanvas addInteraction: RSHierarchyPackerInteraction new.


]
