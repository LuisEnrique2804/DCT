//Generated by wsdl2apex

public class AsyncDCT_TelcelEquiposSoapOrg_ws {
    public class ConsultarInformacionModeloResponse_elementFuture extends System.WebServiceCalloutFuture {
        public DCT_TelcelEquiposSoap_ws.getInformacionModeloResponseDTO getValue() {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element response = (DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.ConsultarInformacionModeloResult;
        }
    }
    public class ConsultarMarcasResponse_elementFuture extends System.WebServiceCalloutFuture {
        public DCT_TelcelEquiposSoap_ws.getMarcasResponseDTO getValue() {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element response = (DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.ConsultarMarcasResult;
        }
    }
    public class ConsultarModelosResponse_elementFuture extends System.WebServiceCalloutFuture {
        public DCT_TelcelEquiposSoap_ws.getModelosResponseDTO getValue() {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element response = (DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.ConsultarModelosResult;
        }
    }
    public class AsyncEquiposSoap {
        public String endpoint_x = 'https://www.region9.telcel.com/smartdistribuidores/PORTALES/PreciosSOAP/Equipos.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/equipos', 'DCT_TelcelEquiposSoap_ws', 'http://amx.com/mexico/telcel/esb/v1_1', 'DCT_TelcelEquiposSoapEsb_ws', 'http://tempuri.org/', 'DCT_TelcelEquiposSoapOrg_ws'};
        public AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_elementFuture beginConsultarInformacionModelo(System.Continuation continuation,String pMensajeID,String pFuerzaVentaM2K,String pModeloClave) {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModelo_element request_x = new DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModelo_element();
            request_x.pMensajeID = pMensajeID;
            request_x.pFuerzaVentaM2K = pFuerzaVentaM2K;
            request_x.pModeloClave = pModeloClave;
            return (AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://tempuri.org/ConsultarInformacionModelo',
              'http://tempuri.org/',
              'ConsultarInformacionModelo',
              'http://tempuri.org/',
              'ConsultarInformacionModeloResponse',
              'DCT_TelcelEquiposSoapOrg_ws.ConsultarInformacionModeloResponse_element'}
            );
        }
        public AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_elementFuture beginConsultarMarcas(System.Continuation continuation,String pMensajeID,String pFuerzaVentaM2K) {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcas_element request_x = new DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcas_element();
            request_x.pMensajeID = pMensajeID;
            request_x.pFuerzaVentaM2K = pFuerzaVentaM2K;
            return (AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://tempuri.org/ConsultarMarcas',
              'http://tempuri.org/',
              'ConsultarMarcas',
              'http://tempuri.org/',
              'ConsultarMarcasResponse',
              'DCT_TelcelEquiposSoapOrg_ws.ConsultarMarcasResponse_element'}
            );
        }
        public AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_elementFuture beginConsultarModelos(System.Continuation continuation,String pMensajeID,String pFuerzaVentaM2K,Integer pMarcaClave) {
            DCT_TelcelEquiposSoapOrg_ws.ConsultarModelos_element request_x = new DCT_TelcelEquiposSoapOrg_ws.ConsultarModelos_element();
            request_x.pMensajeID = pMensajeID;
            request_x.pFuerzaVentaM2K = pFuerzaVentaM2K;
            request_x.pMarcaClave = pMarcaClave;
            return (AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncDCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://tempuri.org/ConsultarModelos',
              'http://tempuri.org/',
              'ConsultarModelos',
              'http://tempuri.org/',
              'ConsultarModelosResponse',
              'DCT_TelcelEquiposSoapOrg_ws.ConsultarModelosResponse_element'}
            );
        }
    }
}