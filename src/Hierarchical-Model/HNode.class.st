"
TODO
"
Class {
	#name : #HNode,
	#superclass : #Object,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'rawModel',
		'name',
		'parent',
		'isExpanded',
		'isLinksExpanded',
		'children',
		'dependencies',
		'iconName',
		'position',
		'layout',
		'color',
		'style'
	],
	#category : #'Hierarchical-Model-Core'
}

{ #category : #'instance creation' }
HNode class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #adding }
HNode >> add: anHNode [
	anHNode addedIn: self.
]

{ #category : #adding }
HNode >> addAll: aCollection [
	aCollection do: [ :item | self add: item ]
	
]

{ #category : #adding }
HNode >> addChild: anHNode [
	children add: anHNode.
	anHNode parent: self.
	self announce: (HNodeAddedEvent new
		newChild: anHNode;
		yourself)
]

{ #category : #adding }
HNode >> addLink: link [
	self dependencies isArray 
		ifTrue: [ dependencies := dependencies asOrderedCollection ].
	dependencies add: link
]

{ #category : #adding }
HNode >> addedIn: anHNode [
	anHNode addChild: self.
]

{ #category : #accessing }
HNode >> allChildren [
	| allChildren index |
	index := 1.
	allChildren := OrderedCollection withAll: self children.
	[index <= allChildren size] whileTrue: 
			[allChildren addAll: (allChildren at: index) children.
			index := index + 1].
	^allChildren
]

{ #category : #dependencies }
HNode >> allDependencies [
	^ self dependencies, (self hasChildren 
		ifTrue: [ self children flatCollect: [ :child|
			child allDependencies ] ]
		ifFalse: [ #() ])
]

{ #category : #'computing - dependencies' }
HNode >> allRawModelDependenciesIn: aHNode [ 
	| list nodesToCompare |
	list := OrderedCollection new.
	nodesToCompare := aHNode isExpanded
		ifTrue: [ { aHNode }  ]
		ifFalse: [ aHNode withAllChildren ].
	self allRawModelDependenciesIn: nodesToCompare asSet fill: list.
	^ list collect: [:each | each rawModel].
]

{ #category : #'computing - dependencies' }
HNode >> allRawModelDependenciesIn: nodesToCompare fill: result [ 

	| selection |
	selection := self allDependencies select: [ :link | nodesToCompare includes: link to ].
	result addAll: selection.
	self isExpanded ifTrue: [ ^ self ].
	
]

{ #category : #announcer }
HNode >> announcementClasses [
	^ #()
]

{ #category : #announcer }
HNode >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #converting }
HNode >> asShape [

	^ self style shapeFor: self
]

{ #category : #accessing }
HNode >> children [

	^ children
]

{ #category : #accessing }
HNode >> children: aCollection [
	children := aCollection
]

{ #category : #public }
HNode >> collapse [
	isExpanded := false.
	self announce: (HCollapseEvent new node: self)
	
]

{ #category : #public }
HNode >> collapseChildren [
	children do: [ :child | child collapse ].
]

{ #category : #public }
HNode >> collapseLinks [
	isLinksExpanded := false.
]

{ #category : #accessing }
HNode >> color [

	^ color
]

{ #category : #accessing }
HNode >> color: aColor [
	| oldColor |
	oldColor := color.
	color := aColor.
	oldColor = color ifTrue: [ ^ self ].
	self announce: (HNodeChangedEvent new
		node: self;
		yourself).
]

{ #category : #accessing }
HNode >> defaultStyle [

	^ HDefaultStyle new
]

{ #category : #dependencies }
HNode >> dependencies [

	^ dependencies ifNil: [ dependencies := #() ]
]

{ #category : #dependencies }
HNode >> dependencies: aCollectionOfLinks [
	dependencies := aCollectionOfLinks asOrderedCollection
]

{ #category : #dependencies }
HNode >> dependenciesToNodes: aCollection [
	dependencies isArray ifTrue: [ 
		dependencies := OrderedCollection new: aCollection size. ].
	aCollection do: [ :node | self dependencyTo: node ].
]

{ #category : #dependencies }
HNode >> dependencyTo: anHNode [
	| link |
	link := HLink new
		from: self;
		to: anHNode;
		yourself.
	anHNode addLink: link.
	self addLink: link.
	^ link
]

{ #category : #dependencies }
HNode >> dependencyTo: aHNode withModel: anObject [
	"self haltIf: [ name = 'nodeClass' and: [ aHNode name = 'AIReducedGraphNode' ]]."
	^ (self dependencyTo: aHNode)
		rawModel: anObject;
		yourself
]

{ #category : #'computing - dependencies' }
HNode >> dependentsFromLinks [
	"main code to generate lines between nodes"
	^ self doesParentDisplayLinks
		ifTrue: [ self dependentsFromLinksForNode ]
		ifFalse: [ self dependentsToLinksForNode: self parentNotDisplayLinks ].
]

{ #category : #'computing - dependencies' }
HNode >> dependentsFromLinksForNode [
	| set |
	set := self dependencies
		select: [ :link | self shouldDisplayLink: link ]
		thenCollect: [:link | link from visibleNodeOrParent ].
	
	set := set asSet.
	(self isExpanded and: [ self isVisible and: [ self isLinksExpanded ] ]) 
		ifTrue: [ ^ set ].
	self children do: [ :child | 
		set addAll: child dependentsFromLinksForNode ].
	^ set
	
]

{ #category : #dependencies }
HNode >> dependentsToLinks [
	^ (self dependencies 
		select: [ :link | link from = self ]
		thenCollect: [:link | 
			link to visibleNodeOrParent ]) asSet.
]

{ #category : #'computing - dependencies' }
HNode >> dependentsToLinksForNode: aNode [
	| set |
	set := self dependencies
		select: [ :link | self shouldDisplayLink: link in: aNode ]
		thenCollect: [:link | link from visibleNodeOrParentIn: aNode ].
	
	set := set asSet.
	(self isExpanded and: [ self isVisible and: [ self isLinksExpanded ] ]) 
		ifTrue: [ ^ set ].
	self children do: [ :child |
		set addAll: (child dependentsToLinksForNode: aNode) ].
	^ set
]

{ #category : #testing }
HNode >> doesParentDisplayLinks [
	parent ifNil: [ ^ true ].
	^ parent isVisible and: [ parent isLinksExpanded and: [ parent doesParentDisplayLinks ] ]
]

{ #category : #public }
HNode >> expand [
	isExpanded := true.
	self announce: (HExpandEvent new node: self)
]

{ #category : #public }
HNode >> expandChildren [
	children do: [ :child | child isExpanded: true ].
	self announce: HExpandChildrenEvent new
]

{ #category : #public }
HNode >> expandCollapse [
	isExpanded 
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].
]

{ #category : #public }
HNode >> expandLinks [
	isLinksExpanded := true.
]

{ #category : #utility }
HNode >> fixDependencies: node [
	node dependencies: (node dependencies collect: [:link | | linkCopy |
		linkCopy := link copy.
		linkCopy
			from: (node topParent globalChildEquals: link from);
			to: (node topParent globalChildEquals: link to);
			yourself
		] thenReject: [:link | link from isNil or: [ link to isNil ] ]).
	node children do: [ :child | self fixDependencies: child ].
]

{ #category : #utility }
HNode >> fixDependents [
	self fixDependencies: self.
	
]

{ #category : #'accessing - computed' }
HNode >> globalChildEquals: anHNode [
	anHNode ifNil: [ ^ nil ].
	rawModel = anHNode rawModel ifTrue: [ 
		rawModel 
			ifNil: [ name = anHNode name 
				ifTrue: [ ^ self ] ]
			ifNotNil: [ ^ self ] ].
	self children do: [ :child |
		(child globalChildEquals: anHNode) ifNotNil: [:res | ^ res ].
		 ].
	^ nil
	
]

{ #category : #testing }
HNode >> hasChildren [
	^ children notEmpty
]

{ #category : #'showing - hiding' }
HNode >> hideAllLinks [
	self allDependencies do: [ :link | link isVisible: false ]
]

{ #category : #'showing - hiding' }
HNode >> hideIncomingLinks [
	self dependencies
		select: [ :link | link to = self ]
		thenDo: [ :link | link isVisible: false ] .
	self children do: #hideIncomingLinks
]

{ #category : #'showing - hiding' }
HNode >> hideLinkTo: anHNode [
	self allDependencies do: [ :link | 
		link to visibleNodeOrParent = anHNode ifTrue: [ 
			link isVisible: false ].
		 ].

]

{ #category : #'showing - hiding' }
HNode >> hideOutgoingLinks [
	self dependencies
		select: [ :link | link from = self ]
		thenDo: [ :link | link isVisible: false ] .
	self children do: #hideOutgoingLinks
]

{ #category : #accessing }
HNode >> iconName [
	^ iconName
]

{ #category : #accessing }
HNode >> iconName: aString [
	| oldName |
	oldName := iconName.
	iconName := aString.
	oldName = aString ifTrue: [ ^ self ].
	self announce: (HNodeChangedEvent new
		node: self;
		yourself).
]

{ #category : #initialization }
HNode >> initialize [
	super initialize.
	children := OrderedCollection new.
	isLinksExpanded := isExpanded := true.

]

{ #category : #testing }
HNode >> isExpanded [
	^ isExpanded
]

{ #category : #testing }
HNode >> isExpanded: aBoolean [ 

	isExpanded := aBoolean
]

{ #category : #testing }
HNode >> isLinksExpanded [
	^ isLinksExpanded
]

{ #category : #testing }
HNode >> isVisible [
	parent ifNil: [ ^ true ].
	^ parent isExpanded and: [ parent isVisible ]
]

{ #category : #accessing }
HNode >> layout [
	^ layout
]

{ #category : #accessing }
HNode >> layout: aLayout [
	layout := aLayout
]

{ #category : #accessing }
HNode >> level [
	^ parent 
		ifNil: [ 0 ]
		ifNotNil: [ 1 + parent level ]
]

{ #category : #accessing }
HNode >> name [
	^ name
]

{ #category : #accessing }
HNode >> name: aString [
	| oldName |
	oldName := name.
	name := aString.
	oldName = name ifTrue: [ ^ self ].
	self announce: (HNodeChangedEvent new
		node: self;
		yourself)
		
]

{ #category : #accessing }
HNode >> parent [

	^ parent
]

{ #category : #accessing }
HNode >> parent: anHNode [

	parent := anHNode
]

{ #category : #'computing - dependencies' }
HNode >> parentNotDisplayLinks [
	parent ifNil: [ ^ self ].
	(parent isVisible and: [ parent isLinksExpanded not ])
		ifTrue: [ ^ parent ].
	^ parent parentNotDisplayLinks.
	
]

{ #category : #accessing }
HNode >> position [

	^ position
]

{ #category : #accessing }
HNode >> position: aPoint [
	position := aPoint
]

{ #category : #copying }
HNode >> postCopy [
	self 
		children: (self children collect: [:child | child copy ]);
		parent: nil;
		announcer: nil.
	self children do: [ :child | child parent: self ].
]

{ #category : #printing }
HNode >> printOn: stream [
	stream << (name ifNil: [ 'nil' ])
]

{ #category : #announcer }
HNode >> privateAnnouncer [
	^ announcer
]

{ #category : #accessing }
HNode >> rawModel [

	^ rawModel
]

{ #category : #accessing }
HNode >> rawModel: anObject [
	rawModel := anObject
]

{ #category : #removing }
HNode >> removeLink: anHLink [
	dependencies remove: anHLink
]

{ #category : #removing }
HNode >> removeLinkTo: anHNode [
	
	self allDependencies do: [ :link | 
		link to visibleNodeOrParent = anHNode ifTrue: [ 
			link to removeLink: link.
			link from removeLink: link ].
		 ].

]

{ #category : #testing }
HNode >> shouldDisplayLink: anHLink [
	| link |
	link := anHLink.
	^ link isVisible and: [ link to = self ] 
]

{ #category : #testing }
HNode >> shouldDisplayLink: anHLink in: aNode [
	| link |
	link := anHLink.
	^ link isVisible and: [ link to = self and: [ (aNode globalChildEquals: link from) notNil ] ] 
]

{ #category : #'showing - hiding' }
HNode >> showAllLinks [
	self allDependencies do: [ :link | link isVisible: true ]
]

{ #category : #accessing }
HNode >> style [

	^ style ifNil: [ style := self defaultStyle ]
]

{ #category : #accessing }
HNode >> style: anObject [

	style := anObject
]

{ #category : #accessing }
HNode >> topParent [
	^ parent 
		ifNil: [ self ]
		ifNotNil: [ self parent topParent ].

]

{ #category : #'computing - dependencies' }
HNode >> visibleNodeOrParent [
	parent ifNil: [ ^ self ].
	^ (self isVisible and: [ parent isLinksExpanded ])
		ifTrue: [ self ]
		ifFalse: [ parent visibleNodeOrParent ]
]

{ #category : #'computing - dependencies' }
HNode >> visibleNodeOrParentIn: aNode [
	parent ifNil: [ ^ self ].
	^ self isVisible
		ifTrue: [ self ]
		ifFalse: [ parent visibleNodeOrParentIn: aNode ]
]

{ #category : #accessing }
HNode >> withAllChildren [
	^ self allChildren
		add: self;
		yourself
]
