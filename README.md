# Sign in with Phone Flutter App Demo

Welcome to the Flutter demo repository for integrating "Sign in with Phone" functionality into your mobile applications. This repository showcases how you can seamlessly implement phone verification and authentication using our innovative plugin.

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Example Demo](#example-demo)
5. [Documentation](#documentation)
6. [Website](#website)

## Introduction

Phone Email presents a revolutionary solution for user authentication - "Sign in with Phone". Our plugin enables mobile apps & websites to offer seamless phone number verification to users, enhancing security and user experience. Similar to Firebase phone authentication, our solution embeds a "Log in with phone" button on client websites. Upon clicking, a verification window prompts users to enter their country code and mobile number. After successful verification through OTP sent to the user's mobile, control redirects back to the client website with an access token. Subsequently, passing this access token to the getuser REST API retrieves the verified mobile number.

### Key Benefits:

- **Cost-Effective:** Minimal or no cost for phone verification.
- **Enhanced Security:** OTP-based verification ensures secure authentication.
- **Seamless Integration:** Easy integration into existing web applications.
- **Improved User Experience:** Streamlined authentication process for users.

## Installation

To integrate the "Sign in with Phone" functionality into your Next.js project, follow these steps:

1. **Clone the repository:**

    ```bash
    git clone https://github.com/phoneemail/sign-in-with-phone-flutter-app.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd sign-in-with-phone-flutter-app
    ```

3. **Install dependencies:**

    ```bash
    dependencies:
    phone_email_auth: ^0.0.3
   
    //Run following command to sync dependencies
    flutter pub get
    ```

4. **Initialization:**

    ```dart
    PhoneEmail.initializeApp(clientId: 'YOUR_CLIENT_ID',);
    ```

    ## Note:
    clientId : Set clientId which you obtained from Profile Details section of [Admin Dashboard](https://admin.phone.email/) of Phone Email.

5. Add Phone Email Login Button

   ```dart        
    child: PhoneLoginButton(
    borderRadius: 8,
    buttonColor: Colors.teal,
    label: 'Sign in with Phone',
    onSuccess: (String accessToken, String jwtToken) {
        if (accessToken.isNotEmpty) {
        setState(() {
            userAccessToken = accessToken;
            jwtUserToken = jwtToken;
            hasUserLogin = true;
        });
        }
    },
    )
    ```

   The PhoneLoginButton will return the `accessToken` and `jwtToken`, which are necessary for obtaining the verified phone number.

6. Get Verified phone number:

   Once you've obtained the `accessToken`, get verified phone number by calling the `getUserInfo()` function. Use the following code snippet to retrieve the verified phone number.

   ```dart
    PhoneEmail.getUserInfo(
    accessToken: userAccessToken,
    clientId: phoneEmail.clientId,
    onSuccess: (userData) {
        setState(() {
        phoneEmailUserModel = userData;
        var countryCode = phoneEmailUserModel?.countryCode;
        var phoneNumber = phoneEmailUserModel?.phoneNumber;

        // Use this verified phone number to register user and create your session

        });
    },
    );
   ```

7. Display Email Alert:

   Integrate an email alert icon on your screen for a successfully authenticated user. Use the following code snippet to fetch the unread email count and display the email icon.

    ```dart
    floatingActionButton: hasUserLogin
        ? EmailAlertButton(
        jwtToken: jwtUserToken,
        ) : const Offstage(),
    );
    ```
   
## Usage

To utilize the application:

1. **Start the application:**

   Run the app on emulator/mobile to test.


## Example Demo

Experience the seamless authentication process firsthand with our [demo](https://www.phone.email/demo-login). Our demo provides a live demonstration of the "Sign in with Phone" plugin, showcasing its functionality and ease of use. Explore the demo to understand how the plugin can enhance the authentication experience on your website.

## Documentation

For comprehensive documentation on integrating the "Sign in with Phone" plugin into your flutter web application, refer to our [documentation](https://www.phone.email/docs#flutter). The documentation provides detailed instructions, code samples, and configuration options to help you seamlessly integrate the plugin into your project.

## Website

Visit our [website](https://www.phone.email) to learn more about our authentication solutions and explore additional features and services. Experience the future of authentication with Phone Email's "Sign in with Phone" plugin.
By implementing our plugin, you can elevate the security of your website, enhance user experience, and streamline the authentication process for your users. Embrace the power of phone verification with Phone Email's innovative solution.

---
Developed by [Phone Email](https://www.phone.email)

![App Logo](https://www.phone.email/assets/imgs/page/homepage/logo.svg)
