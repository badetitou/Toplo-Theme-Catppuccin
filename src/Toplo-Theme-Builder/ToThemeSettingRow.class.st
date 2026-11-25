Class {
	#name : 'ToThemeSettingRow',
	#superclass : 'SpPresenter',
	#instVars : [
		'setting',
		'label',
		'input',
		'valueLabel',
		'onChange',
		'silent'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'initialization' }
ToThemeSettingRow >> defaultLayout [
	^ SpBoxLayout newLeftToRight
]

{ #category : 'accessing' }
ToThemeSettingRow >> edited: aNumber [
	silent ifTrue: [ ^ self ].
	setting isBounded ifTrue: [ valueLabel label: aNumber printString ].
	onChange ifNotNil: [ :b | b value: setting name value: aNumber ]
]

{ #category : 'initialization' }
ToThemeSettingRow >> initializePresenters [
	silent := false.
	label := self newLabel.
	valueLabel := self newLabel
]

{ #category : 'accessing' }
ToThemeSettingRow >> setting: aSetting [
	setting := aSetting.
	label label: aSetting label.
	aSetting isBounded
		ifTrue: [
			input := self newSlider
				         min: aSetting min;
				         max: aSetting max;
				         value: aSetting min;
				         yourself.
			input whenValueChangedDo: [ :v | self edited: v rounded ].
			self layout: (SpBoxLayout newLeftToRight
					 spacing: 8;
					 add: label withConstraints: [ :c | c width: 110 ];
					 add: input;
					 add: valueLabel withConstraints: [ :c | c width: 34 ];
					 yourself) ]
		ifFalse: [
			input := self newNumberInput.
			input whenNumberChangedDo: [ :v | self edited: v ].
			self layout: (SpBoxLayout newLeftToRight
					 spacing: 8;
					 add: label;
					 add: input withConstraints: [ :c | c width: 90 ];
					 yourself) ]
]

{ #category : 'accessing' }
ToThemeSettingRow >> show: aNumber [
	silent := true.
	setting isBounded
		ifTrue: [ input value: aNumber. valueLabel label: aNumber printString ]
		ifFalse: [ input number: aNumber ].
	silent := false
]

{ #category : 'accessing' }
ToThemeSettingRow >> whenChangedDo: aBlock [
	"aBlock takes the setting name and the new value"
	onChange := aBlock
]
