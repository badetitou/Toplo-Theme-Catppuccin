Class {
	#name : 'ToThemeBlColorPicker',
	#superclass : 'BlColorPicker',
	#instVars : [
		'onColorChanged'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'accessing' }
ToThemeBlColorPicker >> updateColor [
	super updateColor.
	onColorChanged ifNotNil: [ :b | b value: color ]
]

{ #category : 'accessing' }
ToThemeBlColorPicker >> whenColorChangedDo: aBlock [
	onColorChanged := aBlock
]
