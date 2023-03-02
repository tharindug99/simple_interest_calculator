import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var currencies = ['Dollars', 'Rupees','Pounds'];
  var currentItemSelected = '';

  @override
  void initState(){
    super.initState();
    currentItemSelected = currencies[0];
  }

  var displayText = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController RateOfInterestController = TextEditingController();
  TextEditingController TermController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false , ///////////Prevent Pixel Overflow

      appBar: AppBar(
        //backgroundColor: Colors.amber,
        title: const Center(
            child: Text('Simple Interest Calculator', style: TextStyle(
              //color: Colors.black
            ),
            )
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(

          children: [

            Center(child: getImageAsset()),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                keyboardType: TextInputType.number,
                controller: principalController,
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g. 12000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
            ),
             ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: RateOfInterestController,
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'Enter Rate e.g. 5',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: TextField(
                        controller: TermController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 2.0,right: 2.0),
                    margin: EdgeInsets.only(left: 20.0,right: 2.0),
                  ),

                  Expanded(
                    child: DropdownButton(items: currencies.map((String value) {
                      return DropdownMenuItem <String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                      value: currentItemSelected,

                      onChanged: (String? newValueSelected) {
                          onDropDownItemSelected( newValueSelected!);
                    },
                    ),
                  )


                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  Expanded(child: ElevatedButton(onPressed: () {

                    setState(() {
                      this.displayText = calculateTotalReturns();
                    });
                  }, child: Text('Calculate'),

                    ),
                  ),

                  Expanded(child: ElevatedButton(onPressed: () {

                    setState(() {
                       reset();
                    });
                  }, child: Text('Reset'),

                  ),
                  )
                ],

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(displayText),
            )

          ],
        ),
      ),
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 300, height: 200,);


    return Container(child: image,);
  }

  void onDropDownItemSelected( String newValueSelected){   ///function for dropdown menu selection
      setState(() {
        this.currentItemSelected = newValueSelected;
      });

  }

  String calculateTotalReturns(){

    double principal = double.parse(principalController.text);
    double roi = double.parse(RateOfInterestController.text);
    double term = double.parse(TermController.text);

    double totalAmountpayable = principal + (principal * roi * term)/100  ;

    String result = 'After $term years, your investment will be worth $totalAmountpayable $currentItemSelected';

    return result;
  }


  void  reset(){
    principalController.text = '';
    RateOfInterestController.text = '';
    TermController.text = '';
    displayText = '';

  }
}





