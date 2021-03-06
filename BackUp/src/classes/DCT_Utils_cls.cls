public with sharing class DCT_Utils_cls {  
 	
 	public static Map<String, EndpointSetting__mdt> mapEndpointSettingMdt = getEndpointSettingMdt();
 	public static respuestaTelcel objRespRefRap {get;set;}

	public class respuestaTelcel{
		public referenciaWSRap referenciaWSRap {get;set;}
	}
	
	public class referenciaWSRap{
		public Integer idEstatus {get;set;}		
		public String nombreCliente {get;set;}		
		public String referencia {get;set;}
		public String rfc {get;set;}
		public String Message {get;set;}		
		public String MessageDetail {get;set;}
		public String descEstatus {get;set;}
	}
 	 	
 	public class DtRespuestaTelcel{
 		public String access_token {get;set;}
 		public String token_type {get;set;} 		
 		public Integer expires_in {get;set;}
 		public String error {get;set;} 		
		public String error_description {get;set;} 		 		
 	}
    
    //Crea el metodo de Login para Telcel
    public static DtRespuestaTelcel LoginTelcel(){
    	DtRespuestaTelcel objDtRespuestaTelcel = new DtRespuestaTelcel();
    	    	
    	//Toma los datos para los parametros de la conexion a Telcel del mapa de mapEndpointSettingMdt
    	EndpointSetting__mdt objEndpointSettingMdt = mapEndpointSettingMdt.get('Login');
		
		try{
    	
			//Una prueba utilzando HTTP 
			HttpRequest request = new HttpRequest();
			request.setMethod(objEndpointSettingMdt.ServiceMethod__c); //'POST'
			request.setHeader('Content-Type', objEndpointSettingMdt.RequestBodyType__c); //'application/x-www-form-urlencoded' 
			request.setHeader('Host', objEndpointSettingMdt.ServiceProvider__c);
			request.setHeader('Cache-Control', 'no-cache');  			
			request.setEndpoint(objEndpointSettingMdt.Endpoint__c);					
			request.setTimeout(Integer.valueOf(objEndpointSettingMdt.Timeout__c));
						
			//JSONBody = EncodingUtil.urlEncode(JSONBody, 'UTF-8');
			String JSONBody = 'grant_type=' + objEndpointSettingMdt.grant_type__c + '&client_id=' + objEndpointSettingMdt.client_id__c + '&client_secret=' + objEndpointSettingMdt.client_secret__c;
			//Incializa el Body con JSONBody						
			request.setBody(JSONBody);
										
			HTTPResponse res;
			res = new Http().send(request);
			String sJasonRes = res.getBody();
			System.debug('EN Login HTTP: ' + res + ' sJasonRes: ' + sJasonRes);

			if (String.valueOf(res).contains('200') ){
				//Seriarliza la respuesta del servicio
				DtRespuestaTelcel objDtRespuestaTelcelPaso = JSONParserRespTelcel(String.valueOf(sJasonRes));			
				objDtRespuestaTelcel.access_token = objDtRespuestaTelcelPaso.access_token;
				objDtRespuestaTelcel.token_type = objDtRespuestaTelcelPaso.token_type;
				objDtRespuestaTelcel.expires_in = objDtRespuestaTelcelPaso.expires_in;
				objDtRespuestaTelcel.error = objDtRespuestaTelcelPaso.error;
				objDtRespuestaTelcel.error_description = objDtRespuestaTelcelPaso.error_description;			
			}
			//Ve si el campo JsonRes tiene algo
			if (String.valueOf(res).contains('400') || String.valueOf(res).contains('404') || String.valueOf(res).contains('405') || String.valueOf(res).contains('500') ){
				objDtRespuestaTelcel.error = 'Error a la hora de llamar el servicio de Login';
				objDtRespuestaTelcel.error_description = String.valueOf(sJasonRes);
			}//Fin si sJasonRes != null && sJasonRes.length() == 0			

		}catch(Exception ex){
			objDtRespuestaTelcel.error = 'Error a la hora de llamar el servicio de Login';
			objDtRespuestaTelcel.error_description = ex.getMessage();
		}
		
		//Regresa el objeto de objDtRespuestaTelcel     	
    	return objDtRespuestaTelcel;
    } 
 
 
 	public static Map<String, EndpointSetting__mdt> getEndpointSettingMdt(){
 		Map<String, EndpointSetting__mdt> mapEndpointSettingMdtPaso = new Map<String, EndpointSetting__mdt>();
 		
 		for (EndpointSetting__mdt objEndpointSettingMdt : [Select e.Timeout__c, e.ServiceProvider__c, e.ResponseBodyType__c, 
 			e.RequestBodyType__c, e.IsActive__c, e.Endpoint__c, e.DevelopmentEndpoint__c, e.DeveloperName, e.Description__c,
 			e.grant_type__c, e.client_id__c, e.client_secret__c, ServiceMethod__c
 			From EndpointSetting__mdt e Where IsActive__c = true ]){
 			//Metelo al mapa de mapEndpointSettingMdtPaso
 			mapEndpointSettingMdtPaso.put(objEndpointSettingMdt.DeveloperName, objEndpointSettingMdt);	
 		}
 		
 		//Regresa el mapa
 		return mapEndpointSettingMdtPaso;
 	}
 

	//Regresa un objeto del tipo DtRespuestaTelcel si no hubo error a la hora de registrar el cliente		
	public static DtRespuestaTelcel JSONParserRespTelcel(String sJsonResp){
		System.debug('EN DCT_Utils_cls.Login: sJsonResp: ' + sJsonResp);
		
		DtRespuestaTelcel objAPPResp = new DtRespuestaTelcel();
				
		try{
            JSONParser parser = JSON.createParser(sJsonResp);
            //Ve si tiene algo el objeto de parser  
            while (parser.nextToken() != null) {//{"error": "invalid_client","error_description": "Las credenciales proporcionadas no son correctas."}
				//Inicia el detalle del objeto: sNombreObj
				if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
					//Toma el contenido del Json y conviertelo a SignInCls.class 
					objAPPResp = (DtRespuestaTelcel)parser.readValueAs(DtRespuestaTelcel.class);
				}//Fin si parser.getCurrentToken() == JSONToken.START_OBJECT
            }//Fin mientras parser.nextToken() != null			
		}catch(Exception ex){
			System.debug('ERROR EN DCT_Utils_cls.Login: sJsonResp: ' + ex.getMessage());
	 	}
			 	
		//Regresa el objeto objSignInClsPaso
		return objAPPResp;
	}

	//Función que permite calcular la dedad de una persona
    @future(callout=true)
	public static void ActualizaReferenciaRAP(String sIdEambudos){
		System.debug('ENTRO A Utils.ActualizaReferenciaRAP: ' + sIdEambudos);
		
		String sRespWs = '';
		Map<String, Cliente__c> mapDirComUpd = new Map<String, Cliente__c>();
		
		//Crea la lista para los id de los Embudos que se estan actualizando
		List<String> lIdEmbudosPaso = sIdEambudos.split(',');
		Set<String> setEmbRefAct = new Set<String>();
		Set<String> setEmbRefNoAct = new Set<String>();		
		System.debug('ENTRO A Utils.ActualizaReferenciaRAP lIdEmbudosPaso: ' + lIdEmbudosPaso);
		
		//Ve si las Opp en cuestion ya tienen actualuzadas las referencias
		for(Opportunity Embudo : [Select Account.RFC__c, Directorio_Comercial__c,
			Directorio_Comercial__r.DCTRapReference__c, AccountId
			From Opportunity Where id IN :lIdEmbudosPaso ]){
			Boolean bRefUpd = false;	
			System.debug('ENTRO A Utils.ActualizaReferenciaRAP Embudo: ' + Embudo);						
			//Ve si tiene un directorio comercial asociado Embudo.Directorio_Comercial__c
			if (Embudo.Directorio_Comercial__c != null){
				System.debug('ENTRO A Utils.ActualizaReferenciaRAP Val1 1 Embudo: ' + Embudo);				
				if (Embudo.Directorio_Comercial__r.DCTRapReference__c != null){
					System.debug('ENTRO A Utils.ActualizaReferenciaRAP Val1 2 Embudo: ' + Embudo);
					setEmbRefAct.add(Embudo.id);
					bRefUpd = true;
				}//Fin si Embudo.Directorio_Comercial__r.DCTRapReference__c != null
			}//Fin si Embudo.Directorio_Comercial__c != null
			
			//Si no esta actualizado el embudo
			if (!bRefUpd && Embudo.Directorio_Comercial__c == null){
				System.debug('ENTRO A Utils.ActualizaReferenciaRAP Val1 3 Embudo: ' + Embudo);				
				for (Account pct : [Select id, 
						(Select id, Cliente__c, DCTRapReference__c From Clientes__r Where DCTRapReference__c = null) 
					From Account a Where id =: Embudo.AccountId]){
					System.debug('ENTRO A Utils.ActualizaReferenciaRAP Val1 4 pct.Clientes__r.isEmpty(): ' + pct.Clientes__r.isEmpty());						
					if (!pct.Clientes__r.isEmpty())
						setEmbRefNoAct.add(Embudo.id);
				}//Fin del for para los clientes				
			}//Fin si !bRefUpd
			
			//Si no tiene referencia el enbudo metelo a la lista de los que tiene que actualizar
			if (!bRefUpd)
				setEmbRefNoAct.add(Embudo.id);
		}//Fin del for para los reg del embudo

		System.debug('ENTRO A Utils.ActualizaReferenciaRAP setEmbRefNoAct: ' + setEmbRefNoAct);					
		//Recorre la lista de lIdEmbudosPaso y envia los datos a Telcel
		for (String sIdEmbudo : setEmbRefNoAct){
			
			//recorre la lista de 						
			for(Opportunity Embudo : [Select Account.RFC__c, Directorio_Comercial__c,
				Directorio_Comercial__r.DCTRapReference__c, AccountId
				From Opportunity Where id =:sIdEmbudo ]){
				
				//Crea el llamado al Ws de referencia rap
				if (Embudo.Account.RFC__c != null) {
					System.debug('ANTES DE LLAMAR A Utils.ActualizaReferenciaRAP objRespRefRap: ' + Embudo.Account.RFC__c);					
					sRespWs = DCT_ReferenciaRAP_ws.ReferenciaRAP(Embudo.Account.RFC__c);
					System.debug('ENTRO A Utils.ActualizaReferenciaRAP sRespWs: ' + sRespWs);
					respuestaTelcel objRespRefRap = (respuestaTelcel) JSON.deserialize(sRespWs, respuestaTelcel.class);					
					System.debug('ENTRO A Utils.ActualizaReferenciaRAP objRespRefRap: ' + objRespRefRap);
					
					//Ve si no hubo error a la hora de consultar la referencia SAP
					if (objRespRefRap.referenciaWSRap.idEstatus == 0){
						//Ve si tiene algo el campo de Embudo.Directorio_Comercial__c
						if (Embudo.Directorio_Comercial__c == null){
							for (Account pct : [Select id, (Select id, Cliente__c From Clientes__r Limit 1) 
								From Account a Where id =: Embudo.AccountId]){
								if (!pct.Clientes__r.isEmpty()){
									for (Cliente__c dirCom : pct.Clientes__r){
										mapDirComUpd.put(dirCom.id, new Cliente__c(id = dirCom.id,
												DCTRapReference__c = objRespRefRap.referenciaWSRap.referencia
											)
										);
									}//Fin del for para el dir com
								}//Fin si !pct.Clientes__r.isEmpty()
							}//Fin del for para los clientes
						}//Fin si Embudo.Directorio_Comercial__c != null
						//Tiene un dir asociado esta opp
						if (Embudo.Directorio_Comercial__c != null){
							mapDirComUpd.put(Embudo.Directorio_Comercial__c, new Cliente__c(id = Embudo.Directorio_Comercial__c,
									DCTRapReference__c = objRespRefRap.referenciaWSRap.referencia
								)
							);						
						}//Fin si Embudo.Directorio_Comercial__c != null
					}//Fin si objRespRefRap.idEstatus == '0'
					//Ve si no hubo error a la hora de consultar la referencia SAP
					if (objRespRefRap.referenciaWSRap.idEstatus == 2){
						//Tiene un dir asociado esta opp
						mapDirComUpd.put(Embudo.Directorio_Comercial__c, new Cliente__c(id = Embudo.Directorio_Comercial__c,
								DCT_DetalleErrorReferenciaRAP__c = objRespRefRap.referenciaWSRap.descEstatus
							)
						);						
					}//Fin si objRespRefRap.referenciaWSRap.idEstatus == 2
					
				}//Fin si Embudo.Account.RFC__c != null
				
			}//Fin del for para los reg del embudo
			
		}//Fin del for para los datos del lIdEmbudosPaso
		
		//Ya tienes los dir comer que se van a actualizar
		if (!mapDirComUpd.isEmpty()){
			System.debug('ANTES DE LLAMAR A Utils.ActualizaReferenciaRAP mapDirComUpd: ' + mapDirComUpd);			
	        List<Database.SaveResult> lDtbup = Database.update(mapDirComUpd.values(), false);
	        for (Database.SaveResult objDtbup : lDtbup){
	        	if(!objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaReferenciaRAP ERROR A LA HORA DE ACT LA REFERENCIA SAP: ' + objDtbup.getErrors()[0].getMessage());	        	
	        	if(objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaReferenciaRAP SE ACT EL DIR COM CON EXITO ID: ' + objDtbup.getId());	        			        	
	        }//Fin del for para lDtbup
		}//Fin si !mapDirComUpd.isEmpty()
			
	}

	//Función que permite calcular la dedad de una persona
    @future(callout=true)
	public static void ActualizaFolioSAP(String sIdEambudos){
		System.debug('ENTRO A Utils.ActualizaFolioSAP: ' + sIdEambudos);
		
		String sRespWs = '';
		String sDatos = '';
		String sUsuario = '';
		String sPwd = '';
		Map<String, Cliente__c> mapDirComUpd = new Map<String, Cliente__c>();
		
		//Crea la lista para los id de los Embudos que se estan actualizando
		List<String> lIdEmbudosPaso = sIdEambudos.split(',');
		Set<String> setEmbRefAct = new Set<String>();
		Set<String> setEmbRefNoAct = new Set<String>();		
		System.debug('ENTRO A Utils.ActualizaFolioSAP lIdEmbudosPaso: ' + lIdEmbudosPaso);
		
		//Ve si las Opp en cuestion ya tienen actualuzadas las referencias
		for(Opportunity Embudo : [Select Account.RFC__c, Directorio_Comercial__c,
			Directorio_Comercial__r.DCTFolio__c, AccountId
			From Opportunity Where id IN :lIdEmbudosPaso ]){
			Boolean bRefUpd = false;	
			System.debug('ENTRO A Utils.ActualizaFolioSAP Embudo: ' + Embudo);						
			//Ve si tiene un directorio comercial asociado Embudo.Directorio_Comercial__c
			if (Embudo.Directorio_Comercial__c != null){
				System.debug('ENTRO A Utils.ActualizaFolioSAP Val1 1 Embudo: ' + Embudo);				
				if (Embudo.Directorio_Comercial__r.DCTFolio__c != null){
					System.debug('ENTRO A Utils.ActualizaFolioSAP Val1 2 Embudo: ' + Embudo);
					setEmbRefAct.add(Embudo.id);
					bRefUpd = true;
				}//Fin si Embudo.Directorio_Comercial__r.DCTFolio__c != null
			}//Fin si Embudo.Directorio_Comercial__c != null
			
			//Si no esta actualizado el embudo directo
			if (!bRefUpd && Embudo.Directorio_Comercial__c == null){
				System.debug('ENTRO A Utils.ActualizaFolioSAP Val1 3 Embudo: ' + Embudo);				
				for (Account pct : [Select id, 
						(Select id, Cliente__c, DCTFolio__c From Clientes__r Where DCTFolio__c = null) 
					From Account a Where id =: Embudo.AccountId]){
					System.debug('ENTRO A Utils.ActualizaFolioSAP Val1 4 pct.Clientes__r.isEmpty(): ' + pct.Clientes__r.isEmpty());						
					if (!pct.Clientes__r.isEmpty()){
						setEmbRefNoAct.add(Embudo.id);						
					}//Fin si !pct.Clientes__r.isEmpty()
				}//Fin del for para los clientes				
			}//Fin si !bRefUpd
			
			//Si no tiene referencia el enbudo metelo a la lista de los que tiene que actualizar
			if (!bRefUpd)
				setEmbRefNoAct.add(Embudo.id);
		}//Fin del for para los reg del embudo

		System.debug('ENTRO A Utils.ActualizaFolioSAP setEmbRefNoAct: ' + setEmbRefNoAct);					
		//Recorre la lista de lIdEmbudosPaso y envia los datos a Telcel
		for (String sIdEmbudo : setEmbRefNoAct){
			
			Set<String> setIdDirCom = new Set<String>();
			Map<String, Cliente__c> maptIdPctObjDirCom = new Map<String, Cliente__c>();
			//Toma el id del PCT asociado al embudo para que despues lo consultes
			for(Opportunity Embudo : [Select AccountId From Opportunity Where id =:sIdEmbudo ]){
				setIdDirCom.add(Embudo.AccountId);
			}
			//Consulta los datos asociados a los dir Com desde los pct
			for (Account pct : [Select a.DTC_LegalEntity__c, 
					(Select id, Name,
						DCTFiscalStreet__c, //CALLE
						DCTNoIntFiscal__c, //NUMEROL
						DCTNoExtFiscal__c, //COMPLNUM
						DCTCodePostfiscal__c, //CODPOSTAL
						DCTDelMpiofiscal__c, //DELMUN
						DCTColonyFiscal__c, //COLONIA
						//CIUDAD PENDIENTE
						//PAIS 'MX' DEF
						FiscalFederalEntity__c	//ESTADO						 
					From Clientes__r) 
				From Account a Where ID IN :setIdDirCom]){
				//Ve si tiene un Dir Com asociado
				if (!pct.Clientes__r.isEmpty()){
					//Toma el dir com asociado
					Cliente__c DirComPaso = pct.Clientes__r.get(0);
					//Metelo al mapa de maptIdPctObjDirCom
					maptIdPctObjDirCom.put(pct.id, DirComPaso);
				}//Fin si pct.Clientes__r.isEmpty()				
			}//Fin del for para la consulta los dir asociados a los pct
			
			//recorre la lista de 						
			for(Opportunity Embudo : [Select id, Directorio_Comercial__c,
				Directorio_Comercial__r.DCTFolio__c, AccountId, 
				//Datos de los usuarios para sap
				Owner.EmployeeNumber, //NEMPLEADO
				//REGION = MR09
				Account.DTC_LegalEntity__c, //Tipo de Persona: Física, Moral, Física con Actividad Empresarial, Gubernamental
				Account.RFC__c, //RFC
				Account.DCTName__c, //NOM1PF
				Account.DCTLastName__c, //APPAT
				Account.DCTMotherLastName__c, //APMAT*/
				Account.Name //NOM1PM
				
				From Opportunity Where id =:sIdEmbudo ]){
				
				//Concatena los datos en la variable de sDatos
				//NEMPLEADO
				sDatos += Embudo.Owner.EmployeeNumber != null ? Embudo.Owner.EmployeeNumber + ',' : ','; 
				//REGION
				sDatos += 'MR09,';
				//RFC
				sDatos += Embudo.Account.RFC__c != null ? Embudo.Account.RFC__c + ',' : ',';
				System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos1: ' + sDatos);
				
				//Se trata de una persona fisica
				if (Embudo.Account.DTC_LegalEntity__c == 'Física' || Embudo.Account.DTC_LegalEntity__c == 'Física con Actividad Empresarial'){
					String sConBus = Embudo.Account.DCTName__c != null ? Embudo.Account.DCTName__c.substring(0,1) : '';
					sConBus += Embudo.Account.DCTLastName__c != null ? Embudo.Account.DCTLastName__c.substring(0,1) : '';
					sConBus += Embudo.Account.DCTLastName__c != null ? Embudo.Account.DCTLastName__c.substring(0,1) : '';
					//CONCEPTOBUSQ
					sDatos += sConBus + ',';								
					//NOM1PF
					sDatos += Embudo.Account.DCTName__c != null ? Embudo.Account.DCTName__c + ',' : ',';
					//NOM2PF
					sDatos += ',';
					//APPAT
					sDatos += Embudo.Account.DCTLastName__c != null ? Embudo.Account.DCTLastName__c + ',' : ',';				
					//APMAT
					sDatos += Embudo.Account.DCTMotherLastName__c != null ? Embudo.Account.DCTMotherLastName__c + ',' : ',';				
				}//Fin si Embudo.Account.DTC_LegalEntity__c == 'Física' || Embudo.Account.DTC_LegalEntity__c == 'Física con Actividad Empresarial'

				//Se trata de una persona Moral 
				if (Embudo.Account.DTC_LegalEntity__c == 'Moral' || Embudo.Account.DTC_LegalEntity__c == 'Gubernamental'){
					//CONCEPTOBUSQ
					sDatos += Embudo.Account.Name != null ? Embudo.Account.Name + ',' : ',';
					//NOM1PM
					sDatos += Embudo.Account.Name != null ? Embudo.Account.Name + ',' : ',';
					//NOM2PM
					sDatos += ',';
					//NOM3PM
					sDatos += ',';
					//NOM4PM
					sDatos += ',';					
				}//Fin si Embudo.Account.DTC_LegalEntity__c == 'Física' || Embudo.Account.DTC_LegalEntity__c == 'Física con Actividad Empresarial'
				System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos2: ' + sDatos);
				
				//Por aqui los datos de la dirección
				if (maptIdPctObjDirCom.containsKey(Embudo.AccountId)){
					Cliente__c DirComPaso = maptIdPctObjDirCom.get(Embudo.AccountId); 
					//CALLE
					sDatos += DirComPaso.DCTFiscalStreet__c != null ? DirComPaso.DCTFiscalStreet__c + ',' : ',';
					//NUMEROL
					sDatos += DirComPaso.DCTNoIntFiscal__c != null ? DirComPaso.DCTNoIntFiscal__c + ',' : ',';
					//COMPLNUM
					sDatos += DirComPaso.DCTNoExtFiscal__c != null ? DirComPaso.DCTNoExtFiscal__c + ',' : ',';
					//CODPOSTAL
					sDatos += DirComPaso.DCTCodePostfiscal__c != null ? DirComPaso.DCTCodePostfiscal__c + ',' : ',';
					//DELMUN
					sDatos += DirComPaso.DCTDelMpiofiscal__c != null ? DirComPaso.DCTDelMpiofiscal__c + ',' : ',';
					//COLONIA
					sDatos += DirComPaso.DCTColonyFiscal__c != null ? DirComPaso.DCTColonyFiscal__c + ',' : ',';
					//CIUDAD
					sDatos += ',';
					//PAIS
					sDatos += 'MX,';
					//ESTADO
					sDatos += DirComPaso.FiscalFederalEntity__c != null ? DirComPaso.FiscalFederalEntity__c + ',' : ',';
				}//Fin si maptIdPctObjDirCom.containsKey(Embudo.AccountId)

				if (!maptIdPctObjDirCom.containsKey(Embudo.AccountId)){
					//CALLE
					sDatos += ',';
					//NUMEROL
					sDatos += ',';
					//COMPLNUM
					sDatos += ',';
					//CODPOSTAL
					sDatos += ',';
					//DELMUN
					sDatos += ',';
					//COLONIA
					sDatos += ',';
					//CIUDAD
					sDatos += ',';
					//PAIS
					sDatos += 'MX,';
					//ESTADO
					sDatos += ',';					
				}//Fin si !maptIdPctObjDirCom.containsKey(Embudo.AccountId)
				System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos3: ' + sDatos);
								
				//Crea el llamado al Ws de referencia rap
				if (Embudo.Account.RFC__c != null) {
					
					System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos: ' + sDatos);
					
					System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP objRespRefRap: ' + Embudo.Account.RFC__c);					
					DCT_FolioSAP_ws.respSalesforce objRespSalesforce = DCT_FolioSAP_ws.getFolioSAP(sDatos, sUsuario, sPwd, Embudo.Account.DTC_LegalEntity__c);					
					System.debug('ENTRO A Utils.ActualizaFolioSAP objRespSalesforce: ' + objRespSalesforce);

					//Ve si no hubo error a la hora de consultar la referencia SAP
					if (!objRespSalesforce.error){
						//Ve si tiene algo el campo de Embudo.Directorio_Comercial__c
						if (Embudo.Directorio_Comercial__c == null){
							for (Account pct : [Select id, (Select id, Cliente__c From Clientes__r Limit 1) 
								From Account a Where id =: Embudo.AccountId]){
								if (!pct.Clientes__r.isEmpty()){
									for (Cliente__c dirCom : pct.Clientes__r){
										mapDirComUpd.put(dirCom.id, new Cliente__c(id = dirCom.id,
												DCTFolio__c = objRespSalesforce.folio
											)
										);
									}//Fin del for para el dir com
								}//Fin si !pct.Clientes__r.isEmpty()
							}//Fin del for para los clientes
						}//Fin si Embudo.Directorio_Comercial__c != null
						//Tiene un dir asociado esta opp
						if (Embudo.Directorio_Comercial__c != null){
							mapDirComUpd.put(Embudo.Directorio_Comercial__c, new Cliente__c(id = Embudo.Directorio_Comercial__c,
									DCTFolio__c = objRespSalesforce.folio
								)
							);						
						}//Fin si Embudo.Directorio_Comercial__c != null
					}//Fin si objRespSalesforce.idEstatus == '0'
					
					//hubo error a la hora
					if (objRespSalesforce.error){
						mapDirComUpd.put(Embudo.Directorio_Comercial__c, new Cliente__c(id = Embudo.Directorio_Comercial__c,
								DCT_DetalleErrorFolioSAP__c = objRespSalesforce.mensaje
							)
						);												
					}//Fin si objRespSalesforce.error
					
				}//Fin si Embudo.Account.RFC__c != null
				
			}//Fin del for para los reg del embudo
			
		}//Fin del for para los datos del lIdEmbudosPaso
		
		//Ya tienes los dir comer que se van a actualizar
		if (!mapDirComUpd.isEmpty()){
			System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP mapDirComUpd: ' + mapDirComUpd);			
	        List<Database.SaveResult> lDtbup = Database.update(mapDirComUpd.values(), false);
	        for (Database.SaveResult objDtbup : lDtbup){
	        	if(!objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaFolioSAP ERROR A LA HORA DE ACT LA REFERENCIA SAP: ' + objDtbup.getErrors()[0].getMessage());	        	
	        	if(objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaFolioSAP SE ACT EL DIR COM CON EXITO ID: ' + objDtbup.getId());	        			        	
	        }//Fin del for para lDtbup
		}//Fin si !mapDirComUpd.isEmpty()
			
	}

	//Función que permite calcular la dedad de una persona
    @future(callout=true)
	public static void ActualizaFolioSAPDirCom(String sIdEambudos){
		System.debug('ENTRO A Utils.ActualizaFolioSAP: ' + sIdEambudos);
		
		String sRespWs = '';
		String sDatos = '';
		String sUsuario = '';
		String sPwd = '';
		Map<String, Cliente__c> mapDirComUpd = new Map<String, Cliente__c>();
		
		//Crea la lista para los id de los Embudos que se estan actualizando
		List<String> lIdEmbudosPaso = sIdEambudos.split(',');
		Set<String> setEmbRefAct = new Set<String>();
		Set<String> setEmbRefNoAct = new Set<String>();		
		System.debug('ENTRO A Utils.ActualizaFolioSAP lIdEmbudosPaso: ' + lIdEmbudosPaso);
		
		//Ve si ya tienen folio los embudos
		for(Cliente__c DirCom : [Select id, DCTFolio__c From Cliente__c Where ID IN : lIdEmbudosPaso
			And DCTFolio__c = null]){
			setEmbRefNoAct.add(DirCom.id);			
		}		
		System.debug('ENTRO A Utils.ActualizaFolioSAP setEmbRefNoAct: ' + setEmbRefNoAct);
				
		//Recorre la lista de lIdEmbudosPaso y envia los datos a Telcel
		for (String sIdDirCom : setEmbRefNoAct){
			
			//Busca los datos de sIdDirCom 
			for (Cliente__c DirCom : [Select id, Name,
						Cliente__c,
						Cliente__r.Owner.EmployeeNumber, //NEMPLEADO						
						Cliente__r.DTC_LegalEntity__c, //Tipo de Persona: Física, Moral, Física con Actividad Empresarial, Gubernamental
						RFC1__c, //RFC
						Cliente__r.DCTName__c, //NOM1PF
						Cliente__r.DCTLastName__c, //APPAT
						Cliente__r.DCTMotherLastName__c, //APMAT*/
						Cliente__r.Name, //NOM1PM
						//Datos de la dirección
						DCTFiscalStreet__c, //CALLE
						DCTNoIntFiscal__c, //NUMEROL
						DCTNoExtFiscal__c, //COMPLNUM
						DCTCodePostfiscal__c, //CODPOSTAL
						DCTDelMpiofiscal__c, //DELMUN
						DCTColonyFiscal__c, //COLONIA
						//CIUDAD PENDIENTE
						//PAIS 'MX' DEF						
						FiscalFederalEntity__c	//ESTADO						 
					From Cliente__c Where ID = :sIdDirCom]){

				//Concatena los datos en la variable de sDatos
				//NEMPLEADO
				sDatos += DirCom.Cliente__r.Owner.EmployeeNumber != null ? DirCom.Cliente__r.Owner.EmployeeNumber + ',' : ','; 
				//REGION
				sDatos += 'MR09,';
				//RFC
				sDatos += DirCom.RFC1__c != null ? DirCom.RFC1__c + ',' : ',';
				System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos1: ' + sDatos);
				
				//Se trata de una persona fisica
				if (DirCom.Cliente__r.DTC_LegalEntity__c == 'Física' || DirCom.Cliente__r.DTC_LegalEntity__c == 'Física con Actividad Empresarial'){
					String sConBus = DirCom.Cliente__r.DCTName__c != null ? DirCom.Cliente__r.DCTName__c.substring(0,1) : '';
					sConBus += DirCom.Cliente__r.DCTLastName__c != null ? DirCom.Cliente__r.DCTLastName__c.substring(0,1) : '';
					sConBus += DirCom.Cliente__r.DCTLastName__c != null ? DirCom.Cliente__r.DCTLastName__c.substring(0,1) : '';
					//CONCEPTOBUSQ
					sDatos += sConBus + ',';								
					//NOM1PF
					sDatos += DirCom.Cliente__r.DCTName__c != null ? DirCom.Cliente__r.DCTName__c + ',' : ',';
					//NOM2PF
					sDatos += ',';
					//APPAT
					sDatos += DirCom.Cliente__r.DCTLastName__c != null ? DirCom.Cliente__r.DCTLastName__c + ',' : ',';				
					//APMAT
					sDatos += DirCom.Cliente__r.DCTMotherLastName__c != null ? DirCom.Cliente__r.DCTMotherLastName__c + ',' : ',';				
				}//Fin si DirCom.Cliente__r.DTC_LegalEntity__c == 'Física' || DirCom.Cliente__r.DTC_LegalEntity__c == 'Física con Actividad Empresarial'

				//Se trata de una persona Moral 
				if (DirCom.Cliente__r.DTC_LegalEntity__c == 'Moral' || DirCom.Cliente__r.DTC_LegalEntity__c == 'Gubernamental'){
					//CONCEPTOBUSQ
					sDatos += DirCom.Cliente__r.Name != null ? DirCom.Cliente__r.Name + ',' : ',';
					//NOM1PM
					sDatos += DirCom.Cliente__r.Name != null ? DirCom.Cliente__r.Name + ',' : ',';
					//NOM2PM
					sDatos += ',';
					//NOM3PM
					sDatos += ',';
					//NOM4PM
					sDatos += ',';					
				}//Fin si DirCom.Cliente__r.DTC_LegalEntity__c == 'Física' || DirCom.Cliente__r.DTC_LegalEntity__c == 'Física con Actividad Empresarial'
				System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos2: ' + sDatos);
				
				//Por aqui los datos de la dirección
				//CALLE
				sDatos += DirCom.DCTFiscalStreet__c != null ? DirCom.DCTFiscalStreet__c + ',' : ',';
				//NUMEROL
				sDatos += DirCom.DCTNoIntFiscal__c != null ? DirCom.DCTNoIntFiscal__c + ',' : ',';
				//COMPLNUM
				sDatos += DirCom.DCTNoExtFiscal__c != null ? DirCom.DCTNoExtFiscal__c + ',' : ',';
				//CODPOSTAL
				sDatos += DirCom.DCTCodePostfiscal__c != null ? DirCom.DCTCodePostfiscal__c + ',' : ',';
				//DELMUN
				sDatos += DirCom.DCTDelMpiofiscal__c != null ? DirCom.DCTDelMpiofiscal__c + ',' : ',';
				//COLONIA
				sDatos += DirCom.DCTColonyFiscal__c != null ? DirCom.DCTColonyFiscal__c + ',' : ',';
				//CIUDAD
				sDatos += ',';
				//PAIS
				sDatos += 'MX,';
				//ESTADO
				sDatos += DirCom.FiscalFederalEntity__c != null ? DirCom.FiscalFederalEntity__c + ',' : ',';
				System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos3: ' + sDatos);

				//Crea el llamado al Ws de referencia rap
				if (DirCom.RFC1__c != null && DirCom.Cliente__r.DTC_LegalEntity__c != null) {
					System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP sDatos: ' + sDatos);
					System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP objRespRefRap: ' + DirCom.RFC1__c);					
					DCT_FolioSAP_ws.respSalesforce objRespSalesforce = DCT_FolioSAP_ws.getFolioSAP(sDatos, sUsuario, sPwd, DirCom.Cliente__r.DTC_LegalEntity__c);					
					System.debug('ENTRO A Utils.ActualizaFolioSAP objRespSalesforce: ' + objRespSalesforce);
					//Ve si no hubo error a la hora de consultar la referencia SAP
					if (objRespSalesforce.error != null){					
						if (!objRespSalesforce.error){
							mapDirComUpd.put(dirCom.id, new Cliente__c(id = dirCom.id,
									DCTFolio__c = objRespSalesforce.folio
								)
							);
						}//Fin si objRespSalesforce.idEstatus == '0'
						
						//hubo error a la hora
						if (objRespSalesforce.error){
							mapDirComUpd.put(DirCom.id, new Cliente__c(id = DirCom.id,
									DCT_DetalleErrorFolioSAP__c = objRespSalesforce.mensaje
								)
							);												
						}//Fin si objRespSalesforce.error
					}//Fin si objRespSalesforce.error != null
				}//Fin si DirCom.Account.RFC1__c != null

			}//Fin del for para los datos del Dir Com
			
		}//Fin del for para los dir com que no tienen folio

		//Ya tienes los dir comer que se van a actualizar
		if (!mapDirComUpd.isEmpty()){
			System.debug('ANTES DE LLAMAR A Utils.ActualizaFolioSAP mapDirComUpd: ' + mapDirComUpd);
			DCT_TriggerExecutionControl_cls.setAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');						
	        List<Database.SaveResult> lDtbup = Database.update(mapDirComUpd.values(), false);
	        for (Database.SaveResult objDtbup : lDtbup){
	        	if(!objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaFolioSAP ERROR A LA HORA DE ACT LA REFERENCIA SAP: ' + objDtbup.getErrors()[0].getMessage());	        	
	        	if(objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaFolioSAP SE ACT EL DIR COM CON EXITO ID: ' + objDtbup.getId());	        			        	
	        }//Fin del for para lDtbup
		}//Fin si !mapDirComUpd.isEmpty()
			
	}

	//Función que permite calcular la dedad de una persona
    @future(callout=true)
	public static void ActualizaReferenciaRAPDirCom(String sIdEambudos){
		System.debug('ENTRO A Utils.ActualizaReferenciaRAP: ' + sIdEambudos);
		
		String sRespWs = '';
		Map<String, Cliente__c> mapDirComUpd = new Map<String, Cliente__c>();
		
		//Crea la lista para los id de los Embudos que se estan actualizando
		List<String> lIdEmbudosPaso = sIdEambudos.split(',');
		Set<String> setEmbRefAct = new Set<String>();
		Set<String> setEmbRefNoAct = new Set<String>();		
		System.debug('ENTRO A Utils.ActualizaReferenciaRAP lIdEmbudosPaso: ' + lIdEmbudosPaso);

		//Ve si ya tienen folio los embudos
		for(Cliente__c DirCom : [Select id, DCTRapReference__c From Cliente__c Where ID IN : lIdEmbudosPaso
			And DCTRapReference__c = null]){
			setEmbRefNoAct.add(DirCom.id);			
		}		

		//Recorre la lista de lIdEmbudosPaso y envia los datos a Telcel
		for (String sIdDirCom : setEmbRefNoAct){

			//Busca los datos de sIdDirCom 
			for (Cliente__c DirCom : [Select id, Name, Cliente__c,	Cliente__r.RFC__c 
					From Cliente__c Where ID = :sIdDirCom]){

				//Crea el llamado al Ws de referencia rap
				if (DirCom.Cliente__r.RFC__c != null) {
					System.debug('ANTES DE LLAMAR A Utils.ActualizaReferenciaRAP objRespRefRap: ' + DirCom.Cliente__r.RFC__c);					
					sRespWs = DCT_ReferenciaRAP_ws.ReferenciaRAP(DirCom.Cliente__r.RFC__c);
					System.debug('ENTRO A Utils.ActualizaReferenciaRAP sRespWs: ' + sRespWs);
					respuestaTelcel objRespRefRap = (respuestaTelcel) JSON.deserialize(sRespWs, respuestaTelcel.class);					
					System.debug('ENTRO A Utils.ActualizaReferenciaRAP objRespRefRap: ' + objRespRefRap);
					
					//Ve si no hubo error a la hora de consultar la referencia SAP
					if (objRespRefRap.referenciaWSRap != null){					
						if (objRespRefRap.referenciaWSRap.idEstatus == 0){
							mapDirComUpd.put(dirCom.id, new Cliente__c(id = dirCom.id,
									DCTRapReference__c = objRespRefRap.referenciaWSRap.referencia
								)
							);
						}//Fin si objRespRefRap.idEstatus == '0'
						//Ve si no hubo error a la hora de consultar la referencia SAP
						if (objRespRefRap.referenciaWSRap.idEstatus == 2){
							//Tiene un dir asociado esta opp
							mapDirComUpd.put(dirCom.id, new Cliente__c(id = dirCom.id,
									DCT_DetalleErrorReferenciaRAP__c = objRespRefRap.referenciaWSRap.descEstatus
								)
							);						
						}//Fin si objRespRefRap.referenciaWSRap.idEstatus == 2
					}//Fin si objRespRefRap.referenciaWSRap != null
										
				}//Fin si DirCom.Cliente__r.RFC__c != null
			
			}//Fin del for para los datos del cliente
			
		}//Fin del for para la lista de setEmbRefNoAct
		
		//Ya tienes los dir comer que se van a actualizar
		if (!mapDirComUpd.isEmpty()){
			System.debug('ANTES DE LLAMAR A Utils.ActualizaReferenciaRAP mapDirComUpd: ' + mapDirComUpd);
			DCT_TriggerExecutionControl_cls.setAlreadyBeenExecuted('DCT_ComercialDirectory_tgr');						
	        List<Database.SaveResult> lDtbup = Database.update(mapDirComUpd.values(), false);
	        for (Database.SaveResult objDtbup : lDtbup){
	        	if(!objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaReferenciaRAP ERROR A LA HORA DE ACT LA REFERENCIA SAP: ' + objDtbup.getErrors()[0].getMessage());	        	
	        	if(objDtbup.isSuccess())
					System.debug('EN Utils.ActualizaReferenciaRAP SE ACT EL DIR COM CON EXITO ID: ' + objDtbup.getId());	        			        	
	        }//Fin del for para lDtbup
		}//Fin si !mapDirComUpd.isEmpty()
			
	}

	public static Long consectivoPlanesYEquipos(){
		System.debug('EN consectivoPlanesYEquipos...');
		Long lConsecutivo = 0;

		ConsWsPlanesEquipos__c consePlanesEquipos = new ConsWsPlanesEquipos__c();
		Insert consePlanesEquipos;
		//Crea el consecutivo
		String sConsec = [Select Name From ConsWsPlanesEquipos__c Where id =: consePlanesEquipos.id].Name;
		//Elimina el reg creado 
		delete consePlanesEquipos;
		
		System.debug('EN consectivoPlanesYEquipos sConsec: ' + sConsec);		
		//Regresa el consecutivo
		return Long.valueOf(sConsec);
	}


    
}