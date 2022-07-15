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
    valueWarranty = json['userId'];
    //JUROS - FOLLOWERS
    valueFees = json['extra']['raw_info']['followers'];
    //IOF - FOLLOWING
    valueIOF = json['extra']['raw_info']['following'];

    print('VALUE IOF  NA MODEL $valueIOF');
  }

// String? get warranty => valueWarranty;
// int? get fees => valueFees;
// int? get iof => valueIOF;

// final String? name;
// final String? email;
// final int? itv;
// final double? amount;
// final int? term;
// final bool? has_protected_collateral;
//
// UserSolicitationModel(this.name, this.email, this.itv, this.amount, this.term,
//     this.has_protected_collateral);
//
// UserSolicitationModel.fromJson(Map<String, dynamic> json)
//     : name = json['name'],
//       email = json['email'],
//       itv = json['itv'],
//       amount = json['amount'],
//       term = json['term'],
//       has_protected_collateral = json['has_protected_collateral'];
//
// Map<String, dynamic> toJson() => {
//       'name': name,
//       'email': email,
//       'itv': itv,
//       'amount': amount,
//       'term': term,
//       'has_protected_collateral': has_protected_collateral,
//     };
}
