import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Splitter',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: BillSplitter(),
    );
  }
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  double _billamount=0;
  int _tipspercentage = 0;
  int _personcounter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text('Bill splitter'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child:ListView(children: <Widget>[
          
          
            
           
              
              Container(
               
                width:150.0,
                height:150.0,
                decoration:BoxDecoration(border: Border.all(width:1.0),
                color: Colors.purpleAccent.shade100.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Total per person',style: TextStyle(color:Colors.blue.shade900,fontSize: 25),),
                  ),
                  Padding(
                    
                    padding: const EdgeInsets.only(top:30.0),
                    child: Text('\$ ${calculateTotalperPerson(_billamount,_personcounter,_tipspercentage)}',style: TextStyle(color:Colors.blue.shade900,fontSize: 25),),
                  ),
                ]
              ),
              ),
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Container(
                decoration:BoxDecoration(
                  border: Border.all(width:1),
                 borderRadius: BorderRadius.circular(15)
                  
                  ),
                
child: Column(
  children:<Widget>[

    Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(decimal:true),
        style: TextStyle(color:Colors.purple,),
        decoration: InputDecoration(
          hintText:'Bill amount',
          prefixIcon: Icon(Icons.attach_money),
          
        ),
        onChanged: (String value){
        try{
       _billamount = double.parse(value);
        }
        catch(ex){
       _billamount = 0;
        }
        },
        ),
       
    ),
     Row(children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(left:20.0),
         child: Text('Split',style: TextStyle(fontSize:20),),
       ),
       
          Padding(
            padding: const EdgeInsets.only(left:150.0),
            child: InkWell(
              onTap:(){
              setState((){
            if(_personcounter >1){
              _personcounter--;
            }
            else{
              //do nothing this is only to stop negative no of person
            }
              });
              },
              
              child:Container(
                width: 40.0,
                height: 40.0,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(7.0),
                  color:Colors.purple.withOpacity(0.1)
                ),
                child: Center(child: Text('-',style:TextStyle(color: Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0))),
              )
            ),
          ),
          Text('$_personcounter',style: TextStyle(color: Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0),
          ),
          InkWell(
         onTap: (){
           setState(() {
             _personcounter++;
           });
         },
         child: Container(
             width: 40.0,
              height: 40.0,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(7.0),
                color:Colors.purple.withOpacity(0.1)
              ),
              child: Center(child: Text('+',style:TextStyle(color: Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0))),
         ),
          ),
          //For Tips

        
        ],
        ),
  Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.only(left:18.0),
                child: Text('Tip',style:TextStyle(color: Colors.black,fontSize:20.0)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('\$${calculateTotalTip(_billamount,_personcounter,_tipspercentage)}',style:TextStyle(color: Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0)),
              )
            ]
          ),

          Column(
            children:<Widget>[
              Text('$_tipspercentage %',style:TextStyle(color: Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0))
            ]
          ),
          Column(
            children:<Widget>[
              Slider(
                value: _tipspercentage.toDouble(),
                 onChanged: (double newvalue){
            setState(() {
              _tipspercentage = newvalue.round();
            });
              },
              min: 0,
              max: 100,
              activeColor: Colors.purple,
              inactiveColor: Colors.grey,
              
              )
            ]
          )

  ]
),

              ),
            )
          
        ],
        )
      ),
    );
  }
  calculateTotalperPerson( double billAmount, int splitBy,int tipPercentage){
var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage)+billAmount)/splitBy;
return totalPerPerson.toStringAsFixed(2);
  }
  calculateTotalTip(double billAmount,int splitBy,int tipPercentage){
    double totalTip = 0.0;
    if(billAmount < 0||billAmount==null||billAmount.toString().isEmpty){
//none

    }
    else{
      totalTip = (billAmount * tipPercentage)/100;
      return totalTip;
    }
  }
}

