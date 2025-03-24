import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:web_news/common/sound_path.dart';
import 'package:web_news/ui_screen/dashboard/coin_animation.dart';
import 'package:web_news/ui_screen/upi_india_paymentgateway/upi_paymentscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Service/ApiService.dart';
import '../../common/constant.dart';
import '../../common/image_path.dart';
import '../../common/loadingdialog.dart';
import '../../network_checker/network_cheker.dart';
import '../../network_checker/network_error_common.dart';
import '../login/signup_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final ConnectivityProvider _connectivityProvider =
      Get.put(ConnectivityProvider());

  static int winAmount = 0;
  static int wallet = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectBatRupees = 10;
  AudioPlayer player = AudioPlayer();
  double angel = 360;
  int select = 0;
  bool able = true;
  List<dynamic> amount = [10, 20, 30, 50, 100];

  int select1 = -1;
  bool moveAnim = false;

  int diceNo = 1;
  int resultNo = -1;

  TextEditingController addMoneyController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;

  Future<void> loginApiLoad() async {
    print(Constant().storage.read("id"));
    var result = await PostService.loginUser(
      reqBody: {"user_id": "${Constant().storage.read("id")}"},
    );

    if (result["flag"]) {
      setState(() {
        Constant.userSession = result["data"]["user_id"];
        Constant.email = result["data"]["email"];
        Constant.defaultUpiID = result["defaultUpiID"];
        Constant.defaultRecharge = result["defaultRecharge"];
        Constant.withdrawalAmountLimit =
            int.parse("${result["withdrawalAmountLimit"]}");
        wallet = int.parse("${result["data"]["wallet"]}");
        winAmount = int.parse("${result["data"]["win_amt"]}");
        amount = result["defaultCoins"];
        selectBatRupees = amount[0];
      });
    } else {
      logout();
    }
  }

  Future<void> update() async {
    if (Constant.userSession != null) {
      // Audio roll dice
      resultNo = -1;
      player.setAsset(Sound.dicesound);
      player.play();

      var stopTimer = false;
      Timer.periodic(const Duration(milliseconds: 80), (timer) {
        setState(() {
          angel = Random().nextDouble() * 180;
          diceNo = Random().nextInt(5) + 1;

          if (stopTimer) {
            timer.cancel();
          }
        });
      });

      var resultUser = await PostService.fetchUserResult(reqBody: {
        "user_id": "${Constant.userSession}",
        "bat_no": "$select1",
        "bat_amt": "$selectBatRupees"
      });

      Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () {
          wallet = resultUser["wallet"];
          winAmount = resultUser["win_amt"];
          stopTimer = true;
          resultNo = resultUser["bat_result"];

          Future.delayed(
            Duration(seconds: 1),
            () {
              setState(() async {
                select1 = -1;
                able = true;
                if (resultUser["bat_status"] == 1) {
                  player.setAsset(Sound.wincoin);
                  player.play();
                  await winGamePopUpView();
                  moveAnim = false;
                } else {
                  player.setAsset(Sound.losscoin);
                  player.play();
                  await loseGamePopUpView();
                  moveAnim = false;
                }
              });
            },
          );
        },
      );
    } else {
      logout();
    }
  }

  logout() {
    Constant.userSession = null;
    Constant().storage.remove("id");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  void initState() {
    _connectivityProvider.startMonitoring();

    loginApiLoad();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bigWinPopUpView();
    });
  }

  List<Widget> coins = [];

  void animateCoin(Offset startOffset) {
    final RenderBox cartRenderBox =
        cartKey.currentContext!.findRenderObject() as RenderBox;
    final Offset cartOffset = cartRenderBox.localToGlobal(Offset.zero);

    setState(() {
      print(startOffset);
      coins.add(
        CoinAnimation(
          startX: w / 2,
          startY: h / 2,
          endX: w - 10,
          endY: 0,
          // endY: 0,
        ),
      );
    });
  }

  GlobalKey cartKey = GlobalKey();
  GlobalKey buttonKey = GlobalKey();
  var w;
  var h;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF3F28CB),
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: drawerView(),
        body: GetBuilder<ConnectivityProvider>(
          builder: (controller) {
            if (controller.isOnline!) {
              return StreamBuilder(
                stream: null,
                builder: (context, snapshot) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImagePath.background),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 90,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(150),
                                      bottomRight: Radius.circular(150)),
                                  color: Color(0xFF2B37AD)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(ImagePath.diceImage),
                                      height: 90,
                                      width: 90,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Balance : $wallet",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              ImagePath.collectCoin,
                                              height: 30,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                addMoneyPopUpView();
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    ImagePath.addMoney),
                                                width: 100,
                                                height: 30,
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Winning : $winAmount",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Hero(
                                              tag: Constant.bossHero,
                                              child: Image.asset(
                                                ImagePath.collectCoin,
                                                height: 30,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (winAmount >
                                                    Constant
                                                        .withdrawalAmountLimit) {
                                                  withDrawalPopUpView();
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Oops! Sorry minimum withdrawal limit is more than ${Constant.withdrawalAmountLimit}",
                                                    fontSize: 18,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                  );
                                                }
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    ImagePath.winningBalance),
                                                width: 100,
                                                height: 30,
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Select Bet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'PoetsenOne'),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                amount.length,
                                (index) => InkWell(
                                  onTap: () {
                                    if (able == true) {
                                      setState(() {
                                        player.setAsset(Sound.click);
                                        player.play();
                                        select = index;
                                        selectBatRupees =
                                            int.parse(amount[index]);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: select == index
                                        ? MediaQuery.of(context).size.width /
                                                amount.length -
                                            amount.length
                                        : MediaQuery.of(context).size.width /
                                                amount.length -
                                            amount.length -
                                            10,
                                    width: select == index
                                        ? MediaQuery.of(context).size.width /
                                                amount.length -
                                            amount.length
                                        : MediaQuery.of(context).size.width /
                                                amount.length -
                                            amount.length -
                                            10,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/png/p${index + 1}.png",
                                        ),
                                      ),
                                      border: Border.all(
                                        color: select == index
                                            ? Colors.white.withOpacity(0.8)
                                            : Colors.black12,
                                        width: 3,
                                      ),

                                      borderRadius: BorderRadius.circular(80),
                                      // color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${amount[index]}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: select == index
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: select == index ? 20 : 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Select ODD & EVEN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'PoetsenOne'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20)
                                      .copyWith(left: 10),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (able == true) {
                                        setState(() {
                                          player.setAsset(Sound.click);
                                          player.play();
                                          select1 = 0;
                                        });
                                      }
                                    },
                                    child: Image(
                                      image: AssetImage(select1 == 0
                                          ? ImagePath.oddButton1
                                          : ImagePath.oddButton),
                                      height: 110,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          20,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (able == true) {
                                        setState(() {
                                          player.setAsset(Sound.click);
                                          player.play();
                                          select1 = 1;
                                        });
                                      }
                                    },
                                    child: Image(
                                      image: AssetImage(select1 == 1
                                          ? ImagePath.evenButton1
                                          : ImagePath.evenButton),
                                      height: 110,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //dice
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Image(
                                    image: AssetImage(ImagePath.ludoBgImage),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (select1 == -1) {
                                        Fluttertoast.showToast(
                                          msg: "Select Odd Or Even",
                                          fontSize: 18,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      } else if (wallet < selectBatRupees) {
                                        addMoneyPopUpView();
                                        Fluttertoast.showToast(
                                          msg: "Recharge your wallet amount",
                                          fontSize: 18,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      } else {
                                        if (able) {
                                          able = false;
                                          LoadingDialog().showDialog();
                                          update();
                                          LoadingDialog().hideDialog();
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Transform.rotate(
                                        angle: angel,
                                        child: Image.asset(
                                          resultNo > -1
                                              ? "assets/images/dice$resultNo.png"
                                              : "assets/images/dice$diceNo.png",
                                          // images[currentImageIndex],
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ]..addAll(coins),
                    ),
                  );
                },
              );
            } else {
              return const NetworkError();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                if (able) scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0xFF3F28CB).withOpacity(0.9)),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Image(
              image: AssetImage(ImagePath.icon1),
              height: 50,
              width: 50,
            ),
            Image(
              image: AssetImage(ImagePath.icon3),
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> bigWinPopUpView() {
    return showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: InkWell(
              onTap: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF06094E),
                  image: DecorationImage(
                      image: AssetImage(ImagePath.bigWinImage),
                      fit: BoxFit.fill),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 5, top: 5),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> winGamePopUpView() {
    return showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: InkWell(
              onTap: () {
                player.setAsset(Sound.collectcoin);
                player.play();
                setState(() {});
                Navigator.pop(context);
              },
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF06094E),
                  image: DecorationImage(
                      image: AssetImage(ImagePath.winGame), fit: BoxFit.fill),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        AnimatedAlign(
                          alignment: moveAnim == true
                              ? Alignment.bottomRight
                              : Alignment.topCenter,
                          duration: Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                          child: Hero(
                            tag: Constant.bossHero,
                            child: Image(
                                image: AssetImage(ImagePath.collectCoin),
                                height: moveAnim == true ? 150 : 50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> loseGamePopUpView() {
    return showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: InkWell(
              onTap: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF06094E),
                  image: DecorationImage(
                      image: AssetImage(ImagePath.loseGame), fit: BoxFit.fill),
                ),
                child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5, top: 5),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> addMoneyPopUpView() {
    return showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => false,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImagePath.addMoneyBg),
                      fit: BoxFit.fill),
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Add Money",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Minimum Deposit Amount is ₹ ${Constant.defaultRecharge[0]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Amount",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PoetsenOne'),
                          textAlign: TextAlign.center,
                          cursorRadius: Radius.zero,
                          controller: addMoneyController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFC4C4C4).withOpacity(0.4),
                            contentPadding: EdgeInsets.zero,
                            hintText: "Select Your Amount",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'PoetsenOne',
                                fontWeight: FontWeight.w500),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF78B5DD)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF78B5DD)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF78B5DD)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(width: 2, color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xFF78B5DD)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 55),
                      Flexible(
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Constant.defaultRecharge.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: 34,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 25),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  addMoneyController.text = Constant
                                      .defaultRecharge[index]
                                      .toString();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFFD568D8),
                                ),
                                child: Center(
                                  child: Text(
                                      '₹${Constant.defaultRecharge[index]}'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  addMoneyController.clear();
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: const Color(0xFF3F28CB),
                                ),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  addMoneyController.text.isNotEmpty
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpiPaymentScreen(
                                                    amount: double.parse(
                                                        addMoneyController
                                                            .text)),
                                          ),
                                        )
                                      : Fluttertoast.showToast(
                                          msg: "Enter your Amount",
                                          fontSize: 18,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: const Color(0xFF3F28CB),
                                ),
                                child: const Text(
                                  "Add Money",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<dynamic> withDrawalPopUpView() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF600C0C),
              image: DecorationImage(
                  image: AssetImage(ImagePath.withDrawalBg), fit: BoxFit.fill),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Withdrawal",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Minimum withdrawal Amount is 300",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Paytm/Gpay Number",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'PoetsenOne'),
                      textAlign: TextAlign.center,
                      cursorRadius: Radius.zero,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFC4C4C4).withOpacity(0.4),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Enter Your Number",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'PoetsenOne',
                            fontWeight: FontWeight.w500),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Amount",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'PoetsenOne'),
                      textAlign: TextAlign.center,
                      cursorRadius: Radius.zero,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFC4C4C4).withOpacity(0.4),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Enter Your Amount",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'PoetsenOne',
                            fontWeight: FontWeight.w500),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xFF78B5DD)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xFF3F28CB),
                            ),
                            child: const Text(
                              "Close",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color(0xFF3F28CB),
                          ),
                          child: const Text(
                            "Withdrawal",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> logoutPopUpView() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("LOGOUT"),
          content: const Text("Are you sure, do you want to logout??"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () => logout(),
            ),
          ],
        );
      },
    );
  }

  Widget drawerView() {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Drawer(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFF2B37AD).withOpacity(0.5),
              image: DecorationImage(
                  image: AssetImage(ImagePath.background), fit: BoxFit.fill)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Image(
                        image: AssetImage(ImagePath.diceImage),
                        height: 130,
                        width: 130,
                      ),
                    ),
                    Text(
                      'User ID : ${Constant.email}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PoetsenOne',
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 5),
                    // const Text(
                    //   'Balance : Account Balance',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //       fontFamily: 'PoetsenOne',
                    //       fontWeight: FontWeight.w700),
                    // ),
                    // const SizedBox(
                    //   height: 5
                    // ),
                    // const Text(
                    //   'Winning : Winning Balance',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //       fontFamily: 'PoetsenOne',
                    //       fontWeight: FontWeight.w700),
                    // ),
                    // const SizedBox(
                    //   height: 15
                    // ),
                    const Divider(
                      color: Colors.white,
                    ),
                    // drawerMenuView(() {
                    //   Navigator.pop(context);
                    // }, Icons.person, 'Dashboard'),
                    // drawerMenuView(() {
                    //   withDrawalPopUpView();
                    // }, Icons.money, 'WithDrawal'),
                    drawerMenuView(() {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=com.ludoceshreward.app');
                    }, Icons.share, 'Share this app'),
                    drawerMenuView(() {
                      launchUrl(Uri.parse(
                          'https://sites.google.com/view/ludoceshreward/home'));
                    }, Icons.rule, 'Terms & Conditions'),
                    drawerMenuView(() {
                      launchUrl(Uri.parse('tel:9876543210'));
                    }, Icons.support, 'Support'),
                    drawerMenuView(() {
                      logoutPopUpView();
                    }, Icons.logout, 'Logout'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerMenuView(void Function()? onTap, IconData? icon, String? title) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon!,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title!,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoetsenOne',
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
