"
TODO
"
Class {
	#name : #HPharoNodeBuilder,
	#superclass : #HNodeBuilder,
	#instVars : [
		'packageQuery'
	],
	#category : #'Hierarchical-Builder'
}

{ #category : #building }
HPharoNodeBuilder >> build [
	rootNode := HNode new.
	rootNode addAll: (self pharoPackages collect: [ :pkg | self buildNodeFromPackage: pkg ]).
	self createDependenciesBetweenMethods.
	
]

{ #category : #building }
HPharoNodeBuilder >> buildNodeFromClass: clazz [
	^ HNode new
		name: clazz name;
		rawModel: clazz;
		iconName: #class;
		addAll: (clazz methods collect: [:met | self buildNodefromMethod: met ]);
		collapse;
		yourself
]

{ #category : #building }
HPharoNodeBuilder >> buildNodeFromPackage: package [ 
	^ HNode new
		name: package name;
		rawModel: package;
		iconName: #monticelloPackage;
		addAll: (package definedClasses collect: [:cls | self buildNodeFromClass: cls ]);
		yourself
]

{ #category : #building }
HPharoNodeBuilder >> buildNodefromMethod: method [
	^ HNode new
		name: method selector;
		rawModel: method;
		iconName: #glamorousBrowse;
		yourself
	
]

{ #category : #building }
HPharoNodeBuilder >> createDependenciesBetweenMethods [
	| methods |
	methods := rootNode children flatCollect: [ :pkg | 
		pkg children flatCollect: [ :cls | cls children ] ].
	methods copy do: [ :met | | nodes |
		nodes := met rawModel messages flatCollect: [:str | 
			methods select: [ :met1 | met1 name = str ]
			].
		met dependenciesToNodes: nodes.
	].
	
]

{ #category : #accessing }
HPharoNodeBuilder >> packageQuery [

	^ packageQuery
]

{ #category : #accessing }
HPharoNodeBuilder >> packageQuery: anObject [

	packageQuery := anObject
]

{ #category : #building }
HPharoNodeBuilder >> pharoPackages [
	| org |
	org := RPackage organizer.
	^ org packageNames
		select: [ :s | packageQuery match: s ]
		thenCollect: [ :s | org packageNamed: s ]
	
]
