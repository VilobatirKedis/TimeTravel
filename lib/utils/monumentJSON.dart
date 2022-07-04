class MonumentsData {
  final int id;
  final String realName;
  final String it_description;
  final String it_name;
  final int number_of_votes;
  final int votes_sum;
  final int fk_city_id;
  final double latitude;
  final double longitude;

  String? type;
  String? typeDescription;

  set setType(String sType) {
    type = sType;
  }

  set setTypeDescription(String sDescription) {
    typeDescription = sDescription;
  }

  MonumentsData(this.id, this.realName, this.it_description,
  this.it_name, this.number_of_votes, this.votes_sum, this.fk_city_id,
  this.latitude, this.longitude);

  MonumentsData.fromJson(Map<String, dynamic> json)
      : id = json['monuments_id'],
        realName = json['monuments_real_name'],
        it_name = json['monuments_it_name'],
        it_description = json['monuments_it_description'],
        number_of_votes = json['monuments_number_of_votes'],
        votes_sum = json['monuments_votes_sum'],
        fk_city_id = json['monuments_fk_city_id'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        'monuments_id': id,
        'monuments_real_name': realName,
        'monuments_it_description': it_description,
        'latitude': latitude,
        'longitude': longitude
      };
}