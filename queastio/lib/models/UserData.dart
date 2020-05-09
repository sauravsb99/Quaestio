class UserData {
  final String uid;
  final String Name;
  final String email;
  final String userRole;
   String image;
  UserData({this.uid, this.Name, this.email, this.userRole,this.image});
  UserData.fromData(Map<String, dynamic> data,)
      : uid = data['uid'],
        Name = data['fullName'],
        email = data['email'],
        userRole = data['userRole'];
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': Name,
      'email': email,
      'userRole': userRole,
    };
  }
}