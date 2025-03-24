import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_india/upi_india.dart';

import '../../Service/ApiService.dart';
import '../../common/constant.dart';
import '../../network_checker/network_cheker.dart';
import '../../network_checker/network_error_common.dart';
import '../dashboard/dashboard.dart';

class UpiPaymentScreen extends StatefulWidget {
  double amount;

  UpiPaymentScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  ConnectivityProvider _connectivityProvider = Get.put(ConnectivityProvider());
  UpiPaymentScreen amt = UpiPaymentScreen(
    amount: 20,
  );
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();

  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _connectivityProvider.startMonitoring();
    print("objecttrs1");
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });

    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "${Constant.defaultUpiID}",
      //"bharatpe.9041364570@icici",
      receiverName: 'Cashlook Gamer',
      transactionRefId: 'UpiIndiaGamer',
      transactionNote: 'Earn with Gamer Attitude',
      amount: widget.amount,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status, String txnId) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        trans(txnId, status);
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
            child: Text(
              body,
              style: value,
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> apiTransaction() async {
  //   await PostService.transactionData(reqBody: {
  //     "user_id": "${Constant.userSession}",
  //     "txid": "${txnId}",
  //     "txstatus": "${DashboardScreen.wallet}",
  //     "txamount": widget.amount
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI'),
      ),
      body: GetBuilder<ConnectivityProvider>(
        builder: (controller) {
          if (controller.isOnline!) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: displayUpiApps(),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _transaction,
                    builder: (BuildContext context,
                        AsyncSnapshot<UpiResponse> snapshot) {
                      print("API CALL RESPONSE");
                      print(snapshot);
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              _upiErrorHandler(snapshot.error.runtimeType),
                              style: header,
                            ), // Print's text message on screen
                          );
                        }

                        // If we have data then definitely we will have UpiResponse.
                        // It cannot be null
                        UpiResponse _upiResponse = snapshot.data!;
                        print("_upiResponse");
                        print(_upiResponse);
                        print(snapshot.data);
                        print(_upiResponse.status);

                        // Data in UpiResponse can be null. Check before printing
                        String txnId = _upiResponse.transactionId ?? 'N/A';
                        String resCode = _upiResponse.responseCode ?? 'N/A';
                        String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                        String status = _upiResponse.status ?? 'N/A';
                        String approvalRef =
                            _upiResponse.approvalRefNo ?? 'N/A';
                        _checkTxnStatus(status, txnId);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // displayTransactionData('Transaction Id', txnId),
                              // displayTransactionData('Response Code', resCode),
                              // displayTransactionData('Reference Id', txnRef),
                              // displayTransactionData(
                              //     'Status', status.toUpperCase()),
                              // displayTransactionData(
                              //     'Approval No', approvalRef),
                              // displayTransactionData("Response", _upiResponse),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(''),
                        );
                      }
                    },
                  ),
                )
              ],
            );
          } else {
            return const NetworkError();
          }
        },
      ),
    );
  }

  Future<void> trans(String txnId, String status) async {
    var tranresponse = await PostService.transactionData(
      reqBody: {
        "user_id": "${Constant.userSession}",
        "txid": txnId,
        "txstatus": status,
        "txamount": widget.amount.toString(),
      },
    );
    print(tranresponse);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }
}
