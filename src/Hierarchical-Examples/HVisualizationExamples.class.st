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
	<script: 'self new example01Empty open'>
	| space |
	space := HNode new.
	^ space
]

{ #category : #examples }
HVisualizationExamples >> example02Simple [
	<script: 'self new example02Simple open'>
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode named: 'Node1'.
	node2 := HNode named: 'Node2'.
	subnode1 := HNode named: 'Sub2-1'.
	subnode2 := HNode named: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode named: 'Root'.
	rootNode addAll: {node1. node2}.
	node1 dependenciesToNodes: { subnode1. subnode2 }.

	^ rootNode.

]

{ #category : #examples }
HVisualizationExamples >> example03Simple2 [
	<script: 'self new example03Simple2 open'>
	| node1 node2 subnode1 subnode2 rootNode subnode3 subnode4 |
	node1 := HNode named: 'Node1'.
	subnode3 := HNode named: 'Sub1-1'.
	subnode4 := HNode named: 'Sub1-2'.
	
	node1 addAll: { subnode3 . subnode4 }.

	node2 := HNode named: 'Node2'.
	subnode1 := HNode named: 'Sub2-1'.
	subnode2 := HNode named: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	
	node1 children, node2 children do: [ :child | child color: Color blue translucent ].
	rootNode := HNode named: 'Root'.
	rootNode addAll: { node1. node2 }.
	subnode3 dependenciesToNodes: { subnode1. subnode2 }.

	^ rootNode.

]

{ #category : #examples }
HVisualizationExamples >> example04WithPackage [
	<script: 'self new example04WithPackage open'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Hierarchical-Model'.
	b build.
	^ b rootNode
]

{ #category : #examples }
HVisualizationExamples >> example05WithPackages [
	<script: 'self new example05WithPackages open'>
	| b nodes |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Roassal3-Chart*'.
	b build.
	nodes := b rootNode children flatCollect: [ :node | node children ].
	nodes do: [ :node | node collapse ].
	^ b rootNode
]

{ #category : #examples }
HVisualizationExamples >> example06WithManyPackages [
	<script: 'self new example06WithManyPackages open'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Roassal3*'.
	b build.
	b rootNode children do: [ :node | node collapse ].
	^ b rootNode
]

{ #category : #examples }
HVisualizationExamples >> example07Hierarchical [
	<script: 'self new example07Hierarchical open'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Hierarchical*'.
	b build.
	^ b rootNode
]

{ #category : #examples }
HVisualizationExamples >> example08RSChart [
	<script: 'self new example08RSChart open'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Roassal3-Chart*'.
	b build.
	^ b rootNode
]

{ #category : #examples }
HVisualizationExamples >> example09Collection [
	<script: 'self new example09Collection open'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Collections-Abstract*'.
	b colorPalette: NSScale eva10.
	b build.
	^ b rootNode
]

{ #category : #examples }
HVisualizationExamples >> example10RSChartLabeler [
	<script: 'self new example10RSChartLabeler open'>
	| b visualization style |
	b := HPharoNodeBuilder new.
	style := HDefaultStyle new.
	b nodeStyle: style.
	b packageQuery: 'Roassal3-Chart*'.
	b build.
	
	visualization := HSimpleVisualizationBuilder new.
	visualization popup:(RSPopup new
			in: [:p | p shapeBuilder labelBuilder labelShape 
				fontSize: 20;
				color: Color black. ];
			yourself).
	visualization rootNode: b rootNode.
	^ visualization
	
]

{ #category : #examples }
HVisualizationExamples >> example11HierarchicalDiferentLayout [
	<script: 'self new example11HierarchicalDiferentLayout open'>
	| b |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Hierarchical*'.
	b build.
	b rootNode layout: RSVerticalLineLayout new. 
	b rootNode children do: [ :child | 
		child layout: RSFlowLayout new.
		child children do: [:c | 
			c layout: (RSForceBasedLayout new charge: -600; doNotUseProgressBar)
			
			 ] ].
	^ b rootNode

]

{ #category : #examples }
HVisualizationExamples >> example12HierarchicalWithDifferentLines [
	<script: 'self new example12HierarchicalWithDifferentLines open'>
	| b v |
	b := HPharoNodeBuilder new.
	b packageQuery: 'Hierarchical*'.
	b build.
	v := HSimpleVisualizationBuilder new
		rootNode: b rootNode;
		yourself.
	v lineBuilder
		markerStart: (RSEllipse new size: 10);
		width: 5;
		color: Color purple;
		dashArray: #(15 5).
	v build.
	^ v canvas

]

{ #category : #examples }
HVisualizationExamples >> example13Styles [

	<script: 'self new example13Styles open'>
	| node1 node2 subnode1 subnode2 rootNode subnode3 subnode4 |
	node1 := HNode named: 'Node1'.
	subnode3 := HNode named: 'Sub1-1'.
	subnode4 := HNode named: 'Sub1-2'.

	node1 addAll: { 
			subnode3.
			subnode4 }.

	node2 := HNode new
		         name: 'Node2';
		         style:( HBorderAndTitleStyle new borderWidth: 5; yourself);
		         yourself.
	subnode1 := HNode named: 'Sub2-1'.
	subnode2 := HNode named: 'Sub2-2'.
	node2 addAll: { 
			subnode1.
			subnode2 }.

	node1 children , node2 children do: [ :child | 
		child color: Color blue translucent ].
	rootNode := HNode named: 'Root'.
	rootNode addAll: { 
			node1.
			node2 }.
	subnode3 dependenciesToNodes: { 
			subnode1.
			subnode2 }.

	^ rootNode
]
