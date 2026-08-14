Class {
	#name : 'ToCatppuccinThemeBuilder',
	#superclass : 'ToThemeBuilder',
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'initialization' }
ToCatppuccinThemeBuilder >> buildEditorColumn [

	propertyList addColumn: (SpColumnViewColumn new
			 title: 'Property Value';
			 setup: [ :aPresenter |
					 aPresenter newPresenter
						 layout: SpBoxLayout newHorizontal;
						 yourself ];
			 bind: [ :aPresenter :property |
					 property value isColor
						 ifTrue: [
								 | dropList |
								 dropList := self buildPaletteDropList.
								 dropList whenSelectedItemChangedDo: [ :item | "there are duplicate... "
										 self model tokenProperties
											 select: [ :pro | pro name = property name ]
											 thenDo: [ :pro | pro value: (self model class colorNamed: item key) ] ].
								 aPresenter layout add: dropList ]
						 ifFalse: [
								 aPresenter layout add: (aPresenter newLabel
										  label: 'test';
										  yourself) ] ];
			 yourself)
]

{ #category : 'initialization' }
ToCatppuccinThemeBuilder >> buildPaletteDropList [

	^ self newDropList
		  items: (self model class palette associations sorted: [ :a :b | a key < b key ]);
		  display: [ :m | m key ];
		  displayIcon: [ :e | ToImage new innerFormImageColor: (Color fromHexString: e value) ];
		  yourself
]
