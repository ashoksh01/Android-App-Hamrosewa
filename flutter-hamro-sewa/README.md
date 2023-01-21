# NajikoPasal 

MultiVendor Ecommerce Application

## **Introduction**

As internet service has expanded, businesses and individuals have started to employ online platforms for the efficiency and speed of business initiatives. Online shopping has turned into a time-consuming pastime for consumers. The user can learn more about products when shopping. Ecommerce is a priority in the design of my Android application. As a result, I developed the multi-vendor app NajikoPasal, which features all kinds of goods. Using the flutter framework, it was developed. The MERN stack, whose API is being utilized in this application, is also being used to create this project as a website. Any user can operate as both an administrator and a user in this project.

## Features of Project

### User features
1.	**Login**
2.	**Register**
3.	**Filter product option for buy**
4.	**Comment**
5.	**Rating**
6.	**Order**
7.	**Search**
8.	**Add to cart**
9.	**Order history**
10.	**Order Details**
11.	**Edit profile**
12.**User image upload in user profile**
13.	**Change password**
14.	**Payment**

#### Admin Features
1.	**Manage product, user and order**

#### Other Features
1.	**Gyro sensor(Shake Sensor)**
2.	**Map(Gps Location tracking sensor)**
##
## Technology used

### Flutter:
Flutter is an open-source platform for developing applications from a single codebase. I chose Flutter over native react and other platforms because it allows us to write a single codebase that can be used across multiple platforms such as desktop, web, Android, and iOS.


### MongoDB:
MongoDB is a document-oriented NoSQL database that is used for large-scale data storage. MongoDB employs collections and documents rather than tables and rows as in traditional relational databases. Documents are made up of key-value pairs and the operation in mongo db are faster than other databse as well as it lighter than other database. So, I have chose this databse for my flutter project.

### Node Js
Node.js is a fixed, cross-platform, open-source runtime environment for developing fast and scalable server-side and networking applications. Multiple connections can be managed effectively by Node.js at once. Due to its serverless architecture and support for real-time communication, Node js makes a fantastic backend for these kinds of applications. Node js is faster because it is made with javascript. I chose Node js for my project due to its low learning bend, wide community due to being an open-source project.

## Challenges
The device management in Android Studio was the biggest obstacle to project implementation because it was causing problems due to outdated laptop software and virtual emulators. Another frustrating problem was the future builder process, even though all the necessary software and logic was in place. Another difficulty I had with the project was integrating payments. Futhermore, the state managing is another issue in my project while implementing add to cart and other type of features. For using different package in flutter need to configure the java file is one of the biggest problems which I have faced in this project.


## Project Architecture
A design pattern used in software development is the repository pattern. The data layer is separated from the rest of the program by this. The data layer is the section of the program that manages the data and business logic and exposes consistent APIs so that the rest of the app may access this data. It is distinct from the user interface (UI). The data layer contains things like networking code, Room databases, error handling, and other code that reads or manipulates data, while the user interface (UI) displays information to the user. In essence, it is only utilized if we operate offline. Repository functions as an in-memory domain object collection, serving as a bridge between the domain and data mapping layers. By saving data acquired from the network on the device's local storage using this pattern, our software may enable offline caching and provide faster access to data. If the device is online, it will download fresh report data from the back-end server and store it locally before displaying what is already there. Otherwise, even if the device is not online, it will quickly access the data that has been saved in a local data source like Hive or Sqflite.

## State Management
To handle the flow of data across the program, the state management system centrally manages the states of multiple UI components. This regulates the state of one or more user interface control systems. With the use of statemangent tools like provider and get X, it binds the widget and updates that particular widget when something changes. The following Statement package are used in my project:

1.	**Provider**
In essence, the provider package is a wrapper around the Inherited Widgets that makes them simpler to use and manage. It offers a state management method for controlling a piece of data within the program. To manage the cart changes over the widget I have used the provider change Notifier. It basically listens the state of widget and change after notify from ChangeNotifierProvider.

2.	**GetX**
GetX is a state management library in a flutter that is swift, reliable, and lightweight.
GetX is a powerful micro framework that we can use to manage states, provide routing, and conduct dependency injection. Information transfer inside the program is allowed thanks to state management. For setstate the  data in variable in flutter I have used getx.obs which help to setstate that particular widget without updating the whole state of app.

## Conclusion
To summarize, Najikkopasal is an ecommerce mobile application built in the flutter framework that allows users to purchase different variety of products in single platform. This is simple to use and user-friendly. It included numerous features such as login and registration, order placement, payment integration, attractive profile management, and so on. Because online shopping is more efficient, informative, and time efficient. As a result, I decided to create this application.

## Appendix
<img src="https://user-images.githubusercontent.com/64473617/182609622-bfb0e981-b244-4d65-97ce-b8f7883dd326.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609422-c49fb79a-8169-456f-a0ca-d59632bcfe1a.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609444-9d2e7e61-f343-43f6-a2db-e0279c34c272.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609506-db408f06-4497-46f0-b746-67ad6a8a97de.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609530-b52e3d99-928b-4a0f-987c-b62eee1d27d3.jp![give-review](https://user-images.githubusercontent.com/64473617/182609550-047b4b4d-805c-457c-bc92-58179baef0d1.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609655-5358b353-02a4-41c3-b0d6-3aa728c10e47.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609685-b3bf0359-84ee-4406-883d-0a52cc8dad1f.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609739-53c46a38-c436-470b-9d08-5805cf6![confirm_order](https://user-images.githubusercontent.com/64473617/182609756-c6b415bf-c03f-4b02-8a37-e2eb23e614b2.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609769-5a54170a-880f-48c9-aceb-afb4c448f517.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609799-37ce0d1c-3b47-41ae-ac1f-7b9add36dbbe.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609849-a949f7cc-9379-4c4a-b999-e30b5632ef9e.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609929-bd313f3f-8b45-40f4-8047-5a411838ae09.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609950-9710abfc-1ce8-4679-b2e2-67a1e3fc0f11.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182609967-f837221c-0f41-4147-a4![map](https://user-images.githubusercontent.com/64473617/182610030-42497467-bcd7-4938-af1e-418828ca5ce7.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182610131-bee84beb-46bd-4b90-998f-1fbb08bc66bc.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182610156-01623770-8fd2-4812-9b32-f34e7e0f79b4.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182611018-a14ce9c2-3742-408c-adc4-0c6ea591b9d![log_out](https://user-images.githubusercontent.com/64473617/182611083-cacb669c-abb2-4625-93fd-11cdc33565e8.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182610787-0a2bef2d-78cc-4843-86f0-6602d5d87a15.jpg" width="45%"></img> <img src="https://user-images.githubusercontent.com/64473617/182611204-1cf2ad30-e592-47af-b0e6-268af6dd39df.jpg" width="45%"></img> 

