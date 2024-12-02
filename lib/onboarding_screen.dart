import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  final List<String> onboardingTexts = [
    "Welcome to FitLife",
    "Track Your Progress",
    "Achieve Your Goals"
  ];

  final List<String> onboardingSubTexts = [
    "Your journey to a healthier lifestyle starts here!",
    "Monitor your workouts and stay motivated.",
    "Set goals and push your limits every day."
  ];

  final List<IconData> onboardingIcons = [
    Icons.fitness_center,
    Icons.timeline,
    Icons.emoji_events,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Standard white background
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Step ${currentIndex + 1} of ${onboardingTexts.length}",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: onboardingTexts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Container for the Icon
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Transform.scale(
                            scale: currentIndex == index ? 1.2 : 1.0,
                            child: Icon(
                              onboardingIcons[index],
                              size: 100,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        // Animated Text for Title
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: currentIndex == index ? 1.0 : 0.0,
                          child: Text(
                            onboardingTexts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Animated Text for Subtitle
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: currentIndex == index ? 1.0 : 0.0,
                          child: Text(
                            onboardingSubTexts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Dot Indicators with animation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingTexts.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.all(4),
                  width: currentIndex == index ? 16 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.blue : Colors.grey,
                    shape: BoxShape.circle,
                    boxShadow: currentIndex == index
                        ? [
                            BoxShadow(
                                color: Colors.blue.withOpacity(0.5),
                                blurRadius: 5)
                          ]
                        : [],
                  ),
                );
              }),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text("Back", style: TextStyle(color: Colors.blue)),
                    ),
                  Spacer(),
                  if (currentIndex < onboardingTexts.length - 1)
                    TextButton(
                      onPressed: () {
                        _pageController.jumpToPage(onboardingTexts.length - 1);
                      },
                      child: Text("Skip", style: TextStyle(color: Colors.blue)),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (currentIndex == onboardingTexts.length - 1) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  currentIndex == onboardingTexts.length - 1
                      ? "Get Started"
                      : "Next",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
