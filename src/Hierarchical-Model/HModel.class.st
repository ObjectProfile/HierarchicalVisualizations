"
TODO
"
Class {
	#name : #HModel,
	#superclass : #Object,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'name',
		'rawModel',
		'items',
		'parent',
		'isExpanded'
	],
	#category : #'Hierarchical-Model'
}

{ #category : #adding }
HModel >> add: anHModel [
	anHModel addedIn: self.
]

{ #category : #adding }
HModel >> addAll: aCollection [
	aCollection do: [ :item | self add: item ]
	
]

{ #category : #adding }
HModel >> addItem: anHModel [
	items add: anHModel
]

{ #category : #adding }
HModel >> addedIn: aModel [
	aModel addItem: self.
	self parent: aModel.
]

{ #category : #announcer }
HModel >> announcementClasses [
	^ #()
]

{ #category : #announcer }
HModel >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #public }
HModel >> collapse [
	self announce: HCollapseEvent new
]

{ #category : #public }
HModel >> expand [
	self announce: HExpandEvent new
]

{ #category : #public }
HModel >> expandCollapse [
	isExpanded 
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].
	isExpanded := isExpanded not
]

{ #category : #initialization }
HModel >> initialize [
	super initialize.
	items := OrderedCollection new.
	isExpanded := true.
]

{ #category : #testing }
HModel >> isExpanded [
	^ isExpanded
]

{ #category : #accessing }
HModel >> items [

	^ items
]

{ #category : #accessing }
HModel >> items: anObject [

	items := anObject
]

{ #category : #accessing }
HModel >> name [
	^ name
]

{ #category : #accessing }
HModel >> name: aString [
	| oldName |
	oldName := name.
	name := aString.
	self announce: (HItemNameChangedEvent new
		item: self;
		oldName: oldName;
		newName: name;
		yourself)
		
]

{ #category : #accessing }
HModel >> parent [

	^ parent
]

{ #category : #accessing }
HModel >> parent: anObject [

	parent := anObject
]

{ #category : #announcer }
HModel >> privateAnnouncer [
	^ announcer
]

{ #category : #accessing }
HModel >> rawModel [

	^ rawModel
]

{ #category : #accessing }
HModel >> rawModel: anObject [
	rawModel := anObject
]
