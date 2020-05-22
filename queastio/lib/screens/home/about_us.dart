import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final String title = 'About Enable Employability Excellence PVT. LTD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
              text: TextSpan(
                  text:
                      'Enable Employee Excellence \(Enable\) is a platform for bridging the employability gaps prevalent among career-oriented population. Our programs are rooted in a deep understanding of the employability problem by considering multiple perspectives such as those of the employers, academia, students and policy makers. Our PURPOSE is “ Employability for All ”'),
        ),
      ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      text:
                      'Enable Employee Excellence \(Enable\) is a platform for bridging the employability gaps prevalent among career-oriented population. Our programs are rooted in a deep understanding of the employability problem by considering multiple perspectives such as those of the employers, academia, students and policy makers. Our PURPOSE is “ Employability for All ”'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      text:
                      'Enable Employee Excellence \(Enable\) is a platform for bridging the employability gaps prevalent among career-oriented population. Our programs are rooted in a deep understanding of the employability problem by considering multiple perspectives such as those of the employers, academia, students and policy makers. Our PURPOSE is “ Employability for All ”'),
                ),
              ),
            ],
          )
// OBJECTIVES

// • Channelize the energy of our youth towards a purposeful career. Help them make an informed
// choice in sync with their interest &amp; ability
// • Provide a quantifiable measure of Employability Readiness
// • Provide a platform for practicing professionals to contribute towards Employability Excellence,
// without having to compromise on their work commitments

// OUR APPROACH
// Our objectives are derived from our purpose of “ Employability for All ”
// We aim to:
// • Continually refine our understanding of the Employability Problem through structured
// engagement with all stakeholders
// • Play back the ‘Industry Expectations’ to the Academia and Students. Incorporate these
// expectations in all our programs
// • Influence the policymaking bodies to incorporate the ‘Industry Expectations’ into academic
// curriculum

// CONTACT US:
// WEBSITE: www.enable-careers.com
// E-MAIL:jobs@enable-careers.com`),
          ),
    );
  }
}
