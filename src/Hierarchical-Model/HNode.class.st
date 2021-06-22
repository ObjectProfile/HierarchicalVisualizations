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
		'name',
		'rawModel',
		'parent',
		'isExpanded',
		'children',
		'dependencies'
	],
	#category : #'Hierarchical-Model'
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
	self announce: (HNodeAddedEvent new
		newChild: anHNode;
		yourself)
]

{ #category : #dependencies }
HNode >> addLink: link [
	self dependencies isArray 
		ifTrue: [ dependencies := dependencies asOrderedCollection ].
	dependencies add: link
]

{ #category : #adding }
HNode >> addedIn: anHNode [
	anHNode addChild: self.
	self parent: anHNode.
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

{ #category : #dependencies }
HNode >> dependencies [

	^ dependencies ifNil: [ dependencies := #() ]
]

{ #category : #dependencies }
HNode >> dependencies: aCollectionOfLinks [
	dependencies := aCollectionOfLinks asOrderedCollection
]

{ #category : #dependencies }
HNode >> dependenciesFromNodes: aCollection [
	aCollection do: [ :node | | link |
		link := HLink new 
			from: self; 
			to: node;
			yourself.
		self addLink: link.
		node addLink: link.
		 ].
]

{ #category : #dependencies }
HNode >> dependentsFromLinks [
	| list |
	list := (self dependencies
		select: [ :link | link to = self ]
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
HNode >> expandCollapse [
	isExpanded 
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].
]

{ #category : #testing }
HNode >> hasChildren [
	^ children notEmpty
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

{ #category : #printing }
HNode >> printOn: stream [
	stream << name.
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

{ #category : #dependencies }
HNode >> visibleNodeOrParent [
	parent ifNil: [ ^ self ].
	^ self isVisible
		ifTrue: [ self ]
		ifFalse: [ parent visibleNodeOrParent ]
]
