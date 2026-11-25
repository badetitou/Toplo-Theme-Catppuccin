Class {
	#name : 'ToThemeSetting',
	#superclass : 'Object',
	#instVars : [
		'name',
		'min',
		'max'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'instance creation' }
ToThemeSetting class >> name: aName [
	^ self new name: aName; yourself
]

{ #category : 'instance creation' }
ToThemeSetting class >> name: aName min: aMin max: aMax [
	^ self new name: aName; min: aMin; max: aMax; yourself
]

{ #category : 'accessing' }
ToThemeSetting >> isBounded [
	"A bounded setting is edited with a slider, an unbounded one with a number input."
	^ min notNil and: [ max notNil ]
]

{ #category : 'accessing' }
ToThemeSetting >> label [
	"Token names are shown as they are; camelCase names are split into words."
	(name asString includes: $-) ifTrue: [ ^ name asString ].
	^ String streamContents: [ :s |
		  name asString doWithIndex: [ :c :i |
			  (i > 1 and: [ c isUppercase ]) ifTrue: [ s space ].
			  s nextPut: c asLowercase ] ]
]

{ #category : 'accessing' }
ToThemeSetting >> max [
	^ max
]

{ #category : 'accessing' }
ToThemeSetting >> max: aNumber [
	max := aNumber
]

{ #category : 'accessing' }
ToThemeSetting >> min [
	^ min
]

{ #category : 'accessing' }
ToThemeSetting >> min: aNumber [
	min := aNumber
]

{ #category : 'accessing' }
ToThemeSetting >> name [
	^ name
]

{ #category : 'accessing' }
ToThemeSetting >> name: aSymbol [
	name := aSymbol
]
