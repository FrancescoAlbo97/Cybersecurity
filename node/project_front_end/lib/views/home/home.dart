import 'package:flutter/material.dart';
import 'package:project_front_end/widgets/app_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text('Software del direttore dei lavori', style: Theme.of(context).textTheme.bodyText2,)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      child: Text(
                        'Attraverso questa interfaccia web, il direttore dei lavori può consultare le foto scattate dal drone e salvate nella blockchain.\n'
                        'Il funzionamento del sistema è illustrato nella figura a lato:',
                        style: TextStyle(fontSize: 24, color: Colors.grey[600], fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/3.5,
                      child: Image.asset('images/downloadSchema.png'),
                    )
                ]
              ),
            ]
          ),
        )
      ),
    );
  }
}
