Class {
	#name : #BaselineOfHierarchical,
	#superclass : #BaselineOf,
	#category : #'BaselineOfHierarchical-Baseline'
}

{ #category : #baselines }
BaselineOfHierarchical >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
		"Packages"
		spec
			package: 'Hierarchical-Model-Events';
			package: 'Hierarchical-Model' with: [ spec requires: 'Roassal3' ];
			package: 'Hierarchical-Model-Tests';
			package: 'Hierarchical-Spec'.

		"Groups"
		spec
			group: 'Core' with: #(
				'Hierarchical-Model-Events'
				'Hierarchical-Model'
				'Hierarchical-Model-Tests');
			group: 'default' with: #(
				'Core'
				'Hierarchical-Spec' ) ]
]
