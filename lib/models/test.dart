class UserModel {
  final String id; // Identifiant utilisateur unique
  final String phoneNumber; // Numéro de téléphone MTN (authentification)
  final String name; // Nom de l'utilisateur
  final String email; // Adresse e-mail (optionnelle)
  final bool isTenant; // Indique si l'utilisateur est un locataire
  final bool isOwner; // Indique si l'utilisateur est un propriétaire

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    this.email = '',
    this.isTenant = false,
    this.isOwner = false,
  });
}

class RentalPropertyModel {
  final String id; // Identifiant de la propriété unique
  final String ownerId; // Identifiant du propriétaire
  final String address; // Adresse de la propriété
  final double monthlyRent; // Loyer mensuel
  final List<String> photos; // Liste de liens vers les photos de la propriété

  RentalPropertyModel({
    required this.id,
    required this.ownerId,
    required this.address,
    required this.monthlyRent,
    required this.photos,
  });
}

class PaymentModel {
  final String id; // Identifiant de paiement unique
  final double amount; // Montant du paiement
  final DateTime date; // Date du paiement
  final String paymentMethod; // Méthode de paiement (carte, espèces, etc.)
  final String tenantId; // Identifiant de l'utilisateur locataire
  final String propertyId; // Identifiant de la propriété associée

  PaymentModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.tenantId,
    required this.propertyId,
  });
}

class PropertyListingModel {
  final String id; // Identifiant de la liste de propriétés unique
  final String ownerId; // Identifiant du propriétaire
  final String propertyId; // Identifiant de la propriété à louer
  final DateTime availabilityDate; // Date de disponibilité
  final String description; // Description de la propriété
  final List<String> photos; // Liste de liens vers les photos de la propriété

  PropertyListingModel({
    required this.id,
    required this.ownerId,
    required this.propertyId,
    required this.availabilityDate,
    required this.description,
    required this.photos,
  });
}
