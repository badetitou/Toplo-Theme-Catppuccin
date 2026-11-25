Class {
	#name : 'ToThemeRoleRow',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'swatch',
		'drop',
		'role',
		'onChange',
		'silent'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'initialization' }
ToThemeRoleRow >> defaultLayout [
	^ SpBoxLayout newLeftToRight
		  spacing: 8;
		  add: swatch expand: false;
		  add: label;
		  add: drop withConstraints: [ :c | c width: 120 ];
		  yourself
]

{ #category : 'initialization' }
ToThemeRoleRow >> initializePresenters [
	silent := false.
	label := self newLabel.
	swatch := self newImage.
	drop := self newDropList.
	drop display: [ :n | n asString ]
]

{ #category : 'accessing' }
ToThemeRoleRow >> nameSelected: aName [
	silent ifTrue: [ ^ self ].
	onChange ifNotNil: [ :b | b value: role value: aName ]
]

{ #category : 'accessing' }
ToThemeRoleRow >> role: aRole names: aCollection [
	role := aRole.
	label label: aRole asString.
	silent := true.
	drop items: aCollection.
	silent := false.
	drop whenSelectedItemChangedDo: [ :n | self nameSelected: n ]
]

{ #category : 'accessing' }
ToThemeRoleRow >> show: aColorName hex: aHex [
	silent := true.
	drop selectItem: aColorName.
	swatch image: (ToThemeColorRow swatchFormFor: aHex).
	silent := false
]

{ #category : 'accessing' }
ToThemeRoleRow >> whenChangedDo: aBlock [
	onChange := aBlock
]
