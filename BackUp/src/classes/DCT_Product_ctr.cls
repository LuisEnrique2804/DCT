public class DCT_Product_ctr {
	
	public User objUsrActual = [Select Id, DCTXO__c, DCTVT__c From User Where id =:UserInfo.getUserId()];
	
    public DCTDirectoryProductRelationship__c       DCTnewProduct {get; set;}
    public DCTAuthorizedLines__c                    dctNewLine    {get; set;}
    public List<DCTDirectoryProductRelationship__c> lstDirProd    {get; set;}
    public List<DCTAuthorizedLines__c>              lstDCTPlan    {get; set;}
    public String                                   idRecord      {get; set;}
    public Boolean                                  blnIsOnclick  {get; set;}
    public Boolean                                  blnIsOnclick2 {get; set;}
    public SObject                                  recordDC      {get; set;}
	public Set<String> setIdProdExist {get;set;}    
    public String slConsecCons {get;set;}
    public Map<String,Map<String,RecordType>> mapRTsByDevName {get;set;}
    public String idRecodPlan {get;set;}
    
    public List<SelectOption> slTipoMercado {get;set;} 
    public String sTipoMercado {get;set;}
    public String sTipoMercadoDesc {get;set;}    
    public Map<String, DCT_TelcelPlanesSoap_ws.planMercado> mapTipoMercado {get;set;}
        
    public List<SelectOption> slGrupoPlan {get;set;} 
    public String sGrupoPlan {get;set;}
    public Map<String, DCT_TelcelPlanesSoap_ws.grupoPlanMercado> mapGruposPlanes {get;set;}

    public List<SelectOption> selPlazos {get;set;} 
    public String sPlazos {get;set;}
    public Map<String, DCT_TelcelPlanesSoap_ws.planPlazoMercado> mapPlazos {get;set;}

    public List<SelectOption> selPlanes {get;set;} 
    public String sPlanes {get;set;}
    public Map<String, DCT_TelcelPlanesSoap_ws.planPlazoM2K> mapPlanes {get;set;}

    public List<SelectOption> selGuiaPlanes {get;set;} 
    public String sGuiaPlanes {get;set;}
    public Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO> mapGuiaPlanes {get;set;}
    
    public String sError {get;set;}
    public Boolean bErrorIns {get;set;}    
    
    public Cliente__c DirComFzaVta {get;set;}
    public Set<String> setIdFzaVtas {get;set;}
    
    public DCT_Product_ctr(ApexPages.StandardController stdCtr){
    	System.debug('EN DCT_Product_ctr...');
    	
    	lstDCTPlan = new List<DCTAuthorizedLines__c>();
    	setIdProdExist = new Set<String>();
    	lstDirProd = new List<DCTDirectoryProductRelationship__c>();
    	DirComFzaVta = new Cliente__c();
    	setIdFzaVtas = new Set<String>();
    	
        idRecord = stdCtr.getid();
        recordDC = stdCtr.getRecord();
		
		//Agrega la fuerza de ventas del usuario
		if (objUsrActual.DCTVT__c != null)
			setIdFzaVtas.add(objUsrActual.DCTVT__c);
		//Busca los datos de 
		for (Cliente__c DircCom : [Select c.DCTSharedTreatment__c, 
				c.DCT_CatalogoFuerzaVenta__c, 
				c.DCT_CatalogoFuerzaVenta__r.Name, 
				c.DCTCatalogoFuerzaVenta2__c, 
				c.DCTCatalogoFuerzaVenta2__r.Name,
				c.DCTStatus__c
				From Cliente__c c Where id =:idRecord]){
			DirComFzaVta = DircCom;
			if  (DircCom.DCT_CatalogoFuerzaVenta__c != null)
				setIdFzaVtas.add(DircCom.DCT_CatalogoFuerzaVenta__r.Name);
			if  (DircCom.DCTCatalogoFuerzaVenta2__c != null)
				setIdFzaVtas.add(DircCom.DCTCatalogoFuerzaVenta2__r.Name);			
		}
    	System.debug('EN DCT_Product_ctr setIdFzaVtas: ' + setIdFzaVtas);
    			
		//Inicializa el resto de las varuiables
        mapRTsByDevName = TLCL_Utils_cls.getRecordTypes('DeveloperName');
        String idRecodPlan = mapRTsByDevName.get('DCTAuthorizedLines__c').get('DCTPlan').id;
        System.debug(loggingLevel.Error, '*** idRecord: ' + idRecord);
        System.debug(loggingLevel.Error, '*** idRecodPlan: ' + idRecodPlan);
		
		//Ve por los productos asociados al directorio
		for (DCTDirectoryProductRelationship__c objPaso : [
				SELECT id, Name, DCTProduct__r.Name, 
					DCTProduct__r.DCTKey__c, 
					DCTProduct__r.ServiceID__c, 
					DCTProduct__r.Family,
					DCTProduct__c
				FROM DCTDirectoryProductRelationship__c 
				WHERE DCTCommercialDirectory__c =:idRecord And DCTProduct__c != null
				ORDER BY Name
			]){
			//Agrega los reg a lstDirProd
			lstDirProd.add(objPaso);
			setIdProdExist.add(objPaso.DCTProduct__c);
		}
        System.debug('EN DCT_Product_ctr lstDirProd: ' + lstDirProd);		
        DCTnewProduct = new DCTDirectoryProductRelationship__c(
            DCTCommercialDirectory__c = stdCtr.getid()
        );

        //Busca las lineas autorizads
        for(DCTAuthorizedLines__c objPaso : [SELECT id,
	                Clave__c, 
	                Name, 
	                DCTLineType__c, 
	                DCTPlanType__c, 
	                DCTTerm__c, 
	                DCTPlan__c, 
	                Plan__c,
	                DCTHideAdditionalServices__c
	            FROM DCTAuthorizedLines__c
	            WHERE CommercialDirectory__c = :idRecord 
	            AND RecordTypeId =  :idRecodPlan
	            And Plan__c != null
	            ORDER BY CreatedDate DESC
	        ]){
			lstDCTPlan.add(objPaso);			
        }        
        
        dctNewLine = new DCTAuthorizedLines__c (
            CommercialDirectory__c = idRecord
        );
        blnIsOnclick = false;
        bErrorIns = false;
        
        system.debug('DCTnewProduct: '+DCTnewProduct);
        System.debug(loggingLevel.Error, '*** dctNewLine: ' + dctNewLine);
        
        //Inicializa las variables para el nuevo plan
        slTipoMercado = new List<SelectOption>();
        mapTipoMercado = new Map<String, DCT_TelcelPlanesSoap_ws.planMercado>();
        //slTipoMercado.add(new SelectOption('' , '--Ninguno--'));

        slGrupoPlan = new List<SelectOption>();
        mapGruposPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.grupoPlanMercado>();
        slGrupoPlan.add(new SelectOption('' , '--Ninguno--'));
        
        selPlazos = new List<SelectOption>();
        mapPlazos = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoMercado>();
        selPlazos.add(new SelectOption('' , '--Ninguno--'));

        selPlanes = new List<SelectOption>();
        mapPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoM2K>();
        selPlanes.add(new SelectOption('' , '--Ninguno--'));

        selGuiaPlanes = new List<SelectOption>();
        mapGuiaPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO>();
        selGuiaPlanes.add(new SelectOption('' , '--Ninguno--'));        
        
    }

    public PageReference creaConsecutivoWebSer(){
        System.debug('EN creaConsecutivoWebSer....');
        
        //Crea el consecutivo para el llamado
        slConsecCons = String.valueOf(DCT_Utils_cls.consectivoPlanesYEquipos());

        System.debug('ANTES DE SALIR DE creaConsecutivoWebSer: ' + slConsecCons);
        //Solo null
        return null;
    }   

    public void DespliegaCamposNuevoPlan(){
        System.debug('EN DCT_Product_ctr.DespliegaCamposNuevoPlan slConsecCons: ' + slConsecCons);
        blnIsOnclick = true;
        bErrorIns = false;
        
        //Ve si tiene algo la lista de slTipoMercado
        if (slConsecCons != null){
            
            //Agrega los datos  la lista ditectamente
        	slTipoMercado.add(new SelectOption('' , '--Ninguno--'));                        
			slTipoMercado.add(new SelectOption('2', 'CORPORATIVO')); //1 MASIVO, 3 PRECORPORATIVO			
            
            /*//Llama al WS que consulta los mercados en el controlador de        
            //Manda llamar los metodos del WS de planeas
            DCT_TelcelPlanesSoap_ws.getMercadosResponseDTO MercadosResponseDTOResult = DCT_TelcelPlanesMetodos_ws.ConsultarMercados(slConsecCons, 'CELME');
            System.debug('EN DCT_Product_ctr.DespliegaCamposNuevoPlan objMercadosResponseDTOPaso: ' + MercadosResponseDTOResult);       
            //Ve si no hay error 
            if (MercadosResponseDTOResult.detailResponse != null){            
	            if (MercadosResponseDTOResult.detailResponse.code == '0'){
	                DCT_TelcelPlanesSoap_ws.planesMercadoWSOUTDTO objPlanesMercadoWSOUTDTO = MercadosResponseDTOResult.listaMercados;
	                //Ve si tiene algo la lista de objPlanesMercadoWSOUTDTO.
	                if (!objPlanesMercadoWSOUTDTO.Mercado.isEmpty()){
	                    //Recorre la lista de objPlanesMercadoWSOUTDTO.
	                    for (DCT_TelcelPlanesSoap_ws.planMercado planMercado : objPlanesMercadoWSOUTDTO.Mercado){
	                        System.debug('EN DCT_Product_ctr.DespliegaCamposNuevoPlan planMercado: cveMercado: ' + planMercado.cveMercado + ' ' + planMercado.descripcionMercado);
	                        if (planMercado.descripcionMercado == 'CORPORATIVO'){
		                        slTipoMercado.add(new SelectOption(String.valueOf(planMercado.cveMercado), planMercado.descripcionMercado));
		                        mapTipoMercado.put(String.valueOf(planMercado.cveMercado), planMercado);
		                        sTipoMercadoDesc = planMercado.descripcionMercado;
		                        sTipoMercado = String.valueOf(planMercado.cveMercado);
	                        }
	                    }
	                }//Fin si !objPlanesMercadoWSOUTDTO.Mercado.isEmpty()
	            }//Fin si !MercadosResponseDTOResult.listaMercados.isEmpty()
            }//Fin si MercadosResponseDTOResult.detailResponse.code != null*/
        }//Fin si slTipoMercado.isEmpty()

        System.debug('EN DCT_Product_ctr.DespliegaCamposNuevoPlan sTipoMercado: ' + sTipoMercado);        
        //if (sTipoMercadoDesc == 'CORPORATIVO')
        //	actualizaGrupoPlan();
        
    }

    public PageReference actualizaGrupoPlan(){
        System.debug('ENTRO A actualizaGrupoPlan...');
        System.debug('EN DCT_Product_ctr.actualizaGrupoPlan slConsecCons: ' + slConsecCons + ' ' + sTipoMercado);       
        bErrorIns = false;
		
		sGrupoPlan = null;
        slGrupoPlan = new List<SelectOption>();
        mapGruposPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.grupoPlanMercado>();
        slGrupoPlan.add(new SelectOption('' , '--Ninguno--'));
		
		sPlazos = null;
        selPlazos = new List<SelectOption>();
        mapPlazos = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoMercado>();
        selPlazos.add(new SelectOption('' , '--Ninguno--'));
		
		sPlanes = null;
        selPlanes = new List<SelectOption>();
        mapPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoM2K>();
        selPlanes.add(new SelectOption('' , '--Ninguno--'));
		
		sGuiaPlanes = null;
        selGuiaPlanes = new List<SelectOption>();
        mapGuiaPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO>();
        selGuiaPlanes.add(new SelectOption('' , '--Ninguno--'));        
        
        //Ve si tiene algo la lista de slTipoMercado
        if (slGrupoPlan.size() == 1 && slConsecCons != null && sTipoMercado != null){

       		System.debug('ENTRO A actualizaGrupoPlan setIdFzaVtas: ' + setIdFzaVtas);            
			//Ve si tiene algo la lista de setIdFzaVtas
			if  (!setIdFzaVtas.isEmpty()){
				for (String sNomFzaVta : setIdFzaVtas){
	        		System.debug('ENTRO A actualizaGrupoPlan sNomFzaVta: ' + sNomFzaVta);
		            //Manda llamar los metodos del WS de planeas
		            DCT_TelcelPlanesSoap_ws.getGruposPlanResponseDTO GruposPlanResponseDTOResult = DCT_TelcelPlanesMetodos_ws.ConsultarGruposPlan(slConsecCons, sNomFzaVta, sTipoMercado); //CELME
		            System.debug('EN DCT_Product_ctr.actualizaGrupoPlan objGruposPlanResponseDTOPaso: ' + GruposPlanResponseDTOResult);     
		            //Ve si no hay error 
		            if (GruposPlanResponseDTOResult.detailResponse != null){            
			            if (GruposPlanResponseDTOResult.detailResponse.code == '0'){
			                DCT_TelcelPlanesSoap_ws.grupoPlanesMercadoOUTDTO objgrupoPlanesMercadoOUTDTO = GruposPlanResponseDTOResult.listaGruposPlan;
			                //Ve si tiene algo la lista de objgrupoPlanesMercadoOUTDTO.
			                if (!objgrupoPlanesMercadoOUTDTO.GrupoPlan.isEmpty()){
			                    //Recorre la lista de objgrupoPlanesMercadoOUTDTO.
			                    for (DCT_TelcelPlanesSoap_ws.grupoPlanMercado GruposPlan : objgrupoPlanesMercadoOUTDTO.GrupoPlan){
			                        //System.debug('EN DCT_Product_ctr.actualizaGrupoPlan GruposPlan: ' + GruposPlan);
			                        slGrupoPlan.add(new SelectOption(sNomFzaVta +'-'+ String.valueOf(GruposPlan.cveGrupoPlan), GruposPlan.grupoPlanSubgrupoPlan));
			                        mapGruposPlanes.put(sNomFzaVta +'-'+ String.valueOf(GruposPlan.cveGrupoPlan), GruposPlan);
			                    }
			                }//Fin si !objgrupoPlanesMercadoOUTDTO.Mercado.isEmpty()
			            }//Fin si !GruposPlanResponseDTOResult.listaMercados.isEmpty()
		            }//Fin si MercadosResponseDTOResult.detailResponse.code != null            
				}
			}//Fin si !setIdFzaVtas.isEmpty()
			
        }//Fin si slGrupoPlan.isEmpty() && slConsecCons != null && sTipoMercado != null
		
		//Ve si no tiene nada sTipoMercado
        if (sTipoMercado == null){
        	sTipoMercado = '2';
	        slTipoMercado = new List<SelectOption>();
    	    mapTipoMercado = new Map<String, DCT_TelcelPlanesSoap_ws.planMercado>();        	
        	creaConsecutivoWebSer();
			DespliegaCamposNuevoPlan();
        }//Fin si sTipoMercado == null

        //Solo regresa null
        return null;
    }

    public PageReference actualizaPlazos(){
        System.debug('ENTRO A actualizaPlazos...');
        System.debug('EN DCT_Product_ctr.actualizaPlazos slConsecCons: ' + slConsecCons + ' ' + sTipoMercado + ' ' + sGrupoPlan + ' ');     
        //Hazle un split a sGrupoPlan para que puedas consultar los datos de los plazos
        List<String> lGrupoPlan = sGrupoPlan.split('-');
        System.debug('ENTRO A actualizaPlazos lGrupoPlan: ' + lGrupoPlan);
        
		bErrorIns = false;

		sPlazos = null;
        selPlazos = new List<SelectOption>();
        mapPlazos = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoMercado>();
        selPlazos.add(new SelectOption('' , '--Ninguno--'));
		
		sPlanes = null;
        selPlanes = new List<SelectOption>();
        mapPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoM2K>();
        selPlanes.add(new SelectOption('' , '--Ninguno--'));
		
		sGuiaPlanes = null;
        selGuiaPlanes = new List<SelectOption>();
        mapGuiaPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO>();
        selGuiaPlanes.add(new SelectOption('' , '--Ninguno--'));        
		
        //Ve si tiene algo la lista de slTipoMercado
        if (slConsecCons != null && sTipoMercado != null && sGrupoPlan != null){
            
            //Busca el grupo de plan asociado a sGrupoPlan en mapGruposPlanes
            DCT_TelcelPlanesSoap_ws.grupoPlanMercado GruposPlanCons =  mapGruposPlanes.get(sGrupoPlan);
            System.debug('EN DCT_Product_ctr.actualizaPlazos GruposPlanCons: ' + GruposPlanCons);
            
            //Manda llamar los metodos del WS de planeas
            DCT_TelcelPlanesSoap_ws.getPlazosResponseDTO PlazosResponseDTOResult = DCT_TelcelPlanesMetodos_ws.ConsultarPlazos(slConsecCons, lGrupoPlan.get(0), sTipoMercado, lGrupoPlan.get(1), String.valueOf(GruposPlanCons.cveSubGrupoPlan));
            System.debug('EN DCT_Product_ctr.actualizaPlazos PlazosResponseDTOResult: ' + PlazosResponseDTOResult);     
            
            //Ve si no hay error 
            if (PlazosResponseDTOResult.detailResponse != null){            
	            if (PlazosResponseDTOResult.detailResponse.code == '0'){
	                DCT_TelcelPlanesSoap_ws.planPlazoFVMercadoOUTDTO objplanPlazoFVMercadoOUTDTO = PlazosResponseDTOResult.listaPlazos;
	                //Ve si tiene algo la lista de objplanPlazoFVMercadoOUTDTO.
	                if (!objplanPlazoFVMercadoOUTDTO.Plazo.isEmpty()){
	                    //Recorre la lista de objplanPlazoFVMercadoOUTDTO.
	                    for (DCT_TelcelPlanesSoap_ws.planPlazoMercado PlazoMercado : objplanPlazoFVMercadoOUTDTO.Plazo){
	                        System.debug('EN DCT_Product_ctr.actualizaPlazos PlazoMercado: ' + PlazoMercado);
	                        selPlazos.add(new SelectOption(lGrupoPlan.get(0) + '-' + String.valueOf(PlazoMercado.cvePlazo), PlazoMercado.descripcionPlazo));
	                        mapPlazos.put(lGrupoPlan.get(0) + '-' + String.valueOf(PlazoMercado.cvePlazo), PlazoMercado);
	                    }
	                }//Fin si !objplanPlazoFVMercadoOUTDTO.Mercado.isEmpty()
	            }//Fin si !PlazosResponseDTOResult.listaMercados.isEmpty()
            }//Fin si MercadosResponseDTOResult.detailResponse.code != null
            
        }//Fin si slGrupoPlan.isEmpty() && slConsecCons != null && sTipoMercado != null

        //Solo regresa null
        return null;
    }

    public PageReference actualizaPlanes(){
        System.debug('ENTRO A ConsultarPlanes...');
        System.debug('EN DCT_Product_ctr.actualizaPlanesslConsecCons: ' + slConsecCons + ' ' + sTipoMercado + ' ' + sGrupoPlan + ' ' + sPlazos);     
        List<String> lGrupoPlan = sGrupoPlan!= null ? sGrupoPlan.split('-') : new List<String>();
        List<String> lPlazos = sPlazos != null ? sPlazos.split('-') : new List<String>();
        System.debug('ENTRO A actualizaPlazos lGrupoPlan: ' + lGrupoPlan + ' lPlazos: ' + lPlazos);
        
		bErrorIns = false;
		sPlanes = null;
        selPlanes = new List<SelectOption>();
        mapPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoM2K>();
        selPlanes.add(new SelectOption('' , '--Ninguno--'));
		
		sGuiaPlanes = null;
        selGuiaPlanes = new List<SelectOption>();
        mapGuiaPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO>();
        selGuiaPlanes.add(new SelectOption('' , '--Ninguno--'));        
		
        //Ve si tiene algo la lista de slTipoMercado
        if (slConsecCons != null && sTipoMercado != null && sGrupoPlan != null && sPlazos != null){
            
            //Busca el grupo de plan asociado a sGrupoPlan en mapGruposPlanes
            DCT_TelcelPlanesSoap_ws.grupoPlanMercado GruposPlanCons =  mapGruposPlanes.get(sGrupoPlan);
            System.debug('EN DCT_Product_ctr.actualizaPlanes GruposPlanCons: ' + GruposPlanCons);

            //Busca el grupo de plan asociado a sGrupoPlan en mapGruposPlanes
            DCT_TelcelPlanesSoap_ws.planPlazoMercado PlazoMercadoCons =  mapPlazos.get(sPlazos);
            System.debug('EN DCT_Product_ctr.actualizaPlanes PlazoMercadoCons : ' + PlazoMercadoCons );
            
            //Manda llamar los metodos del WS de planeas
            DCT_TelcelPlanesSoap_ws.getPlanesResponseDTO PlanesResponseDTOResult = DCT_TelcelPlanesMetodos_ws.ConsultarPlanes(slConsecCons, lGrupoPlan.get(0), sTipoMercado, String.valueOf(PlazoMercadoCons.cvePlazo), lGrupoPlan.Get(1), String.valueOf(GruposPlanCons.cveSubGrupoPlan));
            System.debug('EN DCT_Product_ctr.actualizaPlanes PlanesResponseDTOResult: ' + PlanesResponseDTOResult);       
            
            //Ve si no hay error
            if (PlanesResponseDTOResult.detailResponse != null){            
	            if (PlanesResponseDTOResult.detailResponse.code == '0'){
	                DCT_TelcelPlanesSoap_ws.getPlanesOUTDTO objgetPlanesOUTDTO = PlanesResponseDTOResult.listaPlanes;
	                //Ve si tiene algo la lista de objgetPlanesOUTDTO.
	                if (!objgetPlanesOUTDTO.plan.isEmpty()){
	                    //Recorre la lista de objgetPlanesOUTDTO.
	                    for (DCT_TelcelPlanesSoap_ws.planPlazoM2K PlanMercado : objgetPlanesOUTDTO.plan){
	                        System.debug('EN DCT_Product_ctr.actualizaPlanes PlanMercado : ' + PlanMercado );
	                        selPlanes.add(new SelectOption(lPlazos.get(0) + '-' + String.valueOf(PlanMercado.cvePlanM2k), PlanMercado.descripcionPlan));
	                        mapPlanes.put(lPlazos.get(0) + '-' + String.valueOf(PlanMercado.cvePlanM2k), PlanMercado);                        
	                    }
	                }//Fin si !objgetPlanesOUTDTO.Mercado.isEmpty()
	            }//Fin si !PlanesResponseDTOResult.listaMercados.isEmpty()
            }//Fin si MercadosResponseDTOResult.detailResponse.code != null            

        }//Fin si slGrupoPlan.isEmpty() && slConsecCons != null && sTipoMercado != null

        //Solo regresa null
        return null;
    }

    public PageReference actualizaGuiaPlanes(){
        System.debug('ENTRO A actualizaGuiaPlanes...');
        System.debug('EN DCT_Product_ctr.actualizaGuiaPlanes : ' + slConsecCons + ' ' + sTipoMercado + ' ' + sGrupoPlan + ' ' + sPlazos + ' ' + sPlanes);
        List<String> lPlanes = sPlanes.split('-');
        System.debug('ENTRO A actualizaGuiaPlanes lPlanes: ' + lPlanes);
		bErrorIns = false;

		sGuiaPlanes = null;
        selGuiaPlanes = new List<SelectOption>();
        mapGuiaPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO>();
        selGuiaPlanes.add(new SelectOption('' , '--Ninguno--'));        
		
        //Ve si tiene algo la lista de slTipoMercado
        if (slConsecCons != null && sTipoMercado != null && sGrupoPlan != null && sPlanes != null){

            //Busca el grupo de plan asociado a sGrupoPlan en mapGruposPlanes
            DCT_TelcelPlanesSoap_ws.planPlazoM2K PlanMercadoCons = mapPlanes.get(sPlanes);
            System.debug('EN DCT_Product_ctr.actualizaGuiaPlanesPlanMercadoCons: ' + PlanMercadoCons );

            //Manda llamar los metodos del WS de planeas
            DCT_TelcelPlanesSoap_ws.getGuiaPlanesResponseDTO GuiaPlanesResponseDTOResult = DCT_TelcelPlanesMetodos_ws.ConsultarGuiaPlanes(slConsecCons, lPlanes.get(0), lPlanes.get(1));
            System.debug('EN DCT_Product_ctr.actualizaGuiaPlanesGuiaPlanesResponseDTOResult: ' + GuiaPlanesResponseDTOResult);        
            
            //Ve si no hay error
            if (GuiaPlanesResponseDTOResult.detailResponse != null){            
	            if (GuiaPlanesResponseDTOResult.detailResponse.code == '0'){
	                DCT_TelcelPlanesSoap_ws.guiaPlanesOUTDTO objguiaPlanesOUTDTO = GuiaPlanesResponseDTOResult.listaPlanes;
	                //Despliega los objetos         
	                System.debug('EN DCT_Product_ctr.actualizaGuiaPlanes objguiaPlanesOUTDTO.caracteristicas: ' + objguiaPlanesOUTDTO.caracteristicas);
	                //System.debug('EN DCT_AccountOwnerAssignment_cls.pruebaLoginTelcel objguiaPlanesOUTDTO.servicios: ' + objguiaPlanesOUTDTO.servicios);
	                DCT_TelcelPlanesSoap_ws.ArrayOfGuiaPlanesServiciosDTO objArrayOfGuiaPlanesServiciosDTO = objguiaPlanesOUTDTO.servicios;
	                //Recorre la lista de servicios
	                if (!objArrayOfGuiaPlanesServiciosDTO.servicio.isEmpty()){
	                    for (DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO objGuiaPlanesServiciosDTO : objArrayOfGuiaPlanesServiciosDTO.servicio){
	                        System.debug('EN DCT_Product_ctr.actualizaGuiaPlanes objGuiaPlanesServiciosDTO: ' + objGuiaPlanesServiciosDTO);                    
	                        selGuiaPlanes.add(new SelectOption(lPlanes.get(0) + '-' + String.valueOf(objGuiaPlanesServiciosDTO.id), objGuiaPlanesServiciosDTO.tipoServicio + ' - '  + objGuiaPlanesServiciosDTO.descripcion));
	                        mapGuiaPlanes.put(lPlanes.get(0) + '-' + objGuiaPlanesServiciosDTO.id, objGuiaPlanesServiciosDTO);
	                    }
	                }//Fin si !objArrayOfGuiaPlanesServiciosDTO.servicio.isEmpty()
	            }//Fin si !GuiaPlanesResponseDTOResult.listaMercados.isEmpty()*/
            }//Fin si MercadosResponseDTOResult.detailResponse.code != null            

        }//Fin si slGrupoPlan.isEmpty() && slConsecCons != null && sTipoMercado != null
            
        //Solo regresa null
        return null;
    }

    public PageReference validaTipoServ(){
    	System.debug('EN validaTipoServ: ');
		bErrorIns = false;
		    	
		return null;
    }
             
    public PageReference refreshTable(){
    	System.debug('EN refreshTable: ' + bErrorIns);
    	if (!bErrorIns){
	        Cliente__c newClient = new Cliente__c(id = idRecord);
	        PageReference pr = new ApexPages.StandardController(newClient).view();  
	        pr.setRedirect(true);
	        return pr;	        
    	}//FIN SI !bErrorIns
    	//Solo null
		return null;
    }
    
    public void saveProduct(){
        System.debug('EN DCT_Product_ctr.DCTnewProduct: '+ DCTnewProduct);

		//Si no selecciono un producto
		if (DCTnewProduct.DCTProduct__c == null){
			System.debug('EN DCT_ComercialDirectory_ctr.saveProduct GENERANDO EL ERROR.');			
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Debes seleccionar almenos un Producto.'));			
			blnIsOnclick2= true;
		}//Fin si DCTnewProduct.DCTCommercialDirectory__c == null
		//Ve si selecciono un producto
		if (DCTnewProduct.DCTProduct__c != null){        
			//Ve si ya esta asociado al cliente este producto
			if (setIdProdExist.contains(DCTnewProduct.DCTProduct__c))
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'El producto ya esta asociado el directorio comercial.'));										
			//Fin si !setIdProdExist.contains(DCTnewProduct.DCTProduct__c
			if (!setIdProdExist.contains(DCTnewProduct.DCTProduct__c)){			
		        Database.SaveResult sr = Database.insert(DCTnewProduct, true);
				if(sr.isSuccess()){
					//Ve por los productos asociados al directorio
					for (DCTDirectoryProductRelationship__c objPaso : [
							SELECT id, Name, DCTProduct__r.Name, 
								DCTProduct__r.DCTKey__c, 
								DCTProduct__r.ServiceID__c, 
								DCTProduct__r.Family,
								DCTProduct__c
							FROM DCTDirectoryProductRelationship__c 
							WHERE id =:sr.getId() And DCTProduct__c != null
							ORDER BY Name
						]){
						//Agrega los reg a lstDirProd
						lstDirProd.add(objPaso);
						setIdProdExist.add(objPaso.DCTProduct__c);
					}					
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'El producto se asocio correctamente al cliente.'));						
					blnIsOnclick2 = false;
					DCTnewProduct = new DCTDirectoryProductRelationship__c();
			        dctNewLine = new DCTAuthorizedLines__c (
			            CommercialDirectory__c = idRecord
			        );					
				}//Fin si sr.isSuccess()
				if(!sr.isSuccess()){
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Error a la hora de asocuiar el producto con el directorio comercial, ERROR:' + sr.getErrors()[0].getMessage()));
					blnIsOnclick2 = true;
				}//Fin si !sr.isSuccess()
			}//Fin si !setIdProdExist.contains(DCTnewProduct.DCTProduct__c
		}//Fin si DCTnewProduct.DCTProduct__c != null
        
    }

    public void watchField2(){
        blnIsOnclick2= true;
    }

    public void savePlans(){
    	System.debug('EN savePlans...');
		String sRt = Schema.SObjectType.DCTAuthorizedLines__c.getRecordTypeInfosByName().get('Plan').getRecordTypeId();		
		Boolean bExietPlan = false;
		Boolean bTieneRegLinAut = false;		
		sError = null;
    	System.debug('EN savePlans sTipoMercado: ' + sTipoMercado);    	

        List<String> lGrupoPlan = sGrupoPlan != null ? sGrupoPlan.split('-') : new List<String>();    	
    	System.debug('EN savePlans sGrupoPlan: ' + sGrupoPlan + ' lGrupoPlan: ' + lGrupoPlan);    	
        List<String> lPlazos = sPlazos != null ? sPlazos.split('-') : new List<String>();    	
    	System.debug('EN savePlans sPlazos: ' + sPlazos + ' lPlazos: ' + lPlazos);
        List<String> lPlanes = sPlanes != null ? sPlanes.split('-') : new List<String>();
    	System.debug('EN savePlans sPlanes: ' + sPlanes + ' lPlanes: ' + lPlanes);
        List<String> lGuiaPlanes = sGuiaPlanes != null ? sGuiaPlanes.split('-') : new List<String>();    	
    	System.debug('EN savePlans sGuiaPlanes: ' + sGuiaPlanes + ' lGuiaPlanes: ' + lGuiaPlanes);
		Set<String> setIdGuiaPlan = new Set<String>();
		
        Boolean blnWasThereanException = false;
        String strErrorMsg = '';
        
        //Valida que haya capturado todos los campos
        if (ValidaDatosEntrada()){
 
			//Ve si ya existe un registro con esos datos del plan
			for (DCTAuthorizedLines__c plan : [Select Plan__r.TipoMercado__c, Plan__r.ClaveGrupoPlan__c, 
				Plan__r.ClavePlazo__c, Plan__r.ClavePlan__c, Plan__r.ClaveDetallePlan__c, RecordTypeId
				From DCTAuthorizedLines__c Where Plan__r.TipoMercado__c =: sTipoMercado 
				And Plan__r.ClaveGrupoPlan__c =: lGrupoPlan.get(1)
				And Plan__r.ClavePlazo__c =: lPlazos.get(1)
				And Plan__r.ClavePlan__c =: lPlanes.get(1)
				And CommercialDirectory__c =: idRecord
				And RecordTypeId =: sRt]){
				bTieneRegLinAut = true;	
			} 
    		System.debug('EN savePlans setIdGuiaPlan: ' + setIdGuiaPlan);
    		
			//Ve si tiene reg la consulta	    					
			if (bTieneRegLinAut)
				bExietPlan = true;
			//Si existe el plan despliega el msg
			if(bExietPlan){
				sError = '' + 'Ya existe un plan con esos datos.';			
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, ' ' + sError));				
			}
    		System.debug('EN savePlans bExietPlan: ' + bExietPlan + ' sError: ' + sError);
    				
			//Ve si no tienen un plan ya asociado del mismo
			if (!bExietPlan){
				Savepoint sp = Database.setSavePoint();
										        
		        //Crea el objeto del tipo DCTPlan__c
		        DCTPlan__c objDCTPlanNuevo = new DCTPlan__c();
		        objDCTPlanNuevo.Name = mapPlanes.get(sPlanes).descripcionPlan;	        
		        objDCTPlanNuevo.DCTCode__c = lPlanes.get(1); //
		        objDCTPlanNuevo.DCTTerm__c = mapPlazos.get(sPlazos).descripcionPlazo;
		        objDCTPlanNuevo.DCTTypeofLine__c = mapGuiaPlanes.containsKey(sGuiaPlanes) ? mapGuiaPlanes.get(sGuiaPlanes).tipoServicio : null;
				objDCTPlanNuevo.ClaveFuerzaVenta__c = lPlanes.get(0);
		        objDCTPlanNuevo.TipoMercado__c = sTipoMercado;
				objDCTPlanNuevo.ClaveMercado__c = sTipoMercado;
		        objDCTPlanNuevo.ClaveGrupoPlan__c = lGrupoPlan.get(1);
		        objDCTPlanNuevo.ClavePlazo__c = lPlazos.get(1);
		        objDCTPlanNuevo.ClavePlan__c = lPlanes.get(1);
		        objDCTPlanNuevo.ClaveDetallePlan__c = sGuiaPlanes != null ? lGuiaPlanes.get(1) : null;
		        objDCTPlanNuevo.DescripcionServcicio__c = mapGuiaPlanes.containsKey(sGuiaPlanes) ? (mapGuiaPlanes.get(sGuiaPlanes).tipoServicio +' : '+ mapGuiaPlanes.get(sGuiaPlanes).descripcion): null;
		        //Crea la linea 
		        insert objDCTPlanNuevo;
	    		System.debug('EN savePlans objDCTPlanNuevo.id: ' + objDCTPlanNuevo.id);
	    		        	        
		        //Actualiza el objeto intermedio con esta id de la nueva linea
		        dctNewLine.Plan__c = objDCTPlanNuevo.id;
				//Actualiza el resto de los datos
		        dctNewLine.Name = mapPlanes.get(sPlanes).descripcionPlan;
		        dctNewLine.Clave__c = lPlanes.get(1);
		        dctNewLine.DCTTerm__c = mapPlazos.get(sPlazos).descripcionPlazo;
		        dctNewLine.DCTLineType__c = mapGuiaPlanes.containsKey(sGuiaPlanes) ? mapGuiaPlanes.get(sGuiaPlanes).tipoServicio : null;
		        dctNewLine.RecordTypeId = sRt;
		        
		        //System.debug(loggingLevel.Error, '*** recordDC.OwnerId: ' + recordDC.OwnerId);
		        List<DCTPlan__c> lstPlan = [
		            SELECT DCTCode__c, DCTTerm__c, DCTTypeofPlan__c, DCTTypeofLine__c, Name
		            FROM DCTPlan__c
		            WHERE id = :dctNewLine.Plan__c
		            LIMIT 1
		        ];
		
		        Cliente__c idOwner = [
		            SELECT OwnerId
		            FROM Cliente__c
		            WHERE id = :idRecord
		            LIMIT 1
		        ];
		        System.debug(loggingLevel.Error, '*** idOwner: ' + idOwner);
		        
		        List<User> lstUserManager = [
		            SELECT Id, ManagerId, Manager.ManagerId 
		            FROM User 
		            WHERE Id = :idOwner.OwnerId
		        ];
		        System.debug(loggingLevel.Error, '*** lstUserManager: ' + lstUserManager);        
		        System.debug(loggingLevel.Error, '*** lstPlan: ' + lstPlan);
		        
		        if(!lstUserManager.isEmpty()) {
		            for(User userIterator: lstUserManager) {
		                dctNewLine.DCTSubdirector__c = userIterator.Manager.ManagerId;
		            }
		        }
		        System.debug(loggingLevel.Error, '*** dctNewLine: ' + dctNewLine);
		        
		        Database.SaveResult sr = Database.insert(dctNewLine, true);
		        if(sr.isSuccess()){
		        	
		            System.debug('Se Guardo Exitosamente idRecord: ' + idRecord + ' sRt: ' + sRt + ' sr.getId(): ' + sr.getId());
		            lstDCTPlan = new List<DCTAuthorizedLines__c>(); 
			        //Busca las lieas autorizads
			        for(DCTAuthorizedLines__c objPaso : [  SELECT id,
				                Clave__c, 
				                Name, 
				                DCTLineType__c, 
				                DCTPlanType__c, 
				                DCTTerm__c, 
				                DCTPlan__c, 
				                Plan__c ,
				                DCTHideAdditionalServices__c 
				            FROM DCTAuthorizedLines__c
				            WHERE CommercialDirectory__c = :idRecord 
				            AND RecordTypeId = :sRt
				            ORDER BY CreatedDate DESC
				        ]){
						lstDCTPlan.add(objPaso);			
			        }
			        
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'El nuevo plan se creo correctamente.'));						
					blnIsOnclick = false;
					
					dctNewLine = new DCTAuthorizedLines__c();
		            dctNewLine.CommercialDirectory__c = idRecord;
					            
		            //Inicializa los campos para los planes
			        slTipoMercado = new List<SelectOption>();
	        		mapTipoMercado = new Map<String, DCT_TelcelPlanesSoap_ws.planMercado>();
	        		sTipoMercado = null;
	
		    		sGrupoPlan = null;            
			        slGrupoPlan = new List<SelectOption>();
			        mapGruposPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.grupoPlanMercado>();
			        slGrupoPlan.add(new SelectOption('' , '--Ninguno--'));
		    	        
					sPlazos = null;
			        selPlazos = new List<SelectOption>();
			        mapPlazos = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoMercado>();
			        selPlazos.add(new SelectOption('' , '--Ninguno--'));
			
					sPlanes = null;
			        selPlanes = new List<SelectOption>();
			        mapPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.planPlazoM2K>();
			        selPlanes.add(new SelectOption('' , '--Ninguno--'));
		
					sGuiaPlanes = null;	
			        selGuiaPlanes = new List<SelectOption>();
			        mapGuiaPlanes = new Map<String, DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO>();
			        selGuiaPlanes.add(new SelectOption('' , '--Ninguno--'));
					
		        }//Fin si sr.isSuccess()
				
				//Regresa todo lo que creaste        	
				//Database.rollback(sp);
        	}//Fin si !bExietPlan
         		        
        }else //Fin si ValidaDatosEntrada()
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, ' ' + sError));        
           
    }
    
	public Boolean ValidaDatosEntrada(){
		System.debug('ENTRO A ValidaDatosEntrada...');
		Boolean bErrorPaso = false;
		sError = '';
		
		//Ve si faltan datos de capturar
		if (sTipoMercado == null)
			sError = '' + 'Te falta capturar el tipo de mercado.';		
		if (sGrupoPlan == null)
			sError += '' + 'Te falta capturar el grupo.';
		if (sPlazos == null)
			sError += '' + 'Te falta capturar el plazo.';
		if (sPlanes == null)
			sError += '' + 'Te falta capturar el plan.';
		//if (sGuiaPlanes == null)
		//	sError += '' + 'Te falta capturar el tipo de servicio.';

		if (sError != null && sError != ''){
			bErrorPaso = true;
			bErrorIns = true;
			sError = sError.replaceAll('null', '');
		}

		System.debug('ENTRO A ValidaDatosEntrada sError: ' + sError);
		System.debug('ENTRO A ValidaDatosEntrada bErrorPaso: ' + bErrorPaso);		
		return !bErrorPaso;
	}
    
    
    
    
}