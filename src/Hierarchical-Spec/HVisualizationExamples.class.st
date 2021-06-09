"
todo #2a2a2a
"
Class {
	#name : #HVisualizationExamples,
	#superclass : #Object,
	#category : #'Hierarchical-Spec'
}

{ #category : #examples }
HVisualizationExamples >> example01Empty [
	<script: 'self new example01Empty'>
	| space |
	space := HNameSpace new.
	space open.
]

{ #category : #examples }
HVisualizationExamples >> example02WithPackage [
	<script: 'self new example02WithPackage'>
	| space |
	space := HNameSpace new. 
	
	space add: (HPackage from: (RPackage organizer packageNamed: 'HierarchicalModel')).
	space open.
]

{ #category : #examples }
HVisualizationExamples >> example03WithPackages [
	<script: 'self new example03WithPackages'>
	| space org packages |
	space := HNameSpace new. 
	org := RPackage organizer.
	packages := org packageNames 
		select: [ :s | 'Roassal3-Chart*' match: s  ]
		thenCollect: [ :s | HPackage from: (org packageNamed: s) ].
	space addAll: packages.
	space open.
]

{ #category : #examples }
HVisualizationExamples >> example04WithManyPackages [
	<script: 'self new example04WithManyPackages'>
	| space org packages |
	space := HNameSpace new. 
	org := RPackage organizer.
	packages := org packageNames 
		select: [ :s | 'Roassal3*' match: s  ]
		thenCollect: [ :s | HPackage from: (org packageNamed: s) ].
	space addAll: packages.
	space open.
]

{ #category : #examples }
HVisualizationExamples >> example05AllPackages [
	"<script: 'self new example05AllPackages'>"
	| space org packages |
	space := HNameSpace new. 
	org := RPackage organizer.
	packages := org packageNames
		collect: [ :s | HPackage from: (org packageNamed: s) ].
	space addAll: packages.
	space open.
]

{ #category : #examples }
HVisualizationExamples >> example06Simple [
	<script: 'self new example06Simple'>
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	node1 dependencies: { subnode1. subnode2 }.
	subnode1 dependencies: { node1 }.
	subnode2 dependencies: { node1 }.
	
	rootNode open.

]
