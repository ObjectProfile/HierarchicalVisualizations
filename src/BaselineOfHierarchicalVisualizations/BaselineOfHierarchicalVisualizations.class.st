"
Baseline of hierarchical project https://github.com/ObjectProfile/HierarchicalVisualizations
"
Class {
	#name : #BaselineOfHierarchicalVisualizations,
	#superclass : #BaselineOf,
	#category : #BaselineOfHierarchicalVisualizations
}

{ #category : #baselines }
BaselineOfHierarchicalVisualizations >> baseline: spec [

	<baseline>
	spec for: #common do: [ | hasCanvas | "Packages"
		hasCanvas := Smalltalk globals includesKey: #RSCanvas.
		spec
			package: 'Hierarchical-Model-Events';
			package: 'Hierarchical-Model';
			package: 'Hierarchical-Model-Tests';
			package: 'Hierarchical-Builder';
			package: 'Hierarchical-Roassal3';
			package: 'Hierarchical-Roassal3-Menu';
			package: 'Hierarchical-Examples';
			package: 'Hierarchical-Roassal3-Tests'.
		hasCanvas ifFalse: [ 
			spec
				baseline: 'Roassal3'
				with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
			spec
				package: 'Hierarchical-Model'
				with: [ spec requires: 'Roassal3' ] ].

		"Groups"
		spec
			group: 'Core'
			with: #( 'Hierarchical-Model-Events' 'Hierarchical-Model'
				   'Hierarchical-Model-Tests' 'Hierarchical-Builder' );
			group: 'default'
			with:
				#( 'Core' 'Hierarchical-Roassal3' 'Hierarchical-Roassal3-Menu'
				   'Hierarchical-Roassal3-Tests' 'Hierarchical-Examples' ) ]
]
