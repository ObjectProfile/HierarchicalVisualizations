"
TODO
"
Class {
	#name : #HPackage,
	#superclass : #HModel,
	#category : #HierarchicalModel
}

{ #category : #'instance creation' }
HPackage class >> from: aRPackage [ 
	^ self new
		rawModel: aRPackage;
		name: aRPackage name;
		addAll: (aRPackage definedClasses
			collect: [:cls | HClass from: cls]);
		yourself
]

{ #category : #accessing }
HPackage >> classes [
	^ items
]

{ #category : #'as yet unclassified' }
HPackage >> dependentClassesFor: anHClass [
	^ self parent dependentClassesFor: anHClass
]
