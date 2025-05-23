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
  bool? biometric;
  bool? basicProgress;
  bool? isValidated;
  String? dob;
  String? gender;
  String? bio;
  String? link;
  // String? bankCode;
  // String? bankName;
  // String? accountNumber;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.photo,
    this.avatar,
    this.userId,
    this.address,
    this.phone,
    this.pincode,
    this.basicProgress,
    this.isValidated,
    this.biometric,
    this.dob,
    this.gender,
    this.bio,
    this.link,
    // this.bankCode,
    // this.bankName,
    // this.accountNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    avatar = json['avatar'];
    userId = json['userId'];
    pincode = json['pincode'];
    phone = json['phone'];
    address = json['address'];
    basicProgress = json['basicProgress'];
    isValidated = json['isValidated'];
    biometric = json['biometric'];
    dob = json['dob'];
    gender = json['gender'];
    bio = json['bio'];
    link = json['link'];
    // bankCode = json['bankCode'];
    // bankName = json['bankName'];
    // accountNumber = json['accountNumber'];
  }

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
