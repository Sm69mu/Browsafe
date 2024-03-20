class Vpn {
  late final String hostname;
  late final String ip;
  late final String ping;
  late final int speed;
  late final String countrylong;
  late final String countryshort;
  late final int numvpnsessions;
  late final String openVPNConfigDataBase64;
  Vpn({
    required this.hostname,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countrylong,
    required this.countryshort,
    required this.numvpnsessions,
    required this.openVPNConfigDataBase64,
  });

  Vpn.fromJson(Map<String, dynamic> json) {
    hostname = json['HostName'] ?? " ";
    ip = json['IP'] ?? '';

    ping = json['Ping'].toString();
    speed = json['Speed'] ?? 0;
    countrylong = json['CountryLong'] ?? "";
    countryshort = json['CountryShort'] ?? "";
    numvpnsessions = json['NumVpnSessions'] ?? 0;

    openVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['HostName'] = hostname;
    data['IP'] = ip;

    data['Ping'] = ping;
    data['Speed'] = speed;
    data['CountryLong'] = countrylong;
    data['CountryShort'] = countryshort;
    data['NumVpnSessions'] = numvpnsessions;

    data['OpenVPN_ConfigData_Base64'] = openVPNConfigDataBase64;
    return data;
  }
}
