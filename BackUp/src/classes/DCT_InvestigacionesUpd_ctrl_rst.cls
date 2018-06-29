public with sharing class DCT_InvestigacionesUpd_ctrl_rst {

	public static ResultadoSfdc objResultadoSfdc {get;set;}
	public static List<Error> lErrores {get;set;}
	public static DatosEntrada objDatosEntrada {get;set;}
	public static Cliente__c DirComUpd {get;set;}
	
	public class ResultadoSfdc{
		public Boolean esExitoso;
		public String idSfdc;
		public List<Error> errorLista;
	}

	public class Error{
		public String codigo;
		public String descripcion;
		public Error(String strCode, String strDescr){
			codigo = strCode;
			descripcion = strDescr;
		}
	}

	public class DatosEntrada{
		public String RazonSocial {get;set;}
		public String Rfc {get;set;}
		public Integer TotalLineasAutorizadas {get;set;}		
		public String ClaveInvestigacion {get;set;}
		public String EstatusInvestigacion {get;set;}
	}

	public static String updInvestigaciones(String sDatosEntrada){
		System.debug('ENTRO A DCT_InvestigacionesUpd_ctrl_rst.updInvestigaciones sDatosEntrada: ' + sDatosEntrada);
		String sResultadoSfdc = '';
		
		objResultadoSfdc = new ResultadoSfdc();
		lErrores = new List<Error>();
		
		Boolean bValidaDatosEntrada = ValidaDatos(sDatosEntrada);
		
		//Valida los datos y ve si hay errores
		if (bValidaDatosEntrada){
			
			//Busca el registro de la empresa
			for (Cliente__c dirCom : [Select id, Name From Cliente__c 
				Where Name =:objDatosEntrada.RazonSocial.toUpperCase() And RFC__c =:objDatosEntrada.Rfc]){
				DirComUpd = new Cliente__c(id = dirCom.id);	
				DirComUpd.DCTTotLineasAutorInvest__c = String.valueOf(objDatosEntrada.TotalLineasAutorizadas);
				DirComUpd.DCTInvestigation__c = objDatosEntrada.ClaveInvestigacion;
				DirComUpd.DCTResultVerification__c = objDatosEntrada.EstatusInvestigacion;
			}//Fin del for para los datos de la consulta de la empresa
			
			//Ve si tiene algo el objeto de DirComUpd
			if (DirComUpd != null){
				Database.Saveresult objDtsv = Database.update(DirComUpd);
				if (!objDtsv.isSuccess()){
					objResultadoSfdc.esExitoso = false;
					objResultadoSfdc.idSfdc = null;
					lErrores.Add(new Error('01', objDtsv.getErrors()[0].getMessage()));					
					objResultadoSfdc.errorLista = lErrores;					

				}//Fin si !objDtsv.isSuccess()
				if (objDtsv.isSuccess()){
					objResultadoSfdc.esExitoso = true;
					objResultadoSfdc.idSfdc = objDtsv.getId();
					objResultadoSfdc.errorLista = lErrores;
				}//Fin si objDtsv.isSuccess()
			}//Fin si DirComUpd != null
			
			//No existe la empresa en SFDC
			if (DirComUpd == null){
				objResultadoSfdc.esExitoso = false;
				objResultadoSfdc.idSfdc = null;
				lErrores.Add(new Error('01', 'No existe la empresa con el nombre: ' + objDatosEntrada.RazonSocial.toUpperCase() + ' en el Directorio Comercial'));					
				objResultadoSfdc.errorLista = lErrores;
			}//Fin si DirComUpd == null
			
		}//Fin si ValidaDatos(sDatosEntrada)
		
		//Hubo errores de validación de datos
		if (!bValidaDatosEntrada){
			objResultadoSfdc.esExitoso = false;
			objResultadoSfdc.idSfdc = null;
			objResultadoSfdc.errorLista = lErrores;
		}//Fin si !ValidaDatos(sDatosEntrada)		
				
		//Crea el JSON DE salida
		sResultadoSfdc = JSON.serialize(objResultadoSfdc);
		System.debug('EN DCT_InvestigacionesUpd_ctrl_rst.updInvestigaciones sResultadoSfdc: ' + sResultadoSfdc);
		
		//Regresa el mensaje de error
		return sResultadoSfdc;
	}

	public static boolean ValidaDatos(String sDatosEntrada){
		System.debug('EN DCT_InvestigacionesUpd_ctrl_rst.ValidaDatos sDatosEntrada: ' + sDatosEntrada);
		
		Boolean bError = true;
		objDatosEntrada = new DatosEntrada();
		
		try{
			//Deserializa kla cadena con los datos de entrada
			objDatosEntrada = (DatosEntrada)JSON.deserialize(sDatosEntrada, DatosEntrada.class);
			System.debug('EN DCT_InvestigacionesUpd_ctrl_rst.ValidaDatos objDatosEntrada: ' + objDatosEntrada);
			//Ve si no tiene nada el campo de RazonSocial
			if (objDatosEntrada.RazonSocial == null || objDatosEntrada.RazonSocial == '')
				lErrores.Add(new Error('01', 'Debes capturar un valor en el campo de: RazonSocial'));					
			if (objDatosEntrada.Rfc == null || objDatosEntrada.Rfc == '')
				lErrores.Add(new Error('02', 'Debes capturar un valor en el campo de: TotalLineasAutorizadas'));					

			if ( (objDatosEntrada.TotalLineasAutorizadas == null || objDatosEntrada.TotalLineasAutorizadas == 0)
				 &&	(objDatosEntrada.ClaveInvestigacion == null || objDatosEntrada.ClaveInvestigacion == '')
				 &&	(objDatosEntrada.EstatusInvestigacion == null || objDatosEntrada.EstatusInvestigacion == '')				 
				)
				lErrores.Add(new Error('03', 'Debes capturar al menos un un valor en alguno de estos campos: Tot. Lineas Autor Invest., Clave Investigación o Estatus Investigación'));					
				
			/*if (objDatosEntrada.ClaveInvestigacion == null || objDatosEntrada.ClaveInvestigacion == '')
				lErrores.Add(new Error('03', 'Debes capturar un valor en el campo de: Clave Investigación'));					
			if (objDatosEntrada.EstatusInvestigacion == null || objDatosEntrada.EstatusInvestigacion == '')
				lErrores.Add(new Error('04', 'Debes capturar un valor en el campo de: Estatus Investigación'));
			*/
				
			if (!lErrores.isEmpty())	
				bError = false;			
		}catch(Exception ex){
			lErrores.Add(new Error('00', ex.getMessage()));
			bError = false;
			System.debug('EN DCT_InvestigacionesUpd_ctrl_rst.ValidaDatos ex.getMessage(): ' + ex.getMessage());			
		}
		
		return bError;
	}

}