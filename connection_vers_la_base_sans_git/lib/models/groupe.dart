class Groupe {
  int? id;
  String? lieu;
  String? nom_gpe;


  Groupe({
    this.id,
    this.lieu,
    this.nom_gpe,
  });

  factory Groupe.fromJson(Map<String, dynamic> json) {
    return Groupe(
      id: json['id'],
      lieu: json['lieu'],
      nom_gpe: json['nom_gpe'],
    );
  }
}