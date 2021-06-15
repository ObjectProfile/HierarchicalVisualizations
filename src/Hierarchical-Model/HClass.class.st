"
A basic class 
"
Class {
	#name : #HClass,
	#superclass : #HNode,
	#instVars : [
		'dependentClasses'
	],
	#category : #'Hierarchical-Model'
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

	^ nil
]

{ #category : #accessing }
HClass >> instVars: aCollection [
	
]

{ #category : #accessing }
HClass >> methods [

	^ nil
]

{ #category : #accessing }
HClass >> methods: aCollection [
	
]

{ #category : #accessing }
HClass >> superclass [
	^ self class new 
		rawModel: rawModel superclass;
		yourself
]
