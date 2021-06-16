"
TODO
"
Class {
	#name : #SPHierarchical,
	#superclass : #SpPresenter,
	#instVars : [
		'space',
		'spaceView',
		'menuBar'
	],
	#category : #'Hierarchical-Roassal3'
}

{ #category : #accessing }
SPHierarchical class >> defaultExtent [
	^ 1000@800
]

{ #category : #specs }
SPHierarchical class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #menuBar expand: false;
		
		add: #spaceView;
		yourself
]

{ #category : #accessing }
SPHierarchical class >> defaultTitle [
	^ 'Hierarchical Visualization'
]

{ #category : #accessing }
SPHierarchical >> hspace: aHSpace [ 
	space := aHSpace
]

{ #category : #initialization }
SPHierarchical >> initializePresenters [
	super initializePresenters.
	menuBar := self mainMenu.
	spaceView := SpRoassalPresenter new.
	spaceView script: [ :canvas | 
		HVisualizationBuilder new
			container: canvas;
			hspace: space;
			build. ]
]

{ #category : #initialization }
SPHierarchical >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent.
]

{ #category : #initialization }
SPHierarchical >> mainMenu [
	| aMenu |
	aMenu := self newMenuBar
		addGroup: [ :group |  
			group
				addItem: [:item| 
					item
						name: 'Packages';
						icon: (self iconNamed: #openIcon);
						action: [] ] ].
	^ aMenu
				
]
