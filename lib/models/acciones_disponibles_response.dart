// To parse this JSON data, do
//
//     final accionesDisponiblesResponse = accionesDisponiblesResponseFromJson(jsonString);

import 'dart:convert';

List<AccionesDisponiblesResponse> accionesDisponiblesResponseFromJson(String str) => List<AccionesDisponiblesResponse>.from(json.decode(str).map((x) => AccionesDisponiblesResponse.fromJson(x)));

String accionesDisponiblesResponseToJson(List<AccionesDisponiblesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccionesDisponiblesResponse {
    String idswfRequest;
    String swfRequestCode;
    String swfRequestTitle;
    String swfRequestDescription;
    String swfRequestCurrentstateid;
    DateTime swfRequestDate;
    String swfRequestUserid;
    String swfRequestCreator;
    String idswfRequestAction;
    String swfRequestid;
    String swfActionid;
    String swfTransitionid;
    String swfRequestActionIsactive;
    String swfRequestActionIscomplete;
    String swfUserid;
    String swfRequestActionCompleted;
    String idswfTransitionActions;
    String swfTransitionActionsIsactive;
    String swfTransitionActionsConfirm;
    String swfTransitionActionsProgram;
    String swfTransitionActionsReturn;
    String swfTransitionActionsProcessid;
    String idswfAction;
    String swfActionCode;
    String swfActionName;
    String swfActionProgram;

    AccionesDisponiblesResponse({
        required this.idswfRequest,
        required this.swfRequestCode,
        required this.swfRequestTitle,
        required this.swfRequestDescription,
        required this.swfRequestCurrentstateid,
        required this.swfRequestDate,
        required this.swfRequestUserid,
        required this.swfRequestCreator,
        required this.idswfRequestAction,
        required this.swfRequestid,
        required this.swfActionid,
        required this.swfTransitionid,
        required this.swfRequestActionIsactive,
        required this.swfRequestActionIscomplete,
        required this.swfUserid,
        required this.swfRequestActionCompleted,
        required this.idswfTransitionActions,
        required this.swfTransitionActionsIsactive,
        required this.swfTransitionActionsConfirm,
        required this.swfTransitionActionsProgram,
        required this.swfTransitionActionsReturn,
        required this.swfTransitionActionsProcessid,
        required this.idswfAction,
        required this.swfActionCode,
        required this.swfActionName,
        required this.swfActionProgram,
    });

    factory AccionesDisponiblesResponse.fromJson(Map<String, dynamic> json) => AccionesDisponiblesResponse(
        idswfRequest: json["idswf_request"],
        swfRequestCode: json["swf_request_code"],
        swfRequestTitle: json["swf_request_title"],
        swfRequestDescription: json["swf_request_description"],
        swfRequestCurrentstateid: json["swf_request_currentstateid"],
        swfRequestDate: DateTime.parse(json["swf_request_date"]),
        swfRequestUserid: json["swf_request_userid"],
        swfRequestCreator: json["swf_request_creator"],
        idswfRequestAction: json["idswf_request_action"],
        swfRequestid: json["swf_requestid"],
        swfActionid: json["swf_actionid"],
        swfTransitionid: json["swf_transitionid"],
        swfRequestActionIsactive: json["swf_request_action_isactive"],
        swfRequestActionIscomplete: json["swf_request_action_iscomplete"],
        swfUserid: json["swf_userid"],
        swfRequestActionCompleted: json["swf_request_action_completed"],
        idswfTransitionActions: json["idswf_transition_actions"],
        swfTransitionActionsIsactive: json["swf_transition_actions_isactive"],
        swfTransitionActionsConfirm: json["swf_transition_actions_confirm"],
        swfTransitionActionsProgram: json["swf_transition_actions_program"],
        swfTransitionActionsReturn: json["swf_transition_actions_return"],
        swfTransitionActionsProcessid: json["swf_transition_actions_processid"],
        idswfAction: json["idswf_action"],
        swfActionCode: json["swf_action_code"],
        swfActionName: json["swf_action_name"],
        swfActionProgram: json["swf_action_program"],
    );

    Map<String, dynamic> toJson() => {
        "idswf_request": idswfRequest,
        "swf_request_code": swfRequestCode,
        "swf_request_title": swfRequestTitle,
        "swf_request_description": swfRequestDescription,
        "swf_request_currentstateid": swfRequestCurrentstateid,
        "swf_request_date": swfRequestDate.toIso8601String(),
        "swf_request_userid": swfRequestUserid,
        "swf_request_creator": swfRequestCreator,
        "idswf_request_action": idswfRequestAction,
        "swf_requestid": swfRequestid,
        "swf_actionid": swfActionid,
        "swf_transitionid": swfTransitionid,
        "swf_request_action_isactive": swfRequestActionIsactive,
        "swf_request_action_iscomplete": swfRequestActionIscomplete,
        "swf_userid": swfUserid,
        "swf_request_action_completed": swfRequestActionCompleted,
        "idswf_transition_actions": idswfTransitionActions,
        "swf_transition_actions_isactive": swfTransitionActionsIsactive,
        "swf_transition_actions_confirm": swfTransitionActionsConfirm,
        "swf_transition_actions_program": swfTransitionActionsProgram,
        "swf_transition_actions_return": swfTransitionActionsReturn,
        "swf_transition_actions_processid": swfTransitionActionsProcessid,
        "idswf_action": idswfAction,
        "swf_action_code": swfActionCode,
        "swf_action_name": swfActionName,
        "swf_action_program": swfActionProgram,
    };
}
