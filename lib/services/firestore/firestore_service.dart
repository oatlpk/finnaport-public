import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finnaport/models/for_holdings/holdings_model_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  CollectionReference _users;
  DocumentReference _user;
  CollectionReference _holdings;

  FirestoreService(
    this._firestore,
    this._firebaseAuth,
  ) {
    this._users = _firestore.collection('users');
    this._user = this._users.doc(_firebaseAuth.currentUser.uid);
    this._holdings = this._user.collection('holdings');
  }

  /// Get list of documents in 'holdings' collection from Firestore.
  Future<List<HoldingsClass>> getMultipleHoldings() async {
    try {
      QuerySnapshot<dynamic> documentsSnap =
          await _holdings.orderBy("date").get();

      return documentsSnap.docs
          .map(
            (document) => HoldingsClass(
              createdTime: DateTime.now(),
              title: document['title'].toString(),
              price: document['price'].toString(),
              quantity: document['quantity'].toString(),
              date: DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(document['date'])),
              brokerage: document['brokerage'].toString(),
              investmentType: document['investmentType'].toString(),
              accountNumber: document['accountNumber'].toString(),
              action: document['action'].toString(),
              totalPrice: document['totalPrice'].toString(),
              commission: document['commission'].toString(),
              vat: document['vat'].toString(),
              totalAmount: document['totalAmount'].toString(),
              id: document['id'],
            ),
          )
          .toList();
    } catch (err) {
      print('err in FirestoreService.getMultipleHoldings: $err');
      return null;
    }
  }

  /// Add single holding to Firestore.
  Future<void> addHolding(HoldingsClass holding) async {
    try {
      await _holdings.add({
        'title': holding.title,
        'price': double.parse(holding.price),
        'quantity': double.parse(holding.quantity),
        'date':
            DateFormat('dd/MM/yyyy').parse(holding.date).millisecondsSinceEpoch,
        'brokerage': holding.brokerage,
        'investmentType': holding.investmentType,
        'accountNumber': int.parse(holding.accountNumber),
        'action': holding.action,
        'totalPrice': double.parse(holding.totalPrice),
        'commission': double.parse(holding.commission),
        'vat': double.parse(holding.vat),
        'totalAmount': double.parse(holding.totalAmount),
        'id': holding.id
      });
    } catch (err) {
      print('err in FirestoreService.addHolding: $err');
    }
  }

  /// Remove a specific holding in Firestore.
  Future<void> removeHolding(HoldingsClass holding) async {
    try {
      QuerySnapshot<dynamic> documentsSnap =
          await _holdings.where('id', isEqualTo: holding.id).get();

      String docsID = documentsSnap.docs.single.id;

      _holdings
          .doc(docsID)
          .delete()
          .then((value) => print("holding deleted in Firestore"))
          .catchError(
              (err) => print("Failed to delete holding in Firestore: $err"));
    } catch (err) {
      print('error in FirestoreService.removeHolding: $err');
    }
  }

  /// Update single holding in Firestore.
  Future<void> updateHolding(HoldingsClass holding) async {
    try {
      // to retreive the id in firestore document (not id field in holding)
      QuerySnapshot<dynamic> documents =
          await _holdings.where('id', isEqualTo: holding.id).get();

      String docsID = documents.docs.single.id;
      print("DOC ID: " + docsID);
      print(
        "HOLDING DATE:" +
            DateFormat('dd/MM/yyyy')
                .parse(holding.date)
                .millisecondsSinceEpoch
                .toString(),
      );

      _holdings
          .doc(docsID)
          .update({
            'title': holding.title,
            'price': double.parse(holding.price),
            'quantity': double.parse(holding.quantity),
            'date': DateFormat('dd/MM/yyyy')
                .parse(holding.date)
                .millisecondsSinceEpoch,
            'brokerage': holding.brokerage,
            'investmentType': holding.investmentType,
            'accountNumber': int.parse(holding.accountNumber),
            'action': holding.action,
            'totalPrice': double.parse(holding.totalPrice),
            'commission': double.parse(holding.commission),
            'vat': double.parse(holding.vat),
            'totalAmount': double.parse(holding.totalAmount),
          })
          .then((value) => print("update to Firestore success"))
          .catchError((err) => print("update to Firestore failed: $err"));
    } catch (err) {
      print('err in FirestoreService.updateHolding: $err');
    }
    return;
  }
}
