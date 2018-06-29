public class DCT_SecurityServices_cls {
	@testVisible private static String STR_TOKEN_CONFIG_CODE = System.Label.DCT_Login;

    public static DCT_ServiceTokenResponse_wpr objTokenWrapper = null;
    public static String strDecryptedToken = null;
    
    // Cargar los mainsettings para las clases de prueba
   public static AppMainSetting_cs__c mainSettings = AppMainSetting_cs__c.getOrgDefaults();

    /**
     * Obtener token para consumir servicio web
     * @param  tokenUsername Usuario para generar token
     * @param  tokenPassword Contraseña para generar token
     * @return strPlainToken Token en texto plano
    **/

    public static String getPlainToken()
    {
        String strPlainToken = null; 
        DCT_Utils_cls.DtRespuestaTelcel objDtRespuestaTelcel = DCT_Utils_cls.LoginTelcel();
        //DCT_SecurityServices_cls.objTokenWrapper = DCT_SecurityServices_cls.getServiceToken();
        strPlainToken = objDtRespuestaTelcel.access_token;
        //strPlainToken = DCT_SecurityServices_cls.objTokenWrapper;
        System.debug(loggingLevel.Error, '*** strPlainToken: ' + strPlainToken);
        return strPlainToken;
    }

    /**
     * Metodo que realiza el REQUEST al servicio de TOKEN por parte de TIBCO.
     * @param  tokenUsername Usuario para generar token
     * @param  tokenPassword Contraseña para generar token
     * @param  accessType    Tipo de acceso (application/system)
     * @return               Objeto de respuesta del servicio con información del token
    **/

    public static DCT_ServiceTokenResponse_wpr getServiceToken() {
        
        DCT_ServiceTokenResponse_wpr tokenWrapper = new DCT_ServiceTokenResponse_wpr();
        EndpointSetting__mdt tknEndpointSetting = new EndpointSetting__mdt();
        try{tknEndpointSetting = TLCL_Utils_cls.getEndpointSetting(STR_TOKEN_CONFIG_CODE);}catch(Exception ex){return tokenWrapper;}
        Http tokenClient = new Http();
        HttpRequest tokenRequest = new HttpRequest();
        tokenRequest.setEndpoint(DCT_GenericCallout_cls.getEndpoint(tknEndpointSetting));
        tokenRequest.setMethod(tknEndpointSetting.ServiceMethod__c);
        tokenRequest.setHeader('Content-Type', tknEndpointSetting.RequestBodyType__c);
        tokenRequest.setBody(
            'grant_type='+mainSettings.grant_type__c +
            '&client_id='+mainSettings.client_id__c+
            '&client_secret='+mainSettings.client_secret__c
        ); 
        HttpResponse tokenResponse = new HttpResponse();
        tokenResponse = tokenClient.send(tokenRequest);
        System.debug('token response body : '+tokenResponse.getBody());
        //try {tokenWrapper = DCT_ServiceTokenResponse_wpr.parse(tokenResponse.getBody());}catch (Exception e){}
        return tokenWrapper;
    }

    /**
     * Metodo que realiza el REQUEST al servicio de TOKEN por parte de TIBCO con accessType por defecto "application".
     * @param  tokenUsername Usuario para generar token
     * @param  tokenPassword Contraseña para generar token
     * @return Objeto de respuesta del servicio con información del token
    **/



    /**
     * Encriptar contraseña de usuario
     * @param  password  Contraseña a encriptar
     * @param  aesKey    Llave AES
     * @param  algorithm Algoritmo de cifrado
     * @return           Contraseña encriptada
    **/

    public static String encryptPassword(String password, String aesKey, String algorithm) {
        String strEncryptedPassword = null; System.debug('this is ** '+aesKey);
        Blob cryptoKey = EncodingUtil.base64Decode(aesKey);
        Blob data = Blob.valueOf(password);
        Blob encryptedData = Crypto.encryptWithManagedIV(algorithm, cryptoKey, data);
        strEncryptedPassword = EncodingUtil.base64Encode(encryptedData);
        return strEncryptedPassword;
    }

    /**
     * Desencriptar contraseña de usuario
     * @param  password  Contraseña a desencriptar
     * @param  aesKey    Llave AES
     * @param  algorithm Algoritmo de cifrado
     * @return           Contraseña desencriptada
    **/

    public static String decryptPassword(String password, String aesKey, String algorithm) {
        String strDecryptedPassword = null;
        Blob cryptoKey = EncodingUtil.base64Decode(aesKey);
        Blob data = EncodingUtil.base64Decode(password);
        Blob decryptedData = Crypto.decryptWithManagedIV(algorithm, cryptoKey, data);
        strDecryptedPassword = decryptedData.toString();
        return strDecryptedPassword;
    }
}