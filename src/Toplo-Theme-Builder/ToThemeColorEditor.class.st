Class {
	#name : 'ToThemeColorEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'title',
		'swatch',
		'picker',
		'pickerHolder',
		'hexInput',
		'colorName',
		'onChange',
		'silent',
		'lastProgrammatic'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'accessing' }
ToThemeColorEditor >> colorName [
	^ colorName
]

{ #category : 'initialization' }
ToThemeColorEditor >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		  spacing: 6;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 8;
				   add: swatch expand: false;
				   add: title;
				   add: hexInput withConstraints: [ :c | c width: 84 ];
				   yourself)
		  expand: false;
		  add: pickerHolder withConstraints: [ :c | c height: 395 ];
		  yourself
]

{ #category : 'accessing' }
ToThemeColorEditor >> edit: aName hex: aHex [
	colorName := aName.
	title label: 'editing ', aName asString.
	self showHex: aHex
]

{ #category : 'accessing' }
ToThemeColorEditor >> hexTyped: aString [
	(silent or: [ (ToThemeColorRow isValidHex: aString) not ]) ifTrue: [ ^ self ].
	self showHex: aString asLowercase.
	self notify: aString asLowercase
]

{ #category : 'initialization' }
ToThemeColorEditor >> initializePresenters [
	silent := false.
	title := self newLabel.
	swatch := self newImage.
	hexInput := self newTextInput.
	hexInput whenTextChangedDo: [ :t | self hexTyped: t ].
	picker := ToThemeBlColorPicker new.
	picker background: Color transparent.
	picker constraintsDo: [ :c | c padding: (BlInsets all: 4) ].
	picker whenColorChangedDo: [ :color | self pickerMoved: color ].
	pickerHolder := self instantiate: SpBlocPresenter.
	pickerHolder blocElement: picker
]

{ #category : 'accessing' }
ToThemeColorEditor >> notify: aHex [
	colorName ifNil: [ ^ self ].
	onChange ifNotNil: [ :b | b value: colorName value: aHex ]
]

{ #category : 'accessing' }
ToThemeColorEditor >> pickerMoved: aColor [
	| hex |
	(silent or: [ lastProgrammatic notNil and: [ (Time millisecondClockValue - lastProgrammatic) < 400 ] ]) ifTrue: [ ^ self ].
	hex := '#', aColor asHexString asLowercase.
	silent := true.
	hexInput text: hex.
	swatch image: (ToThemeColorRow swatchFormFor: hex).
	silent := false.
	self notify: hex
]

{ #category : 'accessing' }
ToThemeColorEditor >> showHex: aHex [
	| color |
	color := Color fromHexString: aHex.
	lastProgrammatic := Time millisecondClockValue.
	silent := true.
	hexInput text: aHex.
	swatch image: (ToThemeColorRow swatchFormFor: aHex).
	silent := false.
	"the picker positions its cursor from its bounds: wait until it is laid out"
	picker enqueueTask: (BlTaskAction new action: [
		lastProgrammatic := Time millisecondClockValue.
		silent := true.
		picker setColor: color.
		silent := false ])
]

{ #category : 'accessing' }
ToThemeColorEditor >> whenChangedDo: aBlock [
	"aBlock takes the color name and the new hex string"
	onChange := aBlock
]
