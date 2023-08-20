class Driver{
  final String driverId;
  final String FirstName;
  final String LastName;
  final String Email;
  final String ContactNo;
  final String ProfilePicture;

  Driver(this.driverId, this.FirstName, this.LastName, this.Email, this.ContactNo, this.ProfilePicture);

  String get fullName => "$FirstName $LastName";
  String get email => Email;
  String get contactNo => ContactNo;
  String get profilePicture => ProfilePicture;


  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      json['id'], // TODO : change to driverID
      json['firstName'],
      json['lastName'],
      json['email'],
      json['contactNumber'],
      json['profilePicture'],
    );
  }
}