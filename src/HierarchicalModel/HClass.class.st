"
A basic class 
"
Class {
	#name : #HClass,
	#superclass : #HModel,
	#instVars : [
		'dependentClasses'
	],
	#category : #HierarchicalModel
}

{ #category : #'instance creation' }
HClass class >> from: aClass [
	^ self new
		rawModel: aClass;
		name: aClass name;
		yourself.
		
]

{ #category : #dependencies }
HClass >> dependentClasses [
	^ dependentClasses ifNil: [ dependentClasses := self parent dependentClassesFor: self ]
]

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

{ #category : #accessing }
HClass >> superclass [
	^ self class new 
		rawModel: rawModel superclass;
		yourself
]
