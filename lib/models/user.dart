class UserModel {
  String? docId;
  String? name;
  String? email;
  String? photo;
  String? avatar;
  String? userId;
  String? address;
  // String? country;
  String? pincode;
  String? phone;
  bool? biometric = false;
  bool? basicProgress = false;
  bool? isValidated;
  String? dob;
  String? gender;
  String? bio;
  String? link;
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? topUpAccountNumber;

  UserModel({this.docId, this.name, this.email, this.photo, this.avatar, this.userId, this.address, this.phone, this.pincode, this.basicProgress, this.isValidated, this.biometric, this.dob, this.gender, this.bio, this.link, this.bankCode, this.bankName, this.accountName, this.accountNumber, this.topUpAccountNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // docId: json['\$id'] ?? json['userId'], // Fallback to userId if $id missing
      // userId: json['userId'] ?? '',
      // amount: json['amount']?.toString() ?? '0.00', // Ensure string
      // status: json['status'] ?? "",
      // createdAt: json['\$createdAt'],

      docId: json['\$id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] ?? '',
      avatar: json['avatar'] ?? '',
      userId: json['userId'] ?? '',
      pincode: json['pincode'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      basicProgress: json['basicProgress'] ?? false,
      isValidated: json['isValidated'] ?? false,
      biometric: json['biometric'] ?? false,
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      link: json['link'] ?? '',
      bankCode: json['bankCode'] ?? '',
      bankName: json['bankName'] ?? '',
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      topUpAccountNumber: json['topUpAccountNumber'] ?? '',
    );
  }

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   docId = json['\$id'];
  //   name = json['name'] ?? '';
  //   email = json['email'] ?? '';
  //   photo = json['photo'] ?? '';
  //   avatar = json['avatar'] ?? '';
  //   userId = json['userId'] ?? '';
  //   pincode = json['pincode'] ?? '';
  //   phone = json['phone'] ?? '';
  //   address = json['address'] ?? '';
  //   basicProgress = json['basicProgress'] ?? false;
  //   isValidated = json['isValidated'] ?? false;
  //   biometric = json['biometric'] ?? false;
  //   dob = json['dob'] ?? '';
  //   gender = json['gender'] ?? '';
  //   bio = json['bio'] ?? '';
  //   link = json['link'] ?? '';
  //   bankCode = json['bankCode'] ?? '';
  //   bankName = json['bankName'] ?? '';
  //   accountName = json['accountName'] ?? '';
  //   accountNumber = json['accountNumber'] ?? '';
  //   topUpAccountNumber = json['topUpAccountNumber'] ?? '';
  // }

  // Factory constructor for creating an empty UserModel
  factory UserModel.empty() {
    return UserModel(
      docId: '',
      name: '',
      email: '',
      photo: '',
      avatar: '',
      address: '',
      userId: '',
      pincode: '',
      phone: '',
      biometric: false,
      basicProgress: false,
      isValidated: false,
      dob: '',
      gender: '',
      bio: "",
      link: "",
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    data['avatar'] = avatar;
    data['userId'] = userId;
    data['pincode'] = pincode;
    data['phone'] = phone;
    data['address'] = address;
    data['basicProgress'] = basicProgress ?? false;
    data['isValidated'] = isValidated ?? false;
    data['biometric'] = biometric ?? false;
    data['dob'] = dob;
    data['gender'] = gender;
    data['bio'] = bio;
    data['link'] = link;
    return data;
  }
}
