class ContactModal {
  final int? id;
  final String? name;
  final String? email; // Changed from "rmail" to "email" as per standard naming

  ContactModal({
     this.id,
     this.name,
     this.email,
  });

  // Convert ContactModal to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  // Create ContactModal from Map
  factory ContactModal.fromMap(Map<String, dynamic> map) {
    return ContactModal(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}