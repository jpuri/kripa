var SortUtility = {
	sort : 'id',
	order : 'asc',
	sortSearchResults : function (entity, sort_field){
		order = this.order
		PartPrice.searchEntity(sort_field, order)
	}	
	
}

$('.sortable').live('click', function(e){
	sort = $(this).attr('name')
	SortUtility.sortSearchResults(PartPrice, sort)
	return false;
})
