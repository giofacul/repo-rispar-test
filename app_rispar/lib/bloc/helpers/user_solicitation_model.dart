class UserSolicitationModel {
  String? valueWarranty;
  int? valueFees;
  int? valueIOF;

  UserSolicitationModel({
    required this.valueWarranty,
    this.valueFees,
    this.valueIOF,
  });

  UserSolicitationModel.fromJson(Map<String, dynamic> json) {
    //Garantia
    valueWarranty = json['uid'];
    //JUROS - FOLLOWERS
    valueFees = json['extra']['raw_info']['followers'];
    //IOF - FOLLOWING
    valueIOF = json['extra']['raw_info']['following'];

    print('VALUE IOF  NA MODEL $valueWarranty');
  }
}
