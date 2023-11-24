# RentFlex

## Description du projet

RentFlex est une solution conviviale, efficace et intelligente pour la gestion des paiements de loyer, que ce soit en plusieurs versements ou en un seul paiement global. Les locataires auront un contrôle total sur leurs engagements financiers, simplifiant les tâches administratives pour les propriétaires. Cette innovation rend le logement plus accessible financièrement et plus facile à gérer pour tous.

## Installation

Pour installer RentFlex, suivez ces étapes :

1. Clonez le dépôt (assurez vous que le nom soit rent_flex) : `git clone https://github.com/Franki1607/RentFlex.git ./rent_flex`
2. Accédez au répertoire du projet : `cd rent_flex`
3. Installez les dépendances : `flutter pub get`
4. Lancez l'application : `flutter run`

## Types d'utilisateurs

Notre application s'addresse à deux principaux utilisateurs

### Propriétaire

Les propriétaires peuvent :
- Ajouter des propriétés à louer en fournissant des détails complets en allant sur le Dashboard > Immobillier.
- Créer un contrat de location pour en renseignants le numéro de téléphone du client (le locataire) même sans se soucier s'il a un compte ou pas
- Suivre les paiements, les transactions, les quittances de paiement automatiquement générées et les dates de location depuis une interfaces conviviale
- Dormir et voir son compte momo gonfler au jour le jour (😅)

### Locataire

Les locataires peuvent :
- Etant ajouter à un contrat de location effectuer des paiements à leur guise (min 100).
- Suivre leurs paiements, les transactions effectuées via à une interfaces conviviale.
- Généré s'il le veulent leurs quittances au format PDF.
- Dormir en paix sans avoir peur que le propriétaire frappe à sa porte (😅)

## Demo et test

Notre application fonctionne via à Firebase, donc accessible à tous. La connexion se fait par numéro de téléphone (Limité à 3 connexion/jour/numéro)

Pour des tests plus approndis nous avons deux utilisateurs tests:

#### Propriétaire (+22967000000 otp:123445)

#### Locataire (+22967000001 otp:123445)

Vu que les données sont cloisonné nous pouvons déjà l'utiliser en production avec des comptes réels

## Captures d'écran

![Capture d'écran 1](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861401/Screenshot_20231124-222609_xu92zh.jpg)
![Capture d'écran 2](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861402/Screenshot_20231124-222616_avlfyf.jpg)
![Capture d'écran 3](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861404/Screenshot_20231124-222748_qa3mbu.jpg)
![Capture d'écran 4](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861008/after_login_eonlg0.jpg)
![Capture d'écran 5](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861021/immobiliers_rgtkfg.jpg)
![Capture d'écran 6](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861051/unused_property_phgkcd.jpg)
![Capture d'écran 7](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861013/contracts_ceop9k.jpg)
![Capture d'écran 8](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861013/en_retard_clnayh.jpg)
![Capture d'écran 9](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861634/Screenshot_20231124-220746_wbtdus.jpg)
![Capture d'écran 10](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861008/page_payement_mzbcfr.jpg)
![Capture d'écran 11](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861007/a_jour_yethbz.jpg)
![Capture d'écran 12](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861017/transaction_qk199s.jpg)
![Capture d'écran 13](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861022/payements_wi1wrb.jpg)
![Capture d'écran 14](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861010/details_paiement_ouqsvu.jpg)
![Capture d'écran 15](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861015/quittance_lxwazq.jpg)
![Capture d'écran 16](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861015/a_venir_vmr1ig.jpg)
![Capture d'écran 17](https://res.cloudinary.com/dfng74ru6/image/upload/v1700861015/profile_l5yf87.jpg)

## Licence

Ce projet est sous licence [MIT](LICENSE) et réaliser pour le HACKHATHON MOMO 2023.
