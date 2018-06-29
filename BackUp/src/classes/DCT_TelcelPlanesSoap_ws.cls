//Generated by wsdl2apex

public class DCT_TelcelPlanesSoap_ws {
    public class ArrayOfGuiaPlanesPromocionesDTO {
        public DCT_TelcelPlanesSoap_ws.guiaPlanesPromocionesDTO[] promocion;
        private String[] promocion_type_info = new String[]{'promocion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'promocion'};
    }
    public class planesMercadoWSOUTDTO {
        public DCT_TelcelPlanesSoap_ws.planMercado[] Mercado;
        public Integer movimientoWS;
        public Integer estatusWS;
        public String descEstatusWS;
        private String[] Mercado_type_info = new String[]{'Mercado','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] movimientoWS_type_info = new String[]{'movimientoWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] estatusWS_type_info = new String[]{'estatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','false'};
        private String[] descEstatusWS_type_info = new String[]{'descEstatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'Mercado','movimientoWS','estatusWS','descEstatusWS'};
    }
    public class getPlazosResponseDTO {
        public DCT_TelcelPlanesSoap_ws.controlDataResponseCustom controlData;
        public DCT_TelcelPlanesSoapEsb_ws.detailResponse detailResponse;
        public DCT_TelcelPlanesSoap_ws.planPlazoFVMercadoOUTDTO listaPlazos;
        private String[] controlData_type_info = new String[]{'controlData','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] detailResponse_type_info = new String[]{'detailResponse','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] listaPlazos_type_info = new String[]{'listaPlazos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'controlData','detailResponse','listaPlazos'};
    }
    public class ArrayOfGuiaPlanesCasosTraficoDTO {
        public DCT_TelcelPlanesSoap_ws.guiaPlanesCasosTraficoDTO[] casoTrafico;
        private String[] casoTrafico_type_info = new String[]{'casoTrafico','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'casoTrafico'};
    }
    public class getGuiaPlanesResponseDTO {
        public DCT_TelcelPlanesSoap_ws.controlDataResponseCustom controlData;
        public DCT_TelcelPlanesSoapEsb_ws.detailResponse detailResponse;
        public DCT_TelcelPlanesSoap_ws.guiaPlanesOUTDTO listaPlanes;
        private String[] controlData_type_info = new String[]{'controlData','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] detailResponse_type_info = new String[]{'detailResponse','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] listaPlanes_type_info = new String[]{'listaPlanes','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'controlData','detailResponse','listaPlanes'};
    }
    public class guiaPlanesCasosTraficoDTO {
        public String caso;
        public String descripcion;
        public String precio;
        private String[] caso_type_info = new String[]{'caso','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] descripcion_type_info = new String[]{'descripcion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] precio_type_info = new String[]{'precio','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'caso','descripcion','precio'};
    }
    public class planPlazoM2K {
        public String cvePlanM2k;
        public String descripcionPlan;
        private String[] cvePlanM2k_type_info = new String[]{'cvePlanM2k','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] descripcionPlan_type_info = new String[]{'descripcionPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'cvePlanM2k','descripcionPlan'};
    }
    public class planPlazoMercado {
        public Integer cvePlazo;
        public String descripcionPlazo;
        public Integer meses;
        private String[] cvePlazo_type_info = new String[]{'cvePlazo','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] descripcionPlazo_type_info = new String[]{'descripcionPlazo','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] meses_type_info = new String[]{'meses','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'cvePlazo','descripcionPlazo','meses'};
    }
    public class guiaPlanesPromocionesDTO {
        public String m2kPromocion;
        public String promocion;
        public String descripcion;
        private String[] m2kPromocion_type_info = new String[]{'m2kPromocion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] promocion_type_info = new String[]{'promocion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] descripcion_type_info = new String[]{'descripcion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'m2kPromocion','promocion','descripcion'};
    }
    public class controlDataResponseCustom {
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class planPlazoFVMercadoOUTDTO {
        public DCT_TelcelPlanesSoap_ws.planPlazoMercado[] Plazo;
        public Integer movimientoWS;
        public Integer estatusWS;
        public String descEstatusWS;
        private String[] Plazo_type_info = new String[]{'Plazo','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] movimientoWS_type_info = new String[]{'movimientoWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] estatusWS_type_info = new String[]{'estatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','false'};
        private String[] descEstatusWS_type_info = new String[]{'descEstatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'Plazo','movimientoWS','estatusWS','descEstatusWS'};
    }
    public class getPlanesResponseDTO {
        public DCT_TelcelPlanesSoap_ws.controlDataResponseCustom controlData;
        public DCT_TelcelPlanesSoapEsb_ws.detailResponse detailResponse;
        public DCT_TelcelPlanesSoap_ws.getPlanesOUTDTO listaPlanes;
        private String[] controlData_type_info = new String[]{'controlData','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] detailResponse_type_info = new String[]{'detailResponse','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] listaPlanes_type_info = new String[]{'listaPlanes','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'controlData','detailResponse','listaPlanes'};
    }
    public class getPlanesOUTDTO {
        public DCT_TelcelPlanesSoap_ws.planPlazoM2K[] plan;
        public Integer movimientoWS;
        public Integer estatusWS;
        public String descEstatusWS;
        private String[] plan_type_info = new String[]{'plan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] movimientoWS_type_info = new String[]{'movimientoWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] estatusWS_type_info = new String[]{'estatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','false'};
        private String[] descEstatusWS_type_info = new String[]{'descEstatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'plan','movimientoWS','estatusWS','descEstatusWS'};
    }
    public class getGruposPlanResponseDTO {
        public DCT_TelcelPlanesSoap_ws.controlDataResponseCustom controlData;
        public DCT_TelcelPlanesSoapEsb_ws.detailResponse detailResponse;
        public DCT_TelcelPlanesSoap_ws.grupoPlanesMercadoOUTDTO listaGruposPlan;
        private String[] controlData_type_info = new String[]{'controlData','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] detailResponse_type_info = new String[]{'detailResponse','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] listaGruposPlan_type_info = new String[]{'listaGruposPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'controlData','detailResponse','listaGruposPlan'};
    }
    public class guiaPlanesOUTDTO {
        public DCT_TelcelPlanesSoap_ws.guiaPlanesCaracteristicasDTO caracteristicas;
        public DCT_TelcelPlanesSoap_ws.ArrayOfGuiaPlanesPromocionesDTO promociones;
        public DCT_TelcelPlanesSoap_ws.ArrayOfGuiaPlanesServiciosDTO servicios;
        public DCT_TelcelPlanesSoap_ws.ArrayOfGuiaPlanesCasosTraficoDTO casosTrafico;
        public Integer estatus;
        public String descEstatus;
        public Integer movimiento;
        private String[] caracteristicas_type_info = new String[]{'caracteristicas','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] promociones_type_info = new String[]{'promociones','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] servicios_type_info = new String[]{'servicios','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] casosTrafico_type_info = new String[]{'casosTrafico','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] estatus_type_info = new String[]{'estatus','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','false'};
        private String[] descEstatus_type_info = new String[]{'descEstatus','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] movimiento_type_info = new String[]{'movimiento','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'caracteristicas','promociones','servicios','casosTrafico','estatus','descEstatus','movimiento'};
    }
    public class guiaPlanesServiciosDTO {
        public String id;
        public String tipoProducto;
        public String nombre;
        public String descripcion;
        public String precio;
        public String indicadorEquipo;
        public String tipoServicio;
        public String origen;
        private String[] id_type_info = new String[]{'id','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoProducto_type_info = new String[]{'tipoProducto','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] nombre_type_info = new String[]{'nombre','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] descripcion_type_info = new String[]{'descripcion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] precio_type_info = new String[]{'precio','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] indicadorEquipo_type_info = new String[]{'indicadorEquipo','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoServicio_type_info = new String[]{'tipoServicio','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] origen_type_info = new String[]{'origen','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'id','tipoProducto','nombre','descripcion','precio','indicadorEquipo','tipoServicio','origen'};
    }
    public class getMercadosResponseDTO {
        public DCT_TelcelPlanesSoap_ws.controlDataResponseCustom controlData;
        public DCT_TelcelPlanesSoapEsb_ws.detailResponse detailResponse;
        public DCT_TelcelPlanesSoap_ws.planesMercadoWSOUTDTO listaMercados;
        private String[] controlData_type_info = new String[]{'controlData','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] detailResponse_type_info = new String[]{'detailResponse','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] listaMercados_type_info = new String[]{'listaMercados','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'controlData','detailResponse','listaMercados'};
    }
    public class grupoPlanMercado {
        public Integer cveGrupoPlan;
        public Integer cveSubGrupoPlan;
        public String descripcionGrupoPlan;
        public String descripcionSubGrupoPlan;
        public String grupoPlanSubgrupoPlan;
        private String[] cveGrupoPlan_type_info = new String[]{'cveGrupoPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] cveSubGrupoPlan_type_info = new String[]{'cveSubGrupoPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] descripcionGrupoPlan_type_info = new String[]{'descripcionGrupoPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] descripcionSubGrupoPlan_type_info = new String[]{'descripcionSubGrupoPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] grupoPlanSubgrupoPlan_type_info = new String[]{'grupoPlanSubgrupoPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'cveGrupoPlan','cveSubGrupoPlan','descripcionGrupoPlan','descripcionSubGrupoPlan','grupoPlanSubgrupoPlan'};
    }
    public class guiaPlanesCaracteristicasDTO {
        public String cvePlanM2k;
        public String nombrePlan;
        public String plazo;
        public String cargoMensualServicio;
        public String cargoMensualEquipo;
        public String cargoMensualTotal;
        public String minutosIndistintos;
        public String tipoMinutosIndistintos;
        public String comentarioMinutosIndistintos;
        public String minutos;
        public String tipoMinutos;
        public String numerosGratis;
        public String comentarioNumerosGratis;
        public String mensajesTextoIndistintos;
        public String tipoMensajesTextoIndistintos;
        public String comentarioMensajesTextoInd;
        public String costoMensajeTxtAdiNacionalInd;
        public String mensajesTexto;
        public String tipoMensajesTexto;
        public String costoMensajeTextoAdicional;
        public String comentarioMensajesTexto;
        public String costoMensajeMultaAdiNac;
        public String capacidadDatos;
        public String descripcionTasacion;
        public String tipoDatos;
        public String costoKbTransmisionDatos;
        public String costoMbTransmisionDatos;
        public String comentarioDatos;
        public String comentarioPenaCanceAnti;
        public String fianzaAnual;
        private String[] cvePlanM2k_type_info = new String[]{'cvePlanM2k','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] nombrePlan_type_info = new String[]{'nombrePlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] plazo_type_info = new String[]{'plazo','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] cargoMensualServicio_type_info = new String[]{'cargoMensualServicio','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] cargoMensualEquipo_type_info = new String[]{'cargoMensualEquipo','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] cargoMensualTotal_type_info = new String[]{'cargoMensualTotal','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] minutosIndistintos_type_info = new String[]{'minutosIndistintos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoMinutosIndistintos_type_info = new String[]{'tipoMinutosIndistintos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] comentarioMinutosIndistintos_type_info = new String[]{'comentarioMinutosIndistintos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] minutos_type_info = new String[]{'minutos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoMinutos_type_info = new String[]{'tipoMinutos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] numerosGratis_type_info = new String[]{'numerosGratis','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] comentarioNumerosGratis_type_info = new String[]{'comentarioNumerosGratis','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] mensajesTextoIndistintos_type_info = new String[]{'mensajesTextoIndistintos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoMensajesTextoIndistintos_type_info = new String[]{'tipoMensajesTextoIndistintos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] comentarioMensajesTextoInd_type_info = new String[]{'comentarioMensajesTextoInd','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] costoMensajeTxtAdiNacionalInd_type_info = new String[]{'costoMensajeTxtAdiNacionalInd','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] mensajesTexto_type_info = new String[]{'mensajesTexto','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoMensajesTexto_type_info = new String[]{'tipoMensajesTexto','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] costoMensajeTextoAdicional_type_info = new String[]{'costoMensajeTextoAdicional','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] comentarioMensajesTexto_type_info = new String[]{'comentarioMensajesTexto','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] costoMensajeMultaAdiNac_type_info = new String[]{'costoMensajeMultaAdiNac','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] capacidadDatos_type_info = new String[]{'capacidadDatos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] descripcionTasacion_type_info = new String[]{'descripcionTasacion','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] tipoDatos_type_info = new String[]{'tipoDatos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] costoKbTransmisionDatos_type_info = new String[]{'costoKbTransmisionDatos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] costoMbTransmisionDatos_type_info = new String[]{'costoMbTransmisionDatos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] comentarioDatos_type_info = new String[]{'comentarioDatos','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] comentarioPenaCanceAnti_type_info = new String[]{'comentarioPenaCanceAnti','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] fianzaAnual_type_info = new String[]{'fianzaAnual','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'cvePlanM2k','nombrePlan','plazo','cargoMensualServicio','cargoMensualEquipo','cargoMensualTotal','minutosIndistintos','tipoMinutosIndistintos','comentarioMinutosIndistintos','minutos','tipoMinutos','numerosGratis','comentarioNumerosGratis','mensajesTextoIndistintos','tipoMensajesTextoIndistintos','comentarioMensajesTextoInd','costoMensajeTxtAdiNacionalInd','mensajesTexto','tipoMensajesTexto','costoMensajeTextoAdicional','comentarioMensajesTexto','costoMensajeMultaAdiNac','capacidadDatos','descripcionTasacion','tipoDatos','costoKbTransmisionDatos','costoMbTransmisionDatos','comentarioDatos','comentarioPenaCanceAnti','fianzaAnual'};
    }
    public class planMercado {
        public Integer cveMercado;
        public String descripcionMercado;
        private String[] cveMercado_type_info = new String[]{'cveMercado','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] descripcionMercado_type_info = new String[]{'descripcionMercado','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'cveMercado','descripcionMercado'};
    }
    public class grupoPlanesMercadoOUTDTO {
        public DCT_TelcelPlanesSoap_ws.grupoPlanMercado[] GrupoPlan;
        public Integer movimientoWS;
        public Integer estatusWS;
        public String descEstatusWS;
        private String[] GrupoPlan_type_info = new String[]{'GrupoPlan','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] movimientoWS_type_info = new String[]{'movimientoWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] estatusWS_type_info = new String[]{'estatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'1','1','false'};
        private String[] descEstatusWS_type_info = new String[]{'descEstatusWS','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'GrupoPlan','movimientoWS','estatusWS','descEstatusWS'};
    }
    public class ArrayOfGuiaPlanesServiciosDTO {
        public DCT_TelcelPlanesSoap_ws.guiaPlanesServiciosDTO[] servicio;
        private String[] servicio_type_info = new String[]{'servicio','http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.amx.com.mx/mexico/telcel/di/sds/crm/dlyscrm/planes','true','false'};
        private String[] field_order_type_info = new String[]{'servicio'};
    }
}