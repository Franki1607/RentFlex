class FirebaseConfig{
  final String?  appName;
  final String momoConfigCollection;
  final String userCollection;
  final String propertyCollection;
  final String contractCollection;
  final String momoTransactionCollection;
  final String paymentCollection;
  final String transactionCollection;

  const FirebaseConfig({
    this.appName,
    required this.momoConfigCollection,
    required this.userCollection
    ,required this.propertyCollection
    ,required this.contractCollection
    ,required this.momoTransactionCollection,
    required this.paymentCollection,
    required this.transactionCollection
  });

}