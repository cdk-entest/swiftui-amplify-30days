---
author: haimtran
title: Food Truck
description: learn how to build the food truck app
publsihedDate: 15/11/2022
date: 15/11/2022
---

## Introduction

- NavitationStack
- Form, Section, LabeledContent, Toolbaritem
- AccentColor


<img width="263" alt="Screen Shot 2022-11-17 at 09 47 25" src="https://user-images.githubusercontent.com/20411077/202344144-3d44f244-1611-4e72-b23c-70190202d791.png">


## Form, Section and LabeledContent

```swift
 Form {
    Section {
        LabeledContent("User name") {
            TextField("User name", text: $username)
                .textContentType(.username)
                .multilineTextAlignment(.trailing)
        }

        if !usePassKey {
            LabeledContent("Password") {
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .multilineTextAlignment(.trailing)
                    .focused($focusedElement, equals: .password)
                    .labelsHidden()
            }
        }

        LabeledContent("User Passkey"){
            Toggle("Use Passkey", isOn: $usePassKey)
                .labelsHidden()
        }

    } header: {
        Text("Create an account")
    } footer: {
        Label("""
            When you sign up with a passkey, all you need is a user name. \
            The passkey will be available on all of your devices.
            """, systemImage: "person.badge.key.fill")
    }
}
```

## ToolbarItem

```swift
Form {
  Section {
    ...
  }
}
.formStyle(.grouped)
        .animation(.default, value: usePassKey)
        .frame(maxWidth: 500)
        .navigationTitle("Sign Up")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Sign Up") {
                }
                .disabled(!isFormValid)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {

                }
            }
        }
        .onAppear {focusedElement = .username}
```

## Navigation Stack

```swift
struct SignUpView_Previews: PreviewProvider {

    struct Preview: View {
        var body: some View {
            FoodSignUpView()
        }
    }

    static var previews: some View {
        NavigationStack {
            Preview()
        }
    }
}
```
