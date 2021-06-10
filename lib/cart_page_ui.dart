import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

class CartUI extends StatefulWidget {
  const CartUI({Key? key}) : super(key: key);

  @override
  _CartUIState createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  String _imgAddress =
      'https://images-na.ssl-images-amazon.com/images/I/61X5N08zQgL._SL1000_.jpg';
  int _quantity = 1;
  int _topup = 30;
  String _title = 'Tata Tea Gold (1 Kg)';
  double _salePrice = 531;
  double _price = 625;
  List<bool> days = [true, false, false, false, false, false, false];
  DateTime? _startDate;
  String? _startDateString = 'Pick a date';

  saveDataToLocalStorage() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/order.txt');
    String dataToSaveAsText =
        'Item: $_title \nPrice: $_salePrice \nQuantity: $_quantity \nTop up: $_topup \nStart Date: $_startDateString \nRepeat: $days \n';
    await file.writeAsString(dataToSaveAsText).then(
          (_) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Saved Data to Local Storage'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('OK'))
              ],
            ),
          ),
        );
    Navigator.pop(context);
  }

  summartDialog() {
    return showCupertinoDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                margin: EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'ORDER SUMMARY',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('\nPrice: ₹$_salePrice',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('Quantity: $_quantity',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('Top up: $_topup Deliveries',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child:
                          Text('Repeat: $days', style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('Start date: $_startDateString',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                          '\nFINAL AMOUNT: ₹${_salePrice * _quantity * _topup}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      saveDataToLocalStorage();
                    },
                    child: Text('PROCEED'))
              ],
            ));
  }

  deliveriesDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Set Recharge / Top up'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('CANCEL'))
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('10 Deliveries'),
                    onTap: () {
                      setState(() {
                        _topup = 10;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('20 Deliveries'),
                    onTap: () {
                      setState(() {
                        _topup = 20;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('30 Deliveries'),
                    onTap: () {
                      setState(() {
                        _topup = 30;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.white,
        title:
            Text('Create subscription', style: TextStyle(color: Colors.black)),
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemHeader(
                imgAddress: _imgAddress,
                title: _title,
                salePrice: _salePrice,
                price: _price),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text('  Quantity'),
              subtitle: Text('  per day'),
              trailing: Container(
                decoration: BoxDecoration(
                    border: Border(), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity -= 1;
                        });
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.teal,
                      ),
                    ),
                    Text(_quantity.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity += 1;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.repeat_sharp),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  Repeat'),
                    WeekdaySelector(
                      values: days,
                      onChanged: (day) {
                        final index = day % 7;
                        setState(() {
                          days[index] = !days[index];
                        });
                      },
                    )
                  ],
                )),
            Divider(),
            ListTile(
                onTap: deliveriesDialog,
                leading: Icon(Icons.replay_circle_filled_outlined),
                title: Text('  Recharge / Top up'),
                subtitle: Text(
                  '  $_topup Deliveries',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),
            Divider(),
            ListTile(
                onTap: () async {
                  _startDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2050),
                  );
                  if (_startDate != null)
                    setState(() {
                      _startDateString =
                          DateFormat('dd-MM-yyyy').format(_startDate!);
                    });
                },
                leading: Icon(Icons.calendar_today_outlined),
                title: Text('  Start date'),
                subtitle: Text(
                  '  $_startDateString',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),
            Divider()
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextButton(
            onPressed: null,
            child: Text('DELIVER ONCE', style: TextStyle(color: Colors.teal)),
            style: TextButton.styleFrom(backgroundColor: Colors.white),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextButton(
            onPressed: summartDialog,
            child: Text('SUBSCRIBE', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: Colors.teal),
          ),
        )
      ],
    );
  }
}

class ItemHeader extends StatelessWidget {
  const ItemHeader({
    Key? key,
    required String imgAddress,
    required String title,
    required double salePrice,
    required double price,
  })  : _imgAddress = imgAddress,
        _title = title,
        _salePrice = salePrice,
        _price = price,
        super(key: key);

  final String _imgAddress;
  final String _title;
  final double _salePrice;
  final double _price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.teal[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  _imgAddress,
                  fit: BoxFit.contain,
                  // scale: 1.0,
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                _title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '₹$_salePrice  ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  TextSpan(
                      text: '₹$_price',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough)),
                  TextSpan(
                      text: '  ·  1 Pkt',
                      style: TextStyle(
                        color: Colors.grey[600],
                      )),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
            ],
          )
        ],
      ),
    );
  }
}
