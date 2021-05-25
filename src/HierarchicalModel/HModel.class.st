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
		'name'
	],
	#category : #HierarchicalModel
}

{ #category : #announcer }
HModel >> announcementClasses [
	^ #()
]

{ #category : #announcer }
HModel >> announcer: anAnnouncer [
	announcer := anAnnouncer
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

{ #category : #announcer }
HModel >> privateAnnouncer [
	^ announcer
]
