import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_for_rats/widgets/custom_form_field.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  PageController pageController = PageController();

  final _scrrenPadding = const EdgeInsets.all(20);

  //Form 1
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  //Form 2
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final List<TextEditingController> daysControllers =
      List.generate(7, (index) => TextEditingController()).toList();
  final _form1Key = GlobalKey<FormState>();
  final _form2Key = GlobalKey<FormState>();
  bool isMale = true;

  int _selectedNumOfDays = 0;

  List<String> trainingStyle = [
    'Pro Split',
    'Push, Pull and Leg',
    'Upper, Lower and HIIT',
    'Custom'
  ];
  late String selectedStyle;

  // ignore: prefer_typing_uninitialized_variables
  var deviceSize;

  @override
  void initState() {
    super.initState();
    selectedStyle = trainingStyle[0];
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    slideAnimation = Tween<Offset>(
            begin: const Offset(-0.15, -0.15), end: const Offset(0.5, 0.5))
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.4),
          ),
          PageView(
            allowImplicitScrolling: false,
            onPageChanged: (value) => setState(() {
              FocusScope.of(context).unfocus();
              _currentPageIndex = value;
            }),
            controller: pageController,
            children: [
              firstWelcomePage(context),
              secondWelcomePage(context),
              thirdWelcomePage(context),
              const Text('Welcome2'),
            ],
          ),
          buildDots(_currentPageIndex)
        ],
      ),
    );
  }

  Padding firstWelcomePage(BuildContext context) {
    return Padding(
      padding: _scrrenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.65),
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Just for rats is an app for gym rats to help them track  their performance during their exercise.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          Row(
            children: [
              const Spacer(),
              InkWell(
                  onTap: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: const Row(
                    children: [
                      Text('Get Started'),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }

  secondWelcomePage(BuildContext context) {
    return Padding(
      padding: _scrrenPadding,
      child: SingleChildScrollView(
        child: Form(
          key: _form1Key,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Text(
                'Enter your data',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Text('Name', style: TextStyle(fontSize: 18)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                          return null;
                        },
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                            labelText: 'Enter your name',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Text('Age', style: TextStyle(fontSize: 18)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.139),
                    Expanded(
                      child: TextFormField(
                        controller: _ageController,
                        cursorHeight: 20,
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                          if (int.tryParse(value) == null) {
                            return 'Wrong format';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 18),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: 'Enter your age',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 12),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Text('Gender', style: TextStyle(fontSize: 18)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.068),
                    Expanded(
                      child: Row(
                        children: [
                          RadioMenuButton(
                              value: true,
                              groupValue: isMale,
                              onChanged: (val) {
                                setState(() {
                                  isMale = val!;
                                });
                              },
                              child: Text(
                                'Male',
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                          RadioMenuButton(
                            value: false,
                            groupValue: isMale,
                            onChanged: (val) {
                              setState(() {
                                isMale = val!;
                              });
                            },
                            child: Text(
                              'Female',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.27),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        if (_form1Key.currentState!.validate()) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  thirdWelcomePage(BuildContext context) {
    return Padding(
      padding: _scrrenPadding,
      child: SingleChildScrollView(
        child: Form(
          key: _form2Key,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'More information',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              CustomFormField(
                  title: 'Weight',
                  label: 'Enter your weight (Kg)',
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                    return null;
                  },
                  controller: _weightController),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomFormField(
                  title: 'Height',
                  label: 'Enter your height (cm)',
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                    return null;
                  },
                  controller: _heightController,
                  onFieldSubmitted: (_) {
                    setState(() {});
                  }),
              SizedBox(height: deviceSize.height * 0.02),
              Row(
                children: [
                  const Text('BMI', style: TextStyle(fontSize: 18)),
                  SizedBox(
                    width: deviceSize.width * 0.44,
                  ),
                  Text(calculateBMI().toStringAsFixed(1))
                ],
              ),
              SizedBox(height: deviceSize.height * 0.02),
              Row(
                children: [
                  const Text(
                    'How many days do u train at week?',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: _selectedNumOfDays,
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: Colors.black,
                          items: List.generate(
                              8,
                              (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(index.toString()),
                                  )),
                          onChanged: (newIndex) {
                            setState(() {
                              _selectedNumOfDays = newIndex!;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Select your training style',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        child: DropdownButton(
                          value: selectedStyle,
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: Colors.black,
                          items: trainingStyle
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (newIndex) {
                            setState(() {
                              selectedStyle = newIndex!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (selectedStyle == 'Custom')
                SizedBox(
                  height: deviceSize.height * 0.5,
                  child: ListView.builder(
                    itemCount: _selectedNumOfDays,
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CustomFormField(
                          title: 'Day ${index + 1}',
                          label: 'Target muscles',
                          validator: (String? value) {
                            if (value!.isEmpty) return 'Required';
                            return null;
                          },
                          controller: daysControllers[index],
                          keyboardType: TextInputType.name),
                    ),
                  ),
                ),
              if (selectedStyle != 'Custom')
                SizedBox(height: deviceSize.height * 0.35),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        if (_form2Key.currentState!.validate()) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Finish',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  double calculateBMI() {
    if (_weightController.text == '' || _heightController.text == '') return 0;
    final weight = double.parse(_weightController.text);
    final height = double.parse(_heightController.text);
    return (weight / pow(height / 100, 2));
  }

  buildDots(int currentPageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          currentPageIndex > 0
              ? Icons.check_circle
              : Icons.check_circle_outline_outlined,
          color: Colors.white,
          size: 14,
        ),
        Icon(
          currentPageIndex > 1
              ? Icons.check_circle
              : Icons.check_circle_outline_outlined,
          color: Colors.white,
          size: 14,
        ),
        Icon(
          currentPageIndex > 2
              ? Icons.check_circle
              : Icons.check_circle_outline_outlined,
          color: Colors.white,
          size: 14,
        ),
      ],
    );
  }
}
