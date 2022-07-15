class UserSolicitationModel {
  String? valueWarranty;
  int? valueFees;
  int? valueIOF;
  int? valueCET;

  UserSolicitationModel({
    required this.valueWarranty,
    this.valueFees,
    this.valueIOF,
    this.valueCET,
  });

  UserSolicitationModel.fromJson(Map<String, dynamic> json) {
    //Garantia
    valueWarranty = json['uid'];
    //JUROS - FOLLOWERS
    valueFees = json['extra']['raw_info']['followers'];
    //IOF - FOLLOWING
    valueIOF = json['extra']['raw_info']['following'];
    valueCET = json['extra']['raw_info']['public_gists'];

    print('VALUE IOF  NA MODEL $valueWarranty');
  }
}
