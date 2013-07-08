var SortUtility = {
	sort : 'part_number',
	order : 'asc',
	searchParams : {},
	sortSearchResults : function (sort_element){
		var sort_field = $(sort_element).attr('name')
		if(sort_field == this.sort)
			this.order = (this.order == 'asc') ? 'desc' : 'asc'
		else
			this.order = 'asc'
		this.sort = sort_field
		PartPrice.searchEntity(true)
	}
}

$('.sortable').live('click', function(e){
	SortUtility.sortSearchResults(this)
	return false;
})
