import 'package:contact/constants/strings.dart';
import 'package:flutter/material.dart';



class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/image/img.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Constants.loginRoute);
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(bottom: 15),
                    height: 56,
                    width: 331,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadiusDirectional.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Constants.registerRoute);
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(bottom: 15, start: 5),
                    height: 56,
                    width: 331,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadiusDirectional.circular(8),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsetsDirectional.only(bottom: 15, start: 15),
                  height: 46,
                  width: 250,
                  color: Colors.transparent,
                  child: Center(
                      child: Text(
                        'Continue as a guest',
                        style: TextStyle(color: Colors.cyan, fontSize: 18),
                      )),
                ),
              )
            ]),
      ),
    );
  }
}

