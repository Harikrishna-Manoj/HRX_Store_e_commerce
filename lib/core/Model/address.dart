class Address {
  String name = '';
  int phoneNumber;
  int pinCode;
  String addressType = '';
  String state = '';
  String cityOrStreet = '';
  String houseNoorName = '';
  String? id;
  bool isDefault = false;
  Address(
      {required this.name,
      required this.phoneNumber,
      required this.pinCode,
      required this.addressType,
      required this.state,
      required this.cityOrStreet,
      required this.houseNoorName,
      this.id});
  static Address fromJson(Map<String, dynamic> json) => Address(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      pinCode: json['pinCode'],
      addressType: json['addressType'],
      state: json['state'],
      cityOrStreet: json['cityOrStreet'],
      houseNoorName: json['houseNoorName'],
      id: json['id']);
  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'pinCode': pinCode,
        'addressType': addressType,
        'state': state,
        'cityOrStreet': cityOrStreet,
        'houseNoorName': houseNoorName,
        'id': id,
      };
}
