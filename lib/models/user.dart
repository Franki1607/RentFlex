class User{
  String uid;
  String phoneNumber;
  String email;
  String firstName;
  String lastName;
  String? photoURL;
  String role; // 'tenant' or 'owner'

  User(
    this.uid,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.role
  );

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photoURL': photoURL,
      'role': role
    };
  }

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      map['uid'],
      map['phoneNumber'],
      map['email'],
      map['firstName'],
      map['lastName'],
      map['photoURL'],
      map['role']
    );
  }


}