# Codemagic API

A Flutter app for running builds using Codemagic API

<p align="center">
  <img src="https://github.com/sbis04/codemagic_api/raw/master/screenshots/codemagic_app.png" alt="Codemagic API" />
</p>

## Features

* **Start Build** with supplied software versions
* Get **Build Status** while it is running
* **Cancel Build** that is running on Codemagic CI/CD

> Codemagic API Docs: https://docs.codemagic.io/rest-api/overview

## Usage

1. Clone the repo
   ```bash
   git clone https://github.com/sbis04/codemagic_api.git
   ```

2. Open the project using your favorite IDE. For opening with VS Code:
   ```bash
   code codemagic_api
   ```

3. Go to the **lib** -> **api_details.dart** file

4. The app uses `initialValue` list for quick testing during development. You can either assign all the values to empty String (if you don't want to use it), or if you want to use it you can just replace the angle bracket `<Enter Your Codemagic Token Here>` with your **Codemagic API token**.
   
   You can get the access token from the Codemagic UI by going to **User Settings** -> **Integrations** -> **Codemagic API** -> **Show**.

5. Run the app on your device using the command
   ```bash
   flutter run
   ```

## License

Copyright (c) 2020 Souvik Biswas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
