---
title: Swiftui Auth Flow
description: build an auth flow with swiftui and amplify
author: haimtran
publishedDate: 11/13/2022
date: 2022-11-13
---

## Introduction

[Github]() shows how to build an auth flow using Amplify

- SwiftUI and TextField
- SignUp and Confirm
- GetCurrentUser and SignIn

## TextField

there are many ways to create a sign in form using the swiftui textfield

```swift
HStack {
    Image(systemName: "person")
    TextField("username", text: $username)
        .textInputAutocapitalization(.never)
        .textContentType(.emailAddress)
}
.padding()
.background(Color.gray.opacity(0.3).cornerRadius(10))
.padding(.horizontal)
```

and button style

```swift
Button("Log In") {
    Task {
        await self.authManager.signIn(username: username, password: password)
    }
}
.padding()
.frame(maxWidth: .infinity)
.background(Color.purple.cornerRadius(10))
.foregroundColor(Color.white)
.fontWeight(.bold)
.padding(.horizontal)
```

## Auth Flow and Views

create authstate enum

```swift
enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}
```

present different views depending on AuthState

```swift
@main
struct SwiftUI30DaysApp: App {
    @ObservedObject var authManager = AuthManager()

    init() {
        configureAmplify()
    }

    var body: some Scene {
        WindowGroup {

            switch authManager.authState {
            case .login:
                Day6LoginView()
                    .environmentObject(authManager)
            case .signUp:
                Day6SignUpView()
                    .environmentObject(authManager)
            case .session(let user):
                Day6SessionView(user: user)
                    .environmentObject(authManager)
            case .confirmCode(username: let username):
                Day6ConfirmView()
                    .environmentObject(authManager)
            }
        }
    }

    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch {
            print("Amplify configure error \(error)")
        }
    }
}

```

## SignUp a New Account

using email to register a new account

```swift
func signUp(username: String, password: String, email: String) async {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
                Task {@MainActor in
                    self.authState = .confirmCode(username: username)
                }
            } else {
                print("SignUp Complete")
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
```

## Confirm Code

receive the confirm code via email then need to fill in a confirm form

```swift
    func confirmSignUp(for username: String, with confirmationCode: String) async {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")

            Task {@MainActor in
                self.authState = .login
            }

        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
```

## Sign In an Existing Account

```swift
func signIn(username: String, password: String) async {
        print("amplify login \(username) and \(password)")

        do {
            let signInResult = try await Amplify.Auth.signIn(username: username, password: password)

            if signInResult.isSignedIn {
                print("signed in successfully")
                await getCurrentAuthUser()
            }
            else {
                print("wrong pass")
            }
        } catch {
            print("amplify sign in error \(error)")
        }
    }
```

## Sign Out an Account

```swift
 func signout() async {
        let result = await Amplify.Auth.signOut()
        Task {@MainActor in
            self.authState = .login
        }
    }
```
