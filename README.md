<a name="readme-top"></a>

<br />
<div align="center">
  <a href="https://github.com/github_username/proxy-api">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Proxi</h3>

  <p align="center">
    The ProXi Attendance System Flutter app is designed to revolutionize the traditional process of manual attendance tracking in large classrooms. This cross-platform mobile application, built with Flutter and Dart, seamlessly integrates with existing WiFi networks to provide an efficient and user-friendly solution for both faculty members and students.
    <br />
    <br />
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#backend-api">Backend API</li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

<p>The WiFi Attendance System is an innovative project designed to streamline and modernize the process of tracking and managing attendance in educational settings. Leveraging Flutter for the frontend and Node.js for the backend, this system offers a user-friendly interface for teachers, students, and administrators.</p>

<h4>Key Features</h4>

* <p><b>User Roles</b>: </p>
    <ul>
        <li><b>Teacher</b>: Manage courses, sessions, and mark attendance</li>
        <li><b>Student</b>: Join courses, track attendance, and update profile information</li>
        <li><b>Admin</b>: Create and manage teacher accounts.</li>
    </ul>
* <p><b>Local Network Communication</b>: Utilizes mDNS for service advertisement, allowing teachers to broadcast their availability on the local network.</p>
* <p><b>Secure Authentication</b>: Implements OTP-based verification for account security.</p>
* <p><b>Attendance Tracking</b>: Facilitates easy creation of courses and attendance sessions, providing real-time tracking for both teachers and students.</p>
* <p><b>Flexible and Scalable</b>: Easily scalable to accommodate additional features and user roles. The modular backend architecture ensures flexibility.</p>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![NodeJS][Node.js]][Node-url]
* [![Mongo][Mongo.js]][Mongo-url]
* [![Express][Express.js]][Express-url]
* [![Docker][Docker.js]][Docker-url]
* [![Flutter][Flutter.dev]][Flutter-url]
* [![Dart][Dart.com]][Dart-url]
* [![Shell][Shell.com]][Shell-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* Flutter
    ```bash
    https://flutter.dev/docs/get-started/install
    ```

* VSCODE
    ```bash
    https://code.visualstudio.com/download
    ```

* Genymotion
    ```bash
    https://www.genymotion.com/download/
    ```

* Oracle Virtual Box
    ```bash
    https://www.virtualbox.org/wiki/Downloads
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Installation

1. Clone the repo

    ```bash
    git clone https://github.com/Ab-Abby-19/proxy.git
    ```

2. Change directory to the cloned repo

    ```bash
    cd proxy
    ```

3. Run your flutter project

    ```bash
    flutter run
    ```

4. If you want to run the app on a specific device (e.g., an Android emulator or a connected physical device), you can use:

    ```bash
    flutter run -d device_id
    ```

    Replace device_id with the identifier of your target device.

5. Build an APK: To build an APK for your Flutter app, use:

    ```bash
    flutter build apk
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ROADMAP -->
## Roadmap

This roadmap outlines the planned enhancements and features for the WiFi Attendance System. Contributions and feedback are welcomed to help make this project more robust and feature-rich.

#### Version 1.0.0 
- Basic functionality for teachers to create courses, start sessions, and mark attendance.
- Student registration, course enrollment, and attendance tracking.
- Admin functionalities to create and manage teacher accounts.

#### Version 1.1.0

- <b>Enhanced Security</b>:
    - Implement JWT-based authentication for improved security. <br>
    - Encrypt sensitive data stored in the database. 

- <b>User Interface Improvements</b>:
    - Enhance the Flutter app UI for a more intuitive user experience.
    - Add data visualization for attendance statistics.

- <b>Email Notifications</b>:
    - Send email notifications for account activities (e.g., password reset, session start).

#### Version 1.2.0

- <b>Advanced Attendance Analytic</b>:
    - Provide detailed analytics and insights into attendance patterns.<br>
    - Generate reports for teachers and administrators.

- <b>Integration with External Systems</b>:
    - Explore integrations with Learning Management Systems (LMS) or other educational platforms.

- <b>Additional User Roles</b>:
    - Add support for additional user roles (e.g., Teaching Assistant, Parent).

#### Version 2.0.0

- <b>Support for Multiple Sessions</b>:
    - Allow teachers to start multiple sessions for a course.

- <b>Machine Learning</b>:
    - Explore the use of machine learning to automate attendance tracking.

- <b>Biometric Authentication</b>:
    - Explore the use of biometric authentication for enhanced security and complete securing from proxying.

See the [open issues](https://github.com/Jasleen8801/proxy-api/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Abhinav Gupta - agupta20_be21@thapar.edu

Project Link: [https://github.com/Ab-Abby-19/proxy](https://github.com/Ab-Abby-19/proxy)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Backend API

To access the backend API, please visit [https://github.com/Jasleen8801/proxy-api](https://gihtub.com/Jasleen8801/proxy-api)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
[product-screenshot]: images/screenshot.png
[Node.js]: https://img.shields.io/badge/node.js-000000?style=for-the-badge&logo=nodedotjs&logoColor=white
[Node-url]: https://nodejs.org/en
[Mongo.js]: https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white
[Mongo-url]: https://www.mongodb.com/
[Express.js]: https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB
[Express-url]:  https://expressjs.com/
[Docker.js]: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
[Docker-url]: https://www.docker.com/
[Flutter.dev]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white
[Flutter-url]: https://flutter.dev/
[Dart.com]: https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[Dart-url]: https://dart.dev/
[Shell.com]: https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white
[Shell-url]: https://www.shellscript.sh/