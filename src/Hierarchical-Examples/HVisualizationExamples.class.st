"
todo #2a2a2a
"
Class {
	#name : #HVisualizationExamples,
	#superclass : #Object,
	#category : #'Hierarchical-Examples'
}

{ #category : #examples }
HVisualizationExamples >> example01Empty [
	<script: 'self new example01Empty'>
	| space |
	space := HNode new.
	space open.
]

{ #category : #examples }
HVisualizationExamples >> example02Simple [
	<script: 'self new example02Simple'>
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	node1 dependenciesFromNodes: { subnode1. subnode2 }.

	rootNode open.

]

{ #category : #examples }
HVisualizationExamples >> example03Simple2 [
	<script: 'self new example03Simple2'>
	| node1 node2 subnode1 subnode2 rootNode subnode3 subnode4 |
	node1 := HNode new name: 'Node1'.
	subnode3 := HNode new name: 'Sub1-1'.
	subnode4 := HNode new name: 'Sub1-2'.
	node1 addAll: { subnode3 . subnode4 }.

	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	
	rootNode := HNode new name: 'Root'.
	rootNode addAll: { node1. node2 }.
	subnode3 dependenciesFromNodes: { subnode1. subnode2 }.

	rootNode open.

]

{ #category : #examples }
HVisualizationExamples >> example04WithPackage [
	<script: 'self new example04WithPackage'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Hierarchical-Model'.
	b build.
	b rootNode open
]

{ #category : #examples }
HVisualizationExamples >> example05WithPackages [
	<script: 'self new example05WithPackages'>
	| b nodes |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Roassal3-Chart*'.
	b build.
	nodes := b rootNode children flatCollect: [ :node | node children ].
	nodes do: [ :node | node collapse ].
	b rootNode open
]

{ #category : #examples }
HVisualizationExamples >> example06WithManyPackages [
	<script: 'self new example06WithManyPackages'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Roassal3*'.
	b build.
	b rootNode children do: [ :node | node collapse ].
	b rootNode open
]

{ #category : #examples }
HVisualizationExamples >> example07Hierarchical [
	<script: 'self new example07Hierarchical'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Hierarchical*'.
	b build.
	b rootNode open
]

{ #category : #examples }
HVisualizationExamples >> example08RSChart [
	<script: 'self new example08RSChart'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Roassal3-Chart*'.
	b build.
	b rootNode open
]
