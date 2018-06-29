/***************************************************************************************************************************
   Desarrollado por: Avanxo México                                                                                        
   Autor: Luis Enrique Garcia Sanabria                                                                         
   Email: legarcia@avanxo.com                                                                                  
   Fecha de creación: 01-05-2018                                                                                           
 ***************************************************************************************************************************
   Metadata: DCT_ComercialDirectory_cls                                                                                                               
 ***************************************************************************************************************************
   Descripción: Trigger que crea el historial de cambios para el objeto Directorio comercial.           
                                                                                                                           
 ***************************************************************************************************************************
                                                  Control de versiones                                                     
 ***************************************************************************************************************************
   No.      Fecha                 Autor                    Email                          Descripción                     
 ***************************************************************************************************************************
   1.0   01-05-2018    Luis Enrique Garcia Sanabria   legarcia@avanxo.com   Creacion del trigger DCT_ComercialDirectory_tgr
 ***************************************************************************************************************************/
trigger DCT_ComercialDirectory_tgr on Cliente__c (before update, after update) {

	Boolean blnExecuteTrigger = true;
	String sPerfil = [Select u.Profile.Name, u.ProfileId From User u where u.ProfileId =:UserInfo.getProfileId() And id =: UserInfo.getUserId()].Profile.Name;
   	System.debug('EN DCT_ComercialDirectory_tgr sPerfil: ' + sPerfil);	

	if(Trigger.isBefore){		
		if(Trigger.isUpdate) {
			//Controla la ejecución del trigger en el evento de update para que no se cicle
			if(Trigger.isUpdate )
      			blnExecuteTrigger = !DCT_TriggerExecutionControl_cls.hasAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');
			System.debug('EN DCT_ComercialDirectory_tgr blnExecuteTrigger: ' + blnExecuteTrigger);
			if( blnExecuteTrigger ){
				for (id idPct : Trigger.newMap.KeySet()){
					//Ve si cambio el owner y fue alguin que no es el JEC
					if (Trigger.newMap.get(idPct).OwnerId != Trigger.oldMap.get(idPct).OwnerId && !sPerfil.startsWith('Administrador') )
						Trigger.newMap.get(idPct).OwnerId.AddError('No se puede cambiar el propietario del cliente, si requieres reasignarlo ponte en contacto con tu Gerente o con la Coordinación Administrativa.');
				}
			}//Fin si blnExecuteTrigger
		}//Fin si Trigger.isUpdate
	}
	
	if(Trigger.isAfter){		
		if(Trigger.isUpdate) {
			DCT_ComercialDirectory_cls.HistoricalTracking(Trigger.newMap, Trigger.oldMap);
			//Controla la ejecución del trigger en el evento de update para que no se cicle
			if(Trigger.isUpdate )
      			blnExecuteTrigger = !DCT_TriggerExecutionControl_cls.hasAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');
			System.debug('EN DCT_ComercialDirectory_tgr blnExecuteTrigger: ' + blnExecuteTrigger);
			if( blnExecuteTrigger ){
				DCT_ComercialDirectory_cls.updateReferRAPFolioSAP(Trigger.newMap, Trigger.oldMap);
	      		DCT_ComercialDirectory_cls.SendSecondValidation(Trigger.newMap, Trigger.oldMap);
	      		DCT_ComercialDirectory_cls.ChangeDate(Trigger.newMap, Trigger.oldMap);
			}
		}
	}
	
}