//Generated by wsdl2apex

public class DCT_TelcelEquiposSoapOrg_ws {
    public class ConsultarModelos_element {
        public String pMensajeID;
        public String pFuerzaVentaM2K;
        public Integer pMarcaClave;
        private String[] pMensajeID_type_info = new String[]{'pMensajeID','http://tempuri.org/',null,'0','1','false'};
        private String[] pFuerzaVentaM2K_type_info = new String[]{'pFuerzaVentaM2K','http://tempuri.org/',null,'0','1','false'};
        private String[] pMarcaClave_type_info = new String[]{'pMarcaClave','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'pMensajeID','pFuerzaVentaM2K','pMarcaClave'};
    }
    public class ConsultarInformacionModeloResponse_element {
        public DCT_TelcelEquiposSoap_ws.getInformacionModeloResponseDTO ConsultarInformacionModeloResult;
        private String[] ConsultarInformacionModeloResult_type_info = new String[]{'ConsultarInformacionModeloResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'ConsultarInformacionModeloResult'};
    }
    public class ConsultarMarcasResponse_element {
        public DCT_TelcelEquiposSoap_ws.getMarcasResponseDTO ConsultarMarcasResult;
        private String[] ConsultarMarcasResult_type_info = new String[]{'ConsultarMarcasResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'ConsultarMarcasResult'};
    }
    public class ConsultarModelosResponse_element {
        public DCT_TelcelEquiposSoap_ws.getModelosResponseDTO ConsultarModelosResult;
        private String[] ConsultarModelosResult_type_info = new String[]{'ConsultarModelosResult','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'ConsultarModelosResult'};
    }
    public class ConsultarMarcas_element {
        public String pMensajeID;
        public String pFuerzaVentaM2K;
        private String[] pMensajeID_type_info = new String[]{'pMensajeID','http://tempuri.org/',null,'0','1','false'};
        private String[] pFuerzaVentaM2K_type_info = new String[]{'pFuerzaVentaM2K','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'pMensajeID','pFuerzaVentaM2K'};
    }
    public class ConsultarInformacionModelo_element {
        public String pMensajeID;
        public String pFuerzaVentaM2K;
        public String pModeloClave;
        private String[] pMensajeID_type_info = new String[]{'pMensajeID','http://tempuri.org/',null,'0','1','false'};
        private String[] pFuerzaVentaM2K_type_info = new String[]{'pFuerzaVentaM2K','http://tempuri.org/',null,'0','1','false'};
        private String[] pModeloClave_type_info = new String[]{'pModeloClave','http://tempuri.org/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'pMensajeID','pFuerzaVentaM2K','pModeloClave'};
    }
    public class EquiposSoap {
        public String endpoint_x = 'https://www.region9.telcel.com/smartdistribuidores/PORTALES/PreciosSOAP/Equipos.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/equipos', 'DCT_TelcelEquiposSoap_ws', 'http://amx.com/mexico/telcel/esb/v1_1', 'DCT_TelcelEquiposSoapEsb_ws', 'http://tempuri.org/', 'DCT_TelcelEquiposSoapOrg_ws'};
        public DCT_TelcelEquiposSoap_ws.getInformacionModeloResponseDTO ConsultarInformacionModelo(String pMensajeID,String pFuerzaVentaM2K,String pModeloClave) {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModelo_element request_x = new DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModelo_element();
            request_x.pMensajeID = pMensajeID;
            request_x.pFuerzaVentaM2K = pFuerzaVentaM2K;
            request_x.pModeloClave = pModeloClave;
            DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element response_x;
            Map<String, DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element> response_map_x = new Map<String, DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/ConsultarInformacionModelo',
              'http://tempuri.org/',
              'ConsultarInformacionModelo',
              'http://tempuri.org/',
              'ConsultarInformacionModeloResponse',
              'DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.ConsultarInformacionModeloResult;
        }
        public DCT_TelcelEquiposSoap_ws.getMarcasResponseDTO ConsultarMarcas(String pMensajeID,String pFuerzaVentaM2K) {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcas_element request_x = new DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcas_element();
            request_x.pMensajeID = pMensajeID;
            request_x.pFuerzaVentaM2K = pFuerzaVentaM2K;
            DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element response_x;
            Map<String, DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element> response_map_x = new Map<String, DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/ConsultarMarcas',
              'http://tempuri.org/',
              'ConsultarMarcas',
              'http://tempuri.org/',
              'ConsultarMarcasResponse',
              'DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.ConsultarMarcasResult;
        }
        public DCT_TelcelEquiposSoap_ws.getModelosResponseDTO ConsultarModelos(String pMensajeID,String pFuerzaVentaM2K,Integer pMarcaClave) {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarModelos_element request_x = new DCT_TelcelEquiposSoapOrg_ws.ConsultarModelos_element();
            request_x.pMensajeID = pMensajeID;
            request_x.pFuerzaVentaM2K = pFuerzaVentaM2K;
            request_x.pMarcaClave = pMarcaClave;
            DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element response_x;
            Map<String, DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element> response_map_x = new Map<String, DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/ConsultarModelos',
              'http://tempuri.org/',
              'ConsultarModelos',
              'http://tempuri.org/',
              'ConsultarModelosResponse',
              'DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.ConsultarModelosResult;
        }
    }
}