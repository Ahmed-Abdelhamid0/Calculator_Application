import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {


  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

   String  userInput='';
   String result='0';

  List<String> buttonList =
  [
    'AC','(',')','/','7','8','9','*','4','5',

    '6','+','1','2','3','-','C','0','.','=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(

        children:
        [
          SizedBox(
            height: MediaQuery.of(context).size.height/4,
            child: Column(

              children:
              [
                Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                      userInput,
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 8.0
                ),
                itemBuilder: (BuildContext context , int index)
                {
                  return CustomButton(buttonList[index]);
                },
              ),
            ),
          )
        ],
      ),
    );

  }
  Widget CustomButton (String text)
  {
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: ()
      {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow:
          [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 0.0,
              offset: Offset(-3,-3),

            ),
          ],

        ),
        child: Center(
          child: Text(
            text,
            style:TextStyle(
              color:getColor(text),
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ) ,
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text== '+' ||
        text == '-' ||
        text == 'C' ||
        text == '(' ||
        text == ')') {
      return Color.fromARGB(255, 252, 100, 100);
    }
    else
      {
        return Colors.white;
      }
  }


  getBgColor(String text) {
    if (text == 'AC') {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if (text == '=') {
      return Color.fromARGB(255, 104, 204, 159);
    }
    else
    {
      return Color(0xFF1d2630);
    }
  }

   handleButtons(String text)
   {
     if(text == 'AC') {
         userInput = '';
         result = '0';
         return;
       }
     if(text == 'C') {
      if(userInput.isNotEmpty)
        {
          userInput = userInput.substring(0,userInput.length-1);
          return;
        }
      else
        {
          return null;
        }
     }
     if(text=='=')
       {
         result = calculate(userInput);
         userInput=result;

         if(userInput.endsWith('.0')) {
           userInput = userInput.replaceAll('.0', '');
         }
         if(result.endsWith('.0'))
           {
             result=result.replaceAll('.0', '');
             return;
           }
       }

  userInput = userInput + text;

   }
}

String calculate(String userInput) {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } 
    catch (e)
    {
      return 'Error';
    }
  }
