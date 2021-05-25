"
todo
"
Class {
	#name : #HEvent,
	#superclass : #Announcement,
	#instVars : [
		'item'
	],
	#category : #'HierarchicalModel-Events'
}

{ #category : #accessing }
HEvent >> item [

	^ item
]

{ #category : #accessing }
HEvent >> item: anObject [

	item := anObject
]
