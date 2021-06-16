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
	#category : #'Hierarchical-Roassal3'
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
	| c childrenLines box children title newP |
	c := aRSComposite.
	title := c children first.
	box := c children second.
	children := c children third.
	childrenLines := children children flatCollect: #connectedLines as: RSGroup.
	self newLines: childrenLines composite: c.
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
		color: self backgroundColor;
		addInteraction: (RSCanvasController new 
			in: [:i | i configuration
				noZoomToFitOnExtendChanged;
				useBasicZoom];
			yourself);
		addInteraction: RSHierarchyPackerInteraction new
]

{ #category : #hooks }
HVisualizationBuilder >> expand: aRSComposite [
	| oldPackage canvas newPackage oldTitle newTitle hpackage classes |
	oldPackage := aRSComposite.
	hpackage := oldPackage model.
	hpackage removeInteractionIfPresent: self class.
	canvas := oldPackage canvas.
	newPackage := self packageShapeFor: hpackage.
	canvas add: newPackage.
	oldTitle := oldPackage children first.
	newTitle := newPackage children first.
	newPackage translateBy: oldTitle positionInCanvas - newTitle positionInCanvas.
	oldPackage remove.
	
	newPackage children third children @ RSHighlightable red withLines.
	classes := canvas nodes flatCollect: [ :p | 
		p children size > 2 
			ifTrue: [ p children third children ]
			ifFalse: [ #() ]
		] as: RSGroup.
	self lineBuilder
		canvas: canvas;
		shapes: classes;
		connectToAll: #dependentClasses.
	
	canvas signalUpdate.

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

{ #category : #accessing }
HVisualizationBuilder >> lineBuilder [
	^ RSLineBuilder bezier
		controlPointsController: HVisualizationCPController new;
		markerStartEnd: (RSEllipse new size: 3);
		yourself
]

{ #category : #hooks }
HVisualizationBuilder >> newLines: childrenLines composite: c [
	| lines b parent |
	b := self lineBuilder
		canvas: c canvas;
		yourself.
	parent := c children third.
	lines := Set new.
	childrenLines 
		reject: [ :line | line from parent = parent and: [ line to parent = parent ] ]
		thenDo: [ :line | | assoc |
			assoc := c -> line to.
			(line from parent = parent 
				and: [ (lines includes: assoc) not ])
					ifTrue: [ 
						b edgeFrom: c to: line to.
						lines add: assoc ].
					
			assoc := line from -> c.
			(line to parent = parent 
				and: [ (lines includes: assoc) not ])
					ifTrue: [ 
						b edgeFrom: line from to: c.
						lines add: assoc ]
		 ].
	
		
	
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
	
	hspace ifNil: [ ^ self ].
	colors := NSScale category20c.
	packages := hspace packages 
		collect: [ :p | self packageShapeFor: p ]
		as: RSGroup.
	
	aCanvas addAll: packages.
	aCanvas nodes 
		when: RSMouseDragStart do: [ :evt | 
			evt shape pushFront.
			evt shape children size >2 ifTrue: [ 
				(evt shape children third children flatCollect: #connectedEdges as: RSGroup) pushFront
			] ].
	
	classes := packages flatCollect: [ :p | p children third children ] as: RSGroup.
	self lineBuilder
		canvas: aCanvas;
		shapes: classes;
		connectToAll: #dependentClasses.
	
	self configureCanvas: aCanvas.
	"RSRectanglePackLayout new
		doNotUseProgressBar;
		on: packages.
	aCanvas camera position: packages encompassingRectangle floatCenter."


]
