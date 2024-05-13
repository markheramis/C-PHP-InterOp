# C-PHP-InterOp-Exploration

This project explores the interoperability between C++ and PHP using the PHP-CPP library. The PHP-CPP library allows for developing PHP extensions using C++.

## Requirements

- Ubuntu Operating System
- PHP development headers
- [PHP-CPP](https://www.php-cpp.com) library
- g++ compiler

## Installation

1. **Install PHP development headers** You can install the PHP development headers by running the following command in your terminal:
```bash
sudo apt-get install php-dev
```
2. **Install g++ compiler** You can install the g++ compiler by running the following command in your terminal:
```bash
sudo apt-get install g++
```
3. **Clone this repository** You can clone this repository by running the following command in your terminal:
```bash
git clone <repository-url>
```

## Building the Extension

1. **Navigate to the project directory** You can navigate to the project directory by running the following command in your terminal:
```bash
cd C-PHP-InterOp-Exploration
```
2. **Build the extension** You can build the extension by running the following command in your terminal:
```bash
make
```
3. **Install the extension** You can install the extension by running the following command in your terminal:
```bash
sudo make install
```
4. **Restart your web server** Don’t forget to restart your web server to apply the changes.
## Building with Docker

If you have Docker installed, you can use Docker to build the extension. This can be useful if you don’t want to install the necessary packages on your local machine.

1. **Build the Docker image** You can build the Docker image by running the following command in your terminal:
```bash
docker build -t yourextension .
```
2. **Run the Docker image** You can run the Docker image by running the following command in your terminal:
```bash
docker run -it yourextension
```

3. **Trying out the script** by executing the `PHP/functionnoparameters.php` script and see the results
```bash
cd PHP
php -f functionnoparameters.php
```
## Usage

After installing the extension, you can use it in your PHP scripts like any other PHP extension.

## Contributing

Contributions are welcome. Please feel free to submit a pull request.
