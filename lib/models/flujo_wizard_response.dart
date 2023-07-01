// To parse this JSON data, do
//
//     final flujoWizardResponse = flujoWizardResponseFromJson(jsonString);

import 'dart:convert';

List<FlujoWizardResponse> flujoWizardResponseFromJson(String str) => List<FlujoWizardResponse>.from(json.decode(str).map((x) => FlujoWizardResponse.fromJson(x)));

String flujoWizardResponseToJson(List<FlujoWizardResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FlujoWizardResponse {
    String idswfState;
    String swfStateType;
    String swfStateProcessid;
    String swfStateCode;
    String swfStateName;
    String swfStateOrder;
    String swfStateIconunicode;
    String idswfRequest;
    String swfRequestCode;
    String swfRequestTitle;
    String swfRequestDescription;
    String swfRequestCurrentstateid;
    DateTime swfRequestDate;
    String swfRequestUserid;
    String swfRequestCreator;
    String completado;
    String estadoActual;

    FlujoWizardResponse({
        required this.idswfState,
        required this.swfStateType,
        required this.swfStateProcessid,
        required this.swfStateCode,
        required this.swfStateName,
        required this.swfStateOrder,
        required this.swfStateIconunicode,
        required this.idswfRequest,
        required this.swfRequestCode,
        required this.swfRequestTitle,
        required this.swfRequestDescription,
        required this.swfRequestCurrentstateid,
        required this.swfRequestDate,
        required this.swfRequestUserid,
        required this.swfRequestCreator,
        required this.completado,
        required this.estadoActual
    });

    factory FlujoWizardResponse.fromJson(Map<String, dynamic> json) => FlujoWizardResponse(
        idswfState: json["idswf_state"],
        swfStateType: json["swf_state_type"],
        swfStateProcessid: json["swf_state_processid"],
        swfStateCode: json["swf_state_code"],
        swfStateName: json["swf_state_name"],
        swfStateOrder: json["swf_state_order"],
        swfStateIconunicode: json["swf_state_iconunicode"],
        idswfRequest: json["idswf_request"],
        swfRequestCode: json["swf_request_code"],
        swfRequestTitle: json["swf_request_title"],
        swfRequestDescription: json["swf_request_description"],
        swfRequestCurrentstateid: json["swf_request_currentstateid"],
        swfRequestDate: DateTime.parse(json["swf_request_date"]),
        swfRequestUserid: json["swf_request_userid"],
        swfRequestCreator: json["swf_request_creator"],
        completado: json["completado"],
        estadoActual: json["estado_actual"],
    );

    Map<String, dynamic> toJson() => {
        "idswf_state": idswfState,
        "swf_state_type": swfStateType,
        "swf_state_processid": swfStateProcessid,
        "swf_state_code": swfStateCode,
        "swf_state_name": swfStateName,
        "swf_state_order": swfStateOrder,
        "swf_state_iconunicode": swfStateIconunicode,
        "idswf_request": idswfRequest,
        "swf_request_code": swfRequestCode,
        "swf_request_title": swfRequestTitle,
        "swf_request_description": swfRequestDescription,
        "swf_request_currentstateid": swfRequestCurrentstateid,
        "swf_request_date": swfRequestDate.toIso8601String(),
        "swf_request_userid": swfRequestUserid,
        "swf_request_creator": swfRequestCreator,
        "completado": completado,
        "estado_actual": estadoActual
    };
}
