import 'package:flutter/material.dart';

import '../screens/signupscreen/signup_screen.dart';
import '../widgets/footer.dart';

class bmemeber extends StatelessWidget {
  const bmemeber({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 1,),
            const Center(child: Text('Become a member today',style: TextStyle(color: Color(0xFFF5951B),fontSize: 22),)),
            const SizedBox(height: 5,),
            const Text('Register now',style: TextStyle(color: Colors.black54,fontSize: 18),),
            const SizedBox(height: 10,),
            FilledButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen(),));
              
            }, child: const Text('Sign Up',)),
            const Spacer(),
            footer()
          ],
        ),
      ),
    );
  }
}
