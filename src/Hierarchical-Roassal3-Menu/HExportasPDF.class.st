"
this menu item allows export to PDF
"
Class {
	#name : #HCollapseCanvasChildrenMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}


{ #category : #execution }
HCollapseCanvasChildrenMenuItem >> execute [
	|destinationDir timestamp|
	timestamp := DateAndTime now asUnixTime asString.
	destinationDir := ('image', timestamp, '.pdf') asFileReference.
	RSPDFCairoExporter new
		canvas: visualization container;
		exportToFile: destinationDir.
	GrowlMorph openWithLabel: 'Information' contents: 'Saved ', destinationDir asAbsolute asString.
]

{ #category : #accessing }
HCollapseCanvasChildrenMenuItem >> label [
	^ 'Export as PDF'
]

{ #category : #accessing }
HCollapseCanvasChildrenMenuItem >> order [
	^ 1
]