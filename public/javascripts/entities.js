function Model(entity){
	this.entity = entity
}
Model.prototype = Base
Part = new Model('parts')

Part.postUpdate = function(response, id){
	$("#part_number_" + id).html(response.part.part.number);
	$("#part_description_" + id).html(response.part.part.description);
	$("#part_weight_" + id).html(response.part.part.weight);
	$("#part_models_" + id).html(response.modelNumbers);
}

