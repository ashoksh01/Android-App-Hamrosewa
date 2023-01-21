import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/model/cart_model.dart';
import 'package:najikkopasal/model/create_order_model.dart';
import 'package:najikkopasal/model/shipping_model.dart';
import 'package:najikkopasal/screens/cart/cart_provider.dart';
import 'package:najikkopasal/screens/home/components/nav.dart';
import 'package:najikkopasal/size_config.dart';
import 'package:najikkopasal/widget/error_snakbar.dart';
import 'package:najikkopasal/widget/successbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:najikkopasal/api/payment_services.dart';

class MultiStepForm extends StatefulWidget {
  static String routeName = '/multi_step_form';
  const MultiStepForm({Key? key}) : super(key: key);

  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  // the current step
  int _currentStep = 0;
  String? name;
  Map<String, dynamic>? paymentIntentData;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  bool _isVerticalStepper = true;

  // make globel key
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? address;
  
  List<OrderItems> carts = [];
  ShippingModel? shippingModel;

  
  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  _continue() {
    if (_formKey.currentState!.validate()) {
      ShippingModel shipping = ShippingModel(
        address: _addressController.text,
        city: _cityController.text,
        pincode: _pincodeController.text,
        phone: _phoneController.text,
        country: _countryController.text,
        state: _stateController.text,
      );
      print(shipping.address);

      shipping.setAllData(shipping);
      print("shipping data saved");

      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    }
  }

  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  double? totalamount;
  List<Cart>? ca;
  // add ca to cartitems list
  List<OrderItems> _mapCartToOrderItems(List<Cart> carts) {
    List<OrderItems> orderItems = [];
    for (Cart cart in carts) {
      orderItems.add(OrderItems(
          product: cart.productId,
          quantity: cart.quantity,
          price: cart.productPrice,
          image: cart.image,
          name: cart.productName));
    }
    return orderItems;
  }

 

 
  Future<ShippingModel> getShippingData() async {
    ShippingModel shipping = ShippingModel().getAllData() as ShippingModel;
    print(shipping.address);
    return shipping;
  }

  void getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      totalamount = prefs.getDouble('total_price');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final PaymentController controller = Get.put(PaymentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Processing',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  colorScheme: const ColorScheme.light(primary: kPrimaryColor)),
              child: Stepper(
                // vertical or horizontial
                type: StepperType.vertical,
                physics: const ScrollPhysics(),

                currentStep: _currentStep,

                onStepTapped: (step) => _stepTapped(step),
                onStepContinue: _continue,
                onStepCancel: _stepCancel,
                steps: [
                  Step(
                    title: const Text('Shipping'),
                    content: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildAddressFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildCityFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildPincodeFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildPhoneFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildCountryFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildStateFormFild(),

                              // buildNameFormFild(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The second step: Phone number
                  Step(
                    title: const Text('Confirm Order'),
                    content: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(children: const [
                              Text(
                                'Shipping Details',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]),

                            // make shiiping details summary
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Name: $name",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Phone : ${_phoneController.text}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Address :${_addressController.text}",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          const Text("Your Cart Items",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          FutureBuilder(
                              future: cart.getData(),
                              builder: (context,
                                  AsyncSnapshot<List<Cart>> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  CachedNetworkImage(
                                                      height: 110,
                                                      width: 110,
                                                      fit: BoxFit.cover,
                                                      imageUrl: snapshot
                                                          .data![index].image
                                                          .toString()),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .productName
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                                  .unitTag
                                                                  .toString() +
                                                              " " +
                                                              snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "$totalamount",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The third step: Verify phone number
                  Step(
                    title: const Text('Payment'),
                    content: InkWell(
                      onTap: () async {
                        await makePayment(
                            totalamount!.toStringAsFixed(0).toString());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormFild() {
    return TextFormField(
      controller: _addressController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Address";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        border: OutlineInputBorder(),
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCityFormFild() {
    return TextFormField(
      controller: _cityController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter City";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "City",
        hintText: "Enter your City",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPincodeFormFild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _pincodeController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Pincode";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Pincode",
        hintText: "Enter your Pincode",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneFormFild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _phoneController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter PhoneNumber";
        } else if (value.length <= 9) {
          return "PhoneNumber should be at least 10 characters long";
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "PhoneNumber",
        hintText: "Enter your PhoneNumber",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCountryFormFild() {
    return TextFormField(
      controller: _countryController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Country";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Country",
        hintText: "Enter your Country",
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildStateFormFild() {
    return TextFormField(
      controller: _stateController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter State";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "State",
        hintText: "Enter your State",
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future<void> makePayment(String? total) async {
    // paymnet instant method

    try {
      paymentIntentData = await createPaymentIntent(
          total.toString(), 'INR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: stripe.SetupPaymentSheetParameters(
            customerId: paymentIntentData!['customer'] ?? 'Customer',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'ANNIE',
          ))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
              parameters: stripe.PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        // print(
        //     'payment intent iddddddddd' + paymentIntentData!['id'].toString());
        // print('Statussssssssssssssssssss' +
        //     paymentIntentData!['status'].toString());

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 1),
          content: Text(
            'Payment Successful',
            style: TextStyle(color: Colors.green),
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 3,
        ));
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                channelKey: 'basic_channel',
                title: 'Payment',
                body: "Paymnet Succesfully",
                id: 1)); //

        Navigator.pushNamed(context, Navbar.routeName);

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on stripe.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LH2CxSE7FPWZ2J85BHiduxE4RW7A3X8xl29NcLNBh8JIPxuFu22Hs7sVa2XcHF8l6Dw2AuChHPdLkaOW83dlsIn00ahPuluMB',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
