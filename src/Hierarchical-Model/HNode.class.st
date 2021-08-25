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
		'children',
		'dependencies',
		'iconName',
		'position',
		'layout',
		'color'
	],
	#category : #'Hierarchical-Model-Core'
}

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

{ #category : #dependencies }
HNode >> allDependencies [
	^ self dependencies, (self hasChildren 
		ifTrue: [ self children flatCollect: [ :child|
			child allDependencies ] ]
		ifFalse: [ #() ])
]

{ #category : #announcer }
HNode >> announcementClasses [
	^ #()
]

{ #category : #announcer }
HNode >> announcer: anAnnouncer [
	announcer := anAnnouncer
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

{ #category : #accessing }
HNode >> color [

	^ color
]

{ #category : #accessing }
HNode >> color: anObject [

	color := anObject
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
]

{ #category : #dependencies }
HNode >> dependentsFromLinks [
	| list |
	list := (self dependencies
		select: [ :link | 
			link isVisible and: [ link to = self] ]
		thenCollect: [:link | 
			link from visibleNodeOrParent ]) asOrderedCollection.
	(self isExpanded and: [ self isVisible ]) ifTrue: [ ^ list asSet ].
	
	self children do: [ :child | list addAll: child dependentsFromLinks ].
	
	^ list asSet.
]

{ #category : #dependencies }
HNode >> dependentsToLinks [
	^ (self dependencies 
		select: [ :link | link from = self]
		thenCollect: [:link | 
			link to visibleNodeOrParent ]) asSet.
]

{ #category : #public }
HNode >> expand [
	isExpanded := true.
	self announce: (HExpandEvent new node: self)
]

{ #category : #public }
HNode >> expandChildren [
	children do: [ :child | child expand ].
]

{ #category : #public }
HNode >> expandCollapse [
	isExpanded 
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].
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
HNode >> iconName: aString [
	| oldName |
	oldName := iconName.
	iconName := aString.
	oldName = aString ifTrue: [ ^ self ].
	self announce: (HIconChangedEvent new
		oldName: oldName;
		newName: aString;
		yourself).
]

{ #category : #initialization }
HNode >> initialize [
	super initialize.
	children := OrderedCollection new.
	isExpanded := true.
]

{ #category : #testing }
HNode >> isExpanded [
	^ isExpanded
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
	self announce: (HNodeNameChangedEvent new
		node: self;
		oldName: oldName;
		newName: name;
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

{ #category : #accessing }
HNode >> position [

	^ position
]

{ #category : #accessing }
HNode >> position: aPoint [
	position := aPoint
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

{ #category : #'showing - hiding' }
HNode >> showAllLinks [
	self allDependencies do: [ :link | link isVisible: true ]
]

{ #category : #dependencies }
HNode >> visibleNodeOrParent [
	parent ifNil: [ ^ self ].
	^ self isVisible
		ifTrue: [ self ]
		ifFalse: [ parent visibleNodeOrParent ]
]
