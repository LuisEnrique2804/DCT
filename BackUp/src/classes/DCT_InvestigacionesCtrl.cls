public with sharing class DCT_InvestigacionesCtrl {

    public String VaRtCteCautivo = Schema.SObjectType.Cliente__c.getRecordTypeInfosByName().get('Cliente Cautivo').getRecordTypeId();
	public String sRtPlan = Schema.SObjectType.DCTAuthorizedLines__c.getRecordTypeInfosByName().get('Plan').getRecordTypeId();
    public String sRecdType = Schema.SObjectType.DCTAuthorizedLines__c.getRecordTypeInfosByName().get('Lineas Autorizadas').getRecordTypeId();
    				    
	public static string sIdUserActual = UserInfo.getUserId();
	public string sIdUserActualPerfil {get;set;}
	
	public Cliente__c DatosDirComercial {get;set;}	
	public Cliente__c DatosDirComercialUps {get;set;}	
	public String sIdCliente {get;set;}
	public Boolean bMsgFinalError {get;set;}
	public Boolean bMsgFinalSuccess {get;set;}	
	public String sMsgFinal {get;set;}
	public String sIdInvestigacion {get;set;}
	public Boolean bPedirAutorizacion {get;set;}	

    public List<SelectOption> slTipoInvest {get;set;} 
    public String sTipoInvest {get;set;}    
    public Map<String, String> mapTipoInvest {get;set;}

    public List<SelectOption> slTipoAutor {get;set;} 
    public String sTipoAutor {get;set;}    
    public Map<String, String> mapTipoAutor {get;set;}
    
    public String sCommInvestiga {get;set;}    
	public Boolean bNuevaLinea {get;set;}
	public DCTAuthorizedLines__c dctNuevaLinea {get;set;}
	
    public List<SelectOption> slPlanesDirCom {get;set;} 
    public String sPlanesDirCom {get;set;}
	public List<DCTAuthorizedLines__c> lPlanes {get;set;} 
	public Map<String, String> mapPlanesPlazo {get;set;}
	public Map<String, String> mapPlanesNombre {get;set;}
	public Map<String, DCTAuthorizedLines__c> mapLineas {get;set;}	
	
	public String sIdOwnerId {get;set;}	
	public String sPlazo {get;set;}
	public String sSolicitadasPor {get;set;}
	public String sAutirizadasPor {get;set;}
	public String sUsuarioUniversal {get;set;}		 
	public List<String> lErrorres {get;set;}
	public String sExitoIns {get;set;}
	public Boolean bExitoIns {get;set;}
	public List<DCTAuthorizedLines__c> lDCTAuthorizedLines {get;set;}
	
    public DCT_InvestigacionesCtrl(ApexPages.StandardController stdCtr){
       	
		sIdCliente = stdCtr.getId();
		
		DatosDirComercial = new Cliente__c();
		DatosDirComercialUps = new Cliente__c(id = sIdCliente);
		
		mapTipoInvest = new Map<String, String>();
		slTipoInvest = new List<SelectOption>();
      
		slTipoAutor = new List<SelectOption>();
		mapTipoAutor = new Map<String, String>();
		
		slTipoInvest.add(new SelectOption('','   --Ninguno--   '));
		Schema.DescribeFieldResult fieldResultTI = Cliente__c.DCTInvestigation__c.getDescribe();
        List<Schema.PicklistEntry> pleTI = fieldResultTI.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : pleTI){
			slTipoInvest.add(new SelectOption(pickListVal.getValue(),pickListVal.getValue()));
        }  

		slTipoAutor.add(new SelectOption('','   --Ninguno--   '));
		Schema.DescribeFieldResult fieldResultTA = Cliente__c.DCTTypeAuthorization__c.getDescribe();
        List<Schema.PicklistEntry> pleTA = fieldResultTA.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : pleTA){
			slTipoAutor.add(new SelectOption(pickListVal.getValue(),pickListVal.getValue()));
        }  
      
        bMsgFinalError = false;
	    bMsgFinalSuccess = false;
        sMsgFinal = '';
      	sSolicitadasPor = '';
      	sUsuarioUniversal = '';
      	sIdOwnerId = '';

		bNuevaLinea = false;
    	slPlanesDirCom = new List<SelectOption>(); 
		lPlanes = new List<DCTAuthorizedLines__c>();
		lDCTAuthorizedLines = new List<DCTAuthorizedLines__c>();
		mapPlanesPlazo = new Map<String, String>();
		mapPlanesNombre = new Map<String, String>();
		mapLineas = new Map<String, DCTAuthorizedLines__c>();
		sPlazo = '';
		lErrorres = new List<String>();
		sExitoIns = '';
		bExitoIns = false;
      	
		//Obten los datos del cliente
		for (Cliente__c objCliente : [Select Id, Name, DCTInvestigation__c, DCTCommentsInvestigation__c,
      		DCTAskAuthorization__c, DCTTypeAuthorization__c, DCTReasonRejection__c, DCTAuthorizationDateVoBoManagement__c,
	      	DCTResearchLegend__c, DCTResultVerification__c, DCTTotalAuthorizedLines__c, DCTTotLineasAutorInvest__c,
	      	RecordTypeId, OwnerId, DCTStatus__c
    	  	From Cliente__c Where id =: sIdCliente]){
      		DatosDirComercial = objCliente;
      		sIdInvestigacion = objCliente.DCTInvestigation__c;
      		bPedirAutorizacion = objCliente.DCTAskAuthorization__c;
      		sTipoInvest = objCliente.DCTInvestigation__c;
      		sTipoAutor = objCliente.DCTTypeAuthorization__c;
      		sIdOwnerId = objCliente.OwnerId;
		}

		//Datos del dueño del registro
		for (User usrDatos : [Select u.UserRole.Name, u.UserRoleId, u.Profile.Name, u.ProfileId, ManagerId,
			Manager.Name, Name, DCTXO__c
			From User u where id =: sIdOwnerId]){
      		sSolicitadasPor = usrDatos.Name;
      		sAutirizadasPor = usrDatos.ManagerId != null ? usrDatos.Manager.Name : '';
      		sUsuarioUniversal = usrDatos.DCTXO__c;
		}
		
		//Datos del usuario que esta entrando
		for (User usrDatos : [Select u.UserRole.Name, u.UserRoleId, u.Profile.Name, u.ProfileId, ManagerId,
			Manager.Name, Name, DCTXO__c
			From User u where id =: UserInfo.getUserId()]){				
			sIdUserActualPerfil = usrDatos.Profile.Name != null ? usrDatos.Profile.Name : '';
		}
		
        //Consulta las lienas dadas de alta
        for (DCTAuthorizedLines__c linea : [Select id, Name, Clave__c, DCTPlanType__c, 
        	DCTLineType__c, DCTTerm__c, DCTActiveLines__c, DCTAuthorizedLines__c
        	From DCTAuthorizedLines__c 	Where CommercialDirectory__c = :sIdCliente 
        	And Plan__c = null And RecordTypeId = :sRecdType]){
       		lDCTAuthorizedLines.add(linea);
        }

    	System.debug('EN DCT_InvestigacionesCtrl sRecdType: ' + sRecdType + ' sIdCliente: ' + sIdCliente);		
    }

    public PageReference NuevaLinea() {
    	System.debug('EN DCT_InvestigacionesCtrl.NuevaLinea bNuevaLinea: ' + bNuevaLinea);    	
        bNuevaLinea = true;
        dctNuevaLinea = new DCTAuthorizedLines__c();
 		dctNuevaLinea.CommercialDirectory__c = sIdCliente;
 		dctNuevaLinea.RecordTypeId = sRecdType;
    	System.debug('EN DCT_InvestigacionesCtrl.NuevaLinea dctNuevaLinea: ' + dctNuevaLinea);
 		
        slPlanesDirCom.add(new SelectOption('' , '--Ninguno--'));
        //Consulta los planeas asocados a este dir comercial
        for (DCTAuthorizedLines__c plan : [Select id, Name, Clave__c, DCTPlanType__c, DCTTerm__c, DCTLineType__c
        	From DCTAuthorizedLines__c 	Where CommercialDirectory__c = :sIdCliente 
        	And Plan__c != null And RecordTypeId = :sRtPlan]){
        	slPlanesDirCom.add( new SelectOption( plan.Clave__c, plan.Name + ' ' + plan.DCTTerm__c));
        	mapPlanesPlazo.put(plan.Clave__c, plan.DCTTerm__c);
        	mapPlanesNombre.put(plan.Clave__c, plan.Name);
        	mapLineas.put(plan.Clave__c, plan);
        }
                
    	//Regresa solo null
    	return null;
    }

    public PageReference Cancelar() {
    	System.debug('EN DCT_InvestigacionesCtrl.Cancelar bNuevaLinea: ' + bNuevaLinea);
        bNuevaLinea = false;
		bNuevaLinea = false;
    	slPlanesDirCom = new List<SelectOption>(); 
		lPlanes = new List<DCTAuthorizedLines__c>();
		mapPlanesPlazo = new Map<String, String>();
		sPlazo = '';
		sPlanesDirCom = null;
		lErrorres = new List<String>();
       	sExitoIns = '';
       	bExitoIns = false;
    	//Regresa solo null
    	return null;
    }

    public PageReference actualizaPlazo() {
    	System.debug('EN DCT_InvestigacionesCtrl.actualizaPlazo sPlanesDirCom: ' + sPlanesDirCom);
    	
		sPlazo = ''; 
		//Ve si tiene algo la variable sPlanesDirCom
		if (sPlanesDirCom != null){
			sPlazo = mapPlanesPlazo.get(sPlanesDirCom);
			if (sPlazo.indexOf(' ') >= 0)
				dctNuevaLinea.DCTTerm__c = sPlazo.substring(0, sPlazo.indexOf(' '));
			dctNuevaLinea.Name = mapPlanesNombre.get(sPlanesDirCom);
			dctNuevaLinea.Clave__c = mapLineas.get(sPlanesDirCom).Clave__c;
			dctNuevaLinea.DCTPlanType__c = mapLineas.get(sPlanesDirCom).DCTPlanType__c;
			dctNuevaLinea.DCTLineType__c = mapLineas.get(sPlanesDirCom).DCTLineType__c;
			dctNuevaLinea.DCTTerm__c = mapLineas.get(sPlanesDirCom).DCTTerm__c;
		}//Fin si sPlanesDirCom != null
    	System.debug('EN DCT_InvestigacionesCtrl.actualizaPlazo dctNuevaLinea.DCTTerm__c: ' + dctNuevaLinea.DCTTerm__c);		
    	
    	//Regresa solo null
    	return null;
    }

    public PageReference GuardarNuavLinea() {
    	System.debug('EN DCT_InvestigacionesCtrl.GuardarNuavLinea sPlanesDirCom: ' + sPlanesDirCom);

		//Ve si capturo los datos necesarios
		if  (ValidaDatosLinea()){
			try{
				//Crea el reg
		        Database.SaveResult sr = Database.insert(dctNuevaLinea, true);
		        //No hubo error
		        if(sr.isSuccess()){
					/*//Ve si el plan es de 12 meses entonces genera un proceso de aprobación
		            if(dctNuevaLinea.DCTTerm__c == '12'){ 
		                System.debug(loggingLevel.Error, '*** Paso2: ');
    					System.debug('EN DCT_InvestigacionesCtrl.GuardarNuavLinea antes de crear el proceso...');		                
		                Approval.ProcessSubmitRequest procSubmReq = new Approval.ProcessSubmitRequest();
		                procSubmReq.setComments('Favor de Aprobar el Plan');
		                procSubmReq.setObjectId(sr.getId());
		                procSubmReq.setProcessDefinitionNameOrId('DCT_Planes_a_12_Meses');
		                procSubmReq.setSkipEntryCriteria(true);
		                try{Approval.process(procSubmReq,true);
		                }catch(Exception gE){lErrorres.add(gE.getMessage());}       
		            }//Fin si sPlazo.startsWith('12')*/
		        	sExitoIns = 'La línea se guardo con éxito.';
		        	bExitoIns = true;
		        	bNuevaLinea = false;
    				System.debug('EN DCT_InvestigacionesCtrl.GuardarNuavLinea sr.getId(): ' + sr.getId());

					lDCTAuthorizedLines = new List<DCTAuthorizedLines__c>();
			        //Consulta las lienas dadas de alta
			        for (DCTAuthorizedLines__c linea : [Select id, Name, Clave__c, DCTPlanType__c, 
			        	DCTLineType__c, DCTTerm__c, DCTActiveLines__c, DCTAuthorizedLines__c
			        	From DCTAuthorizedLines__c 	Where CommercialDirectory__c = :sIdCliente 
			        	And Plan__c = null And RecordTypeId = :sRecdType]){
			       		lDCTAuthorizedLines.add(linea);
			        }
    				
		        }//Fin si no hubo error
		        //Hubo error
		        if(!sr.isSuccess())
					lErrorres.add(sr.getErrors().get(0).getMessage());
			}catch(Exception ex){
				lErrorres.add(ex.getMessage());				
			}
		}//Fin si ValidaDatosLinea()
		    			        
    	//Regresa solo null
    	return null;
    }

	public Boolean ValidaDatosLinea(){
		System.debug('ENTRO A ValidaDatosEntrada...');
		Boolean bErrorPaso = false;
		lErrorres = new List<String>();
		
		//Ve si faltan datos de capturar
		if (dctNuevaLinea.DCTActiveLines__c == null)		
			lErrorres.add('Te falta capturar el número de líneas activas.');
		if (dctNuevaLinea.DCTActiveLines__c == 0)
			lErrorres.add('Te falta capturar el número de líneas activas.');
		if (dctNuevaLinea.DCTAuthorizedLines__c == null)		
			lErrorres.add('Te falta capturar número de líneas autorizadas.');
		if (dctNuevaLinea.DCTAuthorizedLines__c == 0)		
			lErrorres.add('Te falta capturar número de líneas autorizadas.');
		if (sPlanesDirCom == null)
			lErrorres.add('Te falta seleccionar el Plan.');
		
		//Ahy errores
		if (!lErrorres.isEmpty())
			bErrorPaso = true;
			
		//Regresa el valor de 
		return !bErrorPaso;
	}
	    
    public PageReference LoadActualizaImvestigacionesWs() {
    	System.debug('EN DCT_InvestigacionesCtrl.ActualizaFuerzaVetaWs DatosDirComercial.RecordTypeId: ' + DatosDirComercial.RecordTypeId + ' VaRtCteCautivo: ' + VaRtCteCautivo + ' sIdCliente: ' + sIdCliente);
        bMsgFinalError = false;
        
		//Consulta los datos del cluiente si esta vacio el recordtype
		if (DatosDirComercial.RecordTypeId == null){
      		DatosDirComercial = new Cliente__c();			
			for (Cliente__c objCliente : [Select Id, Name, DCTInvestigation__c, DCTCommentsInvestigation__c,
	      		DCTAskAuthorization__c, DCTTypeAuthorization__c, DCTReasonRejection__c, DCTAuthorizationDateVoBoManagement__c,
		      	DCTResearchLegend__c, DCTResultVerification__c, DCTTotalAuthorizedLines__c, DCTTotLineasAutorInvest__c,
		      	RecordTypeId
	    	  	From Cliente__c Where id =: sIdCliente]){
	      		DatosDirComercial = objCliente;
	      		sIdInvestigacion = objCliente.DCTInvestigation__c;
	      		bPedirAutorizacion = objCliente.DCTAskAuthorization__c;
	      		sTipoInvest = objCliente.DCTInvestigation__c;
    	  		sTipoAutor = objCliente.DCTTypeAuthorization__c;
			}			
		}//Fin si DatosDirComercial.RecordTypeId == null

	    if (sIdUserActualPerfil.startsWith('Coordinacion') && DatosDirComercial.RecordTypeId == VaRtCteCautivo)
			ActualizaImvestigacionesWs();
		else{	    
			//Ve si ya selecciono algo en los campos		    	
	    	if (DatosDirComercial.RecordTypeId == VaRtCteCautivo && sIdInvestigacion != sTipoInvest){
		    	ActualizaImvestigacionesWs();
		    	bMsgFinalSuccess = false;
	    	}//Fin si DatosDirComercial.RecordTypeId == VaRtCteCautivo && sIdInvestigacion != sTipoInvest
	    	
	    	//Si cabio el valor de la aprovación
	    	if (DatosDirComercial.RecordTypeId == VaRtCteCautivo && sIdInvestigacion == sTipoInvest
	    		&& bPedirAutorizacion != DatosDirComercial.DCTAskAuthorization__c && DatosDirComercial.DCTAskAuthorization__c){
	    		Cliente__c objCliente = new Cliente__c(id = DatosDirComercial.id, DCTAskAuthorization__c = DatosDirComercial.DCTAskAuthorization__c );
				update objCliente;
				bMsgFinalSuccess = true;
	    	}//Fin si DatosDirComercial.RecordTypeId == VaRtCteCautivo && sIdInvestigacion != DatosDirComercial.DCTInvestigation__c
		}
		
    	//Regresa solo null
    	return null;
    	
    }

	//Funcion que se manda llamar cuando se carga la pagina del PCT para actualizar la fuerza de venta
    public PageReference ActualizaImvestigacionesWs() {
    	System.debug('EN DCT_InvestigacionesCtrl.ActualizaFuerzaVetaWs DatosDirComercial: ' + DatosDirComercial);
    	
    	sMsgFinal = '';
   		Set<String> setIdUptResp = new Set<String>();
		Boolean bValidaDatosOK = false;
		String sCommInvestigaPaso = '';
		
		//Valida los datos del servicio
	    if (DatosDirComercial.Name == null || DatosDirComercial.Name == '')		
	    	sMsgFinal += 'Debes capturar un valor en el campo de Nombre. ';
	    if (sTipoInvest == null || sTipoInvest == '')
	    	sMsgFinal += 'Debes capturar un valor en el campo de Investigación. ';
	    if (sTipoAutor == null || sTipoAutor == '')
	    	sMsgFinal += 'Debes capturar un valor en el campo de Tipo de Autorización. ';
    	System.debug('EN DCT_InvestigacionesCtrl.ActualizaFuerzaVetaWs sMsgFinal: ' + sMsgFinal);
    		    
	    //Ve tiene algun error 
	    if (sMsgFinal == null || sMsgFinal == ''){	
	    	//Concatena en sCommInvestiga la parte del tipo de Autorización
	    	sCommInvestigaPaso = sTipoAutor + ' ' + sCommInvestiga;
	    	System.debug('EN DCT_InvestigacionesCtrl.ActualizaFuerzaVetaWs sCommInvestigaPaso: ' + sCommInvestigaPaso);
	    	
			//Por aqui mandamos llamar el WebService de directorioEmpleados/ConsultarEmpleado/			
		    DCT_Investigaciones_ws.ResponseWrapper objClsInvest = DCT_Investigaciones_ws.Investigaciones(DatosDirComercial.Name, 
		    	sTipoInvest, sCommInvestigaPaso); 
		    //Ve si no hubo error a la hora de responder del servicio
		    if (objClsInvest.EstatusConsulta == 0 || objClsInvest.EstatusConsulta == 2){
		    	//Ve si tiene algo la lista de objClsInvest.DirectorioEmpleados
		    	if (objClsInvest.Estado != null && objClsInvest.Leyenda != null){
				    if (objClsInvest.EstatusConsulta == 2){
			    		objClsInvest.Leyenda = 'Sin respuesta';
			    		objClsInvest.Estado = 'Sin respuesta';
				    }//Fin si objClsInvest.EstatusConsulta == 2		    			    		
		    		//Tama los datos que capturaste en la pantalla y actualiza el reg de 
		    		DatosDirComercialUps.DCTResearchLegend__c = objClsInvest.Leyenda;
		    		DatosDirComercialUps.DCTResultVerification__c = objClsInvest.Estado;
		    	}//Fin si objClsInvest.DirectorioEmpleados != null
		    	DatosDirComercialUps.DCTAskAuthorization__c = DatosDirComercial.DCTAskAuthorization__c;
	    		DatosDirComercialUps.DCTReasonRejection__c = DatosDirComercial.DCTReasonRejection__c;		    	
		    	DatosDirComercialUps.DCTAuthorizationDateVoBoManagement__c = DatosDirComercial.DCTAuthorizationDateVoBoManagement__c;

		    	DatosDirComercialUps.DCTInvestigation__c = sTipoInvest; //DatosDirComercial.DCTInvestigation__c;		    	
		    	DatosDirComercialUps.DCTTypeAuthorization__c = sTipoAutor; //DatosDirComercial.DCTTypeAuthorization__c;		    	
		    	//DatosDirComercialUps.DCTCommentsInvestigation__c = DatosDirComercial.DCTCommentsInvestigation__c;
		    			    	
				System.debug('EN DCT_InvestigacionesCtrl.ActualizaImvestigacionesWs el DatosDirComercialUps: ' + DatosDirComercialUps);
				//Ve si los datos de DatosDirComercial son diferentes a los de la respuesta del web service
				//if ( (DatosDirComercial.DCTResearchLegend__c != objClsInvest.Leyenda 
				//	|| DatosDirComercialUps.DCTResultVerification__c != objClsInvest.Estado) 
				//	|| (DatosDirComercial.DCTResearchLegend__c == null && DatosDirComercialUps.DCTResultVerification__c == null)){
						
			    	//Actualiza el reg y actualiza la pagina
					Database.Saveresult Dtupr = Database.update(DatosDirComercialUps, false);
					//No hubo error
		   			if (Dtupr.isSuccess()){
		   				sMsgFinal = 'Los datos se actualizaron con éxito.';   				
		   				System.debug('EN DCT_InvestigacionesCtrl.ActualizaImvestigacionesWs el ID: ' + Dtupr.getId());
						bMsgFinalSuccess = true;   				
						DatosDirComercial = DatosDirComercialUps;
						sTipoInvest = null;
						sTipoAutor = null;
						sCommInvestiga = null;
		   			}//Fin si Dtupr.isSuccess()
		   			//Hubo error
		   			if (!Dtupr.isSuccess()){
		   				sMsgFinal = Dtupr.getErrors()[0].getMessage();
						bMsgFinalError = true;   				
		   				System.debug('EN DCT_InvestigacionesCtrl.ActualizaImvestigacionesWs ERROR aL ACTUALIZAR: ' + Dtupr.getErrors()[0].getMessage());
		   			}//Fin si !Dtupr.isSuccess()
				    if (objClsInvest.EstatusConsulta == 2){
						bMsgFinalError = true;
						sMsgFinal = objClsInvest.Descripcion;
				    }//Fin si objClsInvest.EstatusConsulta == 2
				    
				//}//Fin si DatosDirComercial.DCTResearchLegend__c != objClsInvest.Leyenda || DatosDirComercialUps.DCTResultVerification__c != objClsInvest.Estado
				
		    }//Fin si objClsInvest.ErrorID == NULL    	

			//Si hay error
		    if (objClsInvest.EstatusConsulta != 0 && objClsInvest.EstatusConsulta != 2){
				bMsgFinalError = true;
				if (objClsInvest.Message == null && objClsInvest.ExceptionMessage == null)
					sMsgFinal = 'Time Out';				
				else	
					sMsgFinal = objClsInvest.Message + ' ' + objClsInvest.ExceptionMessage;
		    }//Fin si objClsInvest.EstatusConsulta != 0 && objClsInvest.EstatusConsulta != 2
		    
	    }else if (sMsgFinal != null && sMsgFinal != '' && sIdUserActualPerfil.startsWith('Coordinacion'))
	    	bMsgFinalError = true;	    
			//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, sMsgFinal));	    	
			
	    
		//Regresa solo null
        return null;
    }

	//Funcion que se manda llamar cuando se carga la pagina del PCT para actualizar la fuerza de venta
    public PageReference fullRefresh() {
		PageReference pr = new ApexPages.StandardController(DatosDirComercial).view();  
		pr.setRedirect(true);
		return pr;
    }

}