Class {
	#name : 'ToThemeColorRow',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'swatch',
		'hexInput',
		'colorName',
		'onChange',
		'silent',
		'onSelect'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'form' }
ToThemeColorRow class >> isValidHex: aString [
	^ aString notNil and: [ aString size = 7 and: [ aString first = $# and: [ aString allButFirst allSatisfy: [ :c | c isHexDigit ] ] ] ]
]

{ #category : 'form' }
ToThemeColorRow class >> swatchFormFor: aHex [
	| form |
	form := Form extent: 22 @ 22 depth: 32.
	form fillColor: ((Color fromHexString: aHex) ifNil: [ Color gray ]).
	^ form
]

{ #category : 'accessing' }
ToThemeColorRow >> colorName [
	^ colorName
]

{ #category : 'accessing' }
ToThemeColorRow >> colorName: aName hex: aHex [
	colorName := aName.
	label label: aName asString.
	self showHex: aHex
]

{ #category : 'initialization' }
ToThemeColorRow >> defaultLayout [
	^ SpBoxLayout newLeftToRight
		  spacing: 8;
		  add: swatch expand: false;
		  add: label;
		  add: hexInput withConstraints: [ :c | c width: 74 ];
		  yourself
]

{ #category : 'accessing' }
ToThemeColorRow >> hexEdited: aString [
	(silent or: [ (self class isValidHex: aString) not ]) ifTrue: [ ^ self ].
	swatch image: (self class swatchFormFor: aString).
	onChange ifNotNil: [ :b | b value: colorName value: aString asLowercase ]
]

{ #category : 'initialization' }
ToThemeColorRow >> initializePresenters [
	silent := false.
	label := self newLabel.
	swatch := self newImage action: [ self select ]; yourself.
	hexInput := self newTextInput.
	hexInput whenTextChangedDo: [ :t | self hexEdited: t ]
]

{ #category : 'accessing' }
ToThemeColorRow >> select [
	onSelect ifNotNil: [ :b | b value: colorName ]
]

{ #category : 'accessing' }
ToThemeColorRow >> showHex: aHex [
	silent := true.
	hexInput text: aHex.
	swatch image: (self class swatchFormFor: aHex).
	silent := false
]

{ #category : 'accessing' }
ToThemeColorRow >> whenChangedDo: aBlock [
	"aBlock takes the color name and the new hex string"
	onChange := aBlock
]

{ #category : 'accessing' }
ToThemeColorRow >> whenSelectedDo: aBlock [
	onSelect := aBlock
]
