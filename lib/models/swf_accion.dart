class SwfAccion {
    String swfActionName;
    String idswfAction;
    String swfActionCode;
    String swfActionProgram;
    String swfRequestid;
    String swfTransitionid;

    SwfAccion({
        required this.swfActionName,
        required this.idswfAction,
        required this.swfActionCode,
        required this.swfActionProgram,
        required this.swfRequestid,
        required this.swfTransitionid,
    });

    factory SwfAccion.fromJson(Map<String, dynamic> json) => SwfAccion(
        swfActionName: json["swf_action_name"],
        idswfAction: json["idswf_action"],
        swfActionCode: json["swf_action_code"],
        swfActionProgram: json["swf_action_program"],
        swfRequestid: json["swf_requestid"],
        swfTransitionid: json["swf_transitionid"],
    );

    Map<String, dynamic> toJson() => {
        "swf_action_name": swfActionName,
        "idswf_action": idswfAction,
        "swf_action_code": swfActionCode,
        "swf_action_program": swfActionProgram,
        "swf_requestid": swfRequestid,
        "swf_transitionid": swfTransitionid,
    };
}