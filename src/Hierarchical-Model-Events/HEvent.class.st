"
todo
"
Class {
	#name : #HEvent,
	#superclass : #Announcement,
	#instVars : [
		'item'
	],
	#category : #'Hierarchical-Model-Events'
}

{ #category : #accessing }
HEvent >> item [

	^ item
]

{ #category : #accessing }
HEvent >> item: anObject [

	item := anObject
]
