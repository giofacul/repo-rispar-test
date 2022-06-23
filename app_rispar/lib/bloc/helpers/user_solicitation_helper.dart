class UserSolicitation {
  final String? name;
  final String? email;
  final int? itv;
  final double? amount;
  final int? term;
  final bool? has_protected_collateral;

  UserSolicitation(this.name, this.email, this.itv, this.amount, this.term,
      this.has_protected_collateral);

  UserSolicitation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        itv = json['itv'],
        amount = json['amount'],
        term = json['term'],
        has_protected_collateral = json['has_protected_collateral'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'itv': itv,
        'amount': amount,
        'term': term,
        'has_protected_collateral': has_protected_collateral,
      };
}
