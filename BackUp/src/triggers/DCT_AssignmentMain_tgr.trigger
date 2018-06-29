trigger DCT_AssignmentMain_tgr on DCTAssignment__c (before update, after update) {
	if(Trigger.isBefore){
		if(Trigger.isUpdate){
			//Ve si no capturo nada en el campo segemento
			/*if (Trigger.newMap.get(Trigger.new.get(0).id).Segment__c == null && Trigger.newMap.get(Trigger.new.get(0).id).Status__c == 'Aprobado'
				&& Trigger.newMap.get(Trigger.new.get(0).id).TypeAssignment__c == 'Gerencia')
				Trigger.newMap.get(Trigger.new.get(0).id).Segment__c.addError('Debes de capturar el segmento cuando se trata de una Gerencia.');
			else*/
				DCT_AssignmentMethods_cls.performAssigmentIfApplies(Trigger.oldMap, Trigger.newMap);
		}
	}
	
	
	if (Trigger.isAfter){
		if(Trigger.isUpdate){
			//Recorre la lista de Trigger.new
			for (DCTAssignment__c objAsig : Trigger.new){
				System.debug('EN DCT_AssignmentMain_tgr...' + Trigger.oldMap.get(objAsig.id).DCTProccesAprobed__c + ' ' + Trigger.newMap.get(objAsig.id).DCTProccesAprobed__c);
				if (objAsig.DCTProccesAprobed__c != null && Trigger.oldMap.get(objAsig.id).DCTProccesAprobed__c
					!= Trigger.newMap.get(objAsig.id).DCTProccesAprobed__c)
					DCT_AssignmentMethods_cls.actCtasAproRech(objAsig.id, objAsig.DCTProccesAprobed__c);
			}
		}		
	}
	
}