class IPdetails {
  late final String regionName;
  late final String city;
  late final String zip;
  late final String timezone;
  late final String isp;
  late final String query;
  late final String country;
  
  IPdetails({
    required this.regionName,
    required this.city,
    required this.country,
    required this.zip,
    required this.timezone,
    required this.isp,
    required this.query,
  });

  IPdetails.fromJson(Map<String, dynamic> json) {
    regionName = json['regionName'] ?? " ";
    city = json['city'] ?? " ";
    zip = json['zip'] ?? " ";
    country = json['country']?? " ";
    timezone = json['timezone'] ?? " Unknown ";
    isp = json['isp'] ?? " Unknown ";
    query = json['query'] ?? " Not available ";
  }
}
