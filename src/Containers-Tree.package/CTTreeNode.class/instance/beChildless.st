adding/removing
beChildless

	self children do: [ :each | each noParent ].
	self initializeChildren
