# iOS UI Seminar (17.06.30)

## **iOS UI 만드는 방법**

1. Xcode로 iOS UI를 만드는 방법에 대해서
 - Interface builder
    - Storyboard:
      - A storyboard is a visual representation of the user interface of an iOS application, showing screens of content and the connections between those screens. A storyboard is composed of a sequence of scenes, each of which represents a view controller and its views; scenes are connected by segue objects, which represent a transition between two view controllers.

    - XIB
      - XIB stands for the XML Interface Builder. Interface Builder is a software application which allows you to develop Graphical User Interface with the help of Cocoa and carbon. The generated files are either stored as NIB or XIB files. These files are copied into the app bundle and loaded at run time to provide the user interface for the application. XIB files were introduced in 2007 with Leopard (Xcode 3.0). XIB files is not a package, but a self-contained XML file. Xcode will convert the XIB file into deploy-able NIB when the project is built and will include the NIB file in the finished application.
 - Code
 - When to use code
    - Dynamic layouts.
    - Views with effects, such as rounded corners, shadows, etc.
    - Any case in which using NIBs and Storyboards is complicated or infeasible.

2. Design guide
 - 디자이너와 작업하며 권장하는 디자인 가이드 방법
    - Textbox width와 height는 디바이스 또는 폰트에 맞게 유동적으로 가이드 해주는게 좋음.
    - 비슷한 형식의 뷰들은 class화 해서 재사용하기 용이하도록 가이드를 해주는게 좋음.

3. Animation
 - Arrow button animation 만드는 방법.
 - Song quiz fluid animation 만드는 방법.
