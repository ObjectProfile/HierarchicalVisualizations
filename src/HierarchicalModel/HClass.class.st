"
A basic class 
"
Class {
	#name : #HClass,
	#superclass : #HModel,
	#instVars : [
		'instVars',
		'methods'
	],
	#category : #HierarchicalModel
}

{ #category : #accessing }
HClass >> instVars [

	^ instVars
]

{ #category : #accessing }
HClass >> instVars: aCollection [
	instVars := aCollection
]

{ #category : #accessing }
HClass >> methods [

	^ methods
]

{ #category : #accessing }
HClass >> methods: aCollection [
	methods := aCollection
]
