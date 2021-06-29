"
A HSimpleVisualizationBuilderTest is a test class for testing the behavior of HSimpleVisualizationBuilder
"
Class {
	#name : #HSimpleVisualizationBuilderTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Roassal3-Tests'
}

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testColorPalette [
	| root node1 node2 subnode1 subnode2 subnode3 subnode4 gnode1 gnode2 gnode3 gnode4 |
	root := HNode new name: 'Root'.
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.

	subnode1 := HNode new name: 'SubNode1'.
	subnode2 := HNode new name: 'SubNode2'.
	subnode3 := HNode new name: 'SubNode3'.
	subnode4 := HNode new name: 'SubNode4'.

	gnode1 := HNode new name: 'GrandNode1'.
	gnode2 := HNode new name: 'GrandNode2'.
	gnode3 := HNode new name: 'GrandNode3'.
	gnode4 := HNode new name: 'GrandNode4'.
	root addAll: { node1. node2 }.

	node1 addAll: { subnode1. subnode2 }.
	node2 addAll: { subnode3. subnode4 }.

	subnode1 addAll: { gnode1. gnode2 }.
	subnode3 addAll: { gnode3. gnode4 }.

	gnode1 dependenciesFromNodes: { gnode3. gnode4 }.
	gnode4 dependenciesFromNodes: { gnode1. gnode2 }.

	HSimpleVisualizationBuilder new
		rootNode: root;
		colorPalette: (NSScale ordinal
			range: #(red green blue));
		build
]