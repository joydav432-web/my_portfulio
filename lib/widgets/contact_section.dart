
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants/colors.dart';
import 'customtext_formfield.dart';
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
      color: CustomColor.bgLight1,
      child: Column(
        children: [
          Text("Get in Touch",style: TextStyle(

              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary
          ),),


          SizedBox(height: 50),

          ConstrainedBox(
            constraints:BoxConstraints(
                maxWidth: 700,
              maxHeight:  100
            ),
            child: LayoutBuilder(builder: (context, constraints){
              if(constraints.maxWidth>=600){
                return buildNameEmailFileDesktop();

              }return buildEmailFileMobile();
            })
          ),

          SizedBox(height: 15,),

          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 700
            ),
            child: CustomTextFiled(
              hintText: "Your message",
              maxline: 10,
            ),
          ),

          SizedBox(height: 30,),

          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 700
            ),
            child: SizedBox(
              width: double.maxFinite,

              child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.yellowSecondary,


                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),

                      )
                  ),
                  child: Text("Get on Touch",
                    style: TextStyle(
                        color: CustomColor.whiteSecondary),
                  )),
            ),
          ),

          SizedBox(height: 15,),

          ConstrainedBox(

              constraints: BoxConstraints(
                  maxWidth: 300
              ),
              child: Divider()),

          SizedBox(height: 15,),

          Wrap(
            spacing: 12,runSpacing: 12,runAlignment: WrapAlignment.center,
            children: [
              InkWell(
                  onTap: (){},
                  child: Image.asset("assets/images/github.png",
                    width: 28,
                  )),


              InkWell(
                  onTap: (){},
                  child: Image.asset("assets/images/linkedin.png",
                    width: 28,
                  ))
            ],
          )



        ],
      ),

    );
  }

   Row buildNameEmailFileDesktop(){

    return Row(
      children: [
        Flexible(
            child: CustomTextFiled(
              hintText: 'Your name',

            )
        ),

        SizedBox(width: 15,),

        Flexible(child: CustomTextFiled(
          hintText: 'Email',
        ))
      ],
    );
   }



   Column buildEmailFileMobile(){
    return  Column(
      children: [
        Flexible(
            child: CustomTextFiled(
              hintText: 'Your name',

            )
        ),

        SizedBox(height: 15,),

        Flexible(child: CustomTextFiled(
          hintText: 'Email',
        ))
      ],
    );
   }
}
