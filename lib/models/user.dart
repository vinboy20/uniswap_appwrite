class UserModel {
  String? docId;
  String? name;
  String? email;
  String? photo;
  String? avatar;
  String? userId;
  String? address;
  String? lat;
  String? long;
  // String? country;
  String? pincode;
  String? phone;
  bool? biometric = false;
  bool? basicProgress = false;
  bool? isValidated = false;
  String? dob;
  String? gender;
  String? bio;
  String? link;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.photo,
    this.avatar,
    this.userId,
    this.address,
    this.lat,
    this.long,
    this.phone,
    this.pincode,
    this.basicProgress,
    this.isValidated,
    this.biometric,
    this.dob,
    this.gender,
    this.bio,
    this.link,
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
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    basicProgress = json['basicProgress'];
    isValidated = json['isValidated'];
    biometric = json['biometric'];
    dob = json['dob'];
    gender = json['gender'];
    bio = json['bio'];
    link = json['link'];
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
      lat: "",
      long: '',
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
    data['lat'] = lat;
    data['long'] = long;
    data['address'] = address;
    data['basicProgress'] = basicProgress;
    data['isValidated'] = isValidated;
    data['biometric'] = biometric;
    data['dob'] = dob;
    data['gender'] = gender;
    data['bio'] = bio;
    data['link'] = link;
    return data;
  }
}
