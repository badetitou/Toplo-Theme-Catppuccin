Class {
	#name : 'ToCatppuccinThemeSkinTest',
	#superclass : 'ToTestCaseWithSpace',
	#category : 'Toplo-Theme-Catppuccin-Tests-Catppuccin',
	#package : 'Toplo-Theme-Catppuccin-Tests',
	#tag : 'Catppuccin'
}

{ #category : 'asserting' }
ToCatppuccinThemeSkinTest >> assertInsets: anInsets top: top left: left bottom: bottom right: right [

	self assert: anInsets top equals: top.
	self assert: anInsets left equals: left.
	self assert: anInsets bottom equals: bottom.
	self assert: anInsets right equals: right
]

{ #category : 'running' }
ToCatppuccinThemeSkinTest >> setUp [

	super setUp.
	space toTheme: ToCatppuccinLatteTheme new
]

{ #category : 'tests' }
ToCatppuccinThemeSkinTest >> testButtonWithIconUsesCatppuccinMetrics [

	| button |
	button := ToButton new.
	button labelText: 'Hello'.
	button icon: (ToImage inner: ToThemeIcons searchOutlined16x16).
	space root addChild: button.
	space applyAllSkinPhases.
	space root forceLayout.

	self assert: button startInterspace equals: 10.
	self
		assertInsets: button padding
		top: 5
		left: 12
		bottom: 5
		right: 12.
	self assert: button icon extent equals: 16 asPoint
]

{ #category : 'tests' }
ToCatppuccinThemeSkinTest >> testIconicButtonUsesSquareMetrics [

	| button |
	button := ToButton new.
	button icon: (ToImage inner: ToThemeIcons searchOutlined16x16).
	button addStamp: #iconic.
	space root addChild: button.
	space applyAllSkinPhases.
	space root forceLayout.

	self assert: button measuredExtent equals: 32 asPoint.
	self
		assertInsets: button padding
		top: 8
		left: 8
		bottom: 8
		right: 8.
	self assert: button icon extent equals: 16 asPoint
]

{ #category : 'tests' }
ToCatppuccinThemeSkinTest >> testSmallAndLargeButtonsUseDedicatedMetrics [

	| smallButton largeButton |
	smallButton := ToButton new.
	smallButton labelText: 'Small'.
	smallButton icon: (ToImage inner: ToThemeIcons searchOutlined16x16).
	smallButton addStamp: #'small-sizing'.
	space root addChild: smallButton.

	largeButton := ToButton new.
	largeButton labelText: 'Large'.
	largeButton icon: (ToImage inner: ToThemeIcons searchOutlined16x16).
	largeButton addStamp: #'large-sizing'.
	space root addChild: largeButton.

	space applyAllSkinPhases.
	space root forceLayout.

	self
		assertInsets: smallButton padding
		top: 3
		left: 10
		bottom: 3
		right: 10.
	self assert: smallButton icon extent equals: 14 asPoint.
	self
		assertInsets: largeButton padding
		top: 7
		left: 16
		bottom: 7
		right: 16.
	self assert: largeButton icon extent equals: 18 asPoint
]

{ #category : 'tests' }
ToCatppuccinThemeSkinTest >> testStandardIconicButtonUsesCatppuccinMetrics [

	| button |
	button := ToStandardIconicButton new.
	button innerImage: ToThemeIcons searchOutlined16x16.
	space root addChild: button.
	space applyAllSkinPhases.
	space root forceLayout.

	self assert: button measuredExtent equals: 32 asPoint.
	self
		assertInsets: button padding
		top: 8
		left: 8
		bottom: 8
		right: 8
]
