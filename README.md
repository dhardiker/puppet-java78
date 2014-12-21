# java78

[![Build Status](https://travis-ci.org/Spantree/puppet-java78.svg?branch=master)](https://travis-ci.org/Spantree/puppet-java78)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with java78](#setup)
    * [What java78 affects](#what-java78-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with java78](#beginning-with-java78)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The module java78 installs the oracle java7 and java8 jdk on Ubuntu or Debian based system.

## Module Description

This module adds a apt repository and then proceeds to install oracle jdk7 and jdk8

##### NOTE: This module may only be used if you agree to the Oracle license: http://www.oracle.com/technetwork/java/javase/terms/license/

## Setup

### What java78 affects

* Install oracle jdk using the 'https://launchpad.net/~webupd8team/+archive/ubuntu/java' deb package
* Sets up a system wide `JAVA_HOME`

### Setup Requirements

None at the moment.

### Beginning with java78

`include java78` is enough to get you up and running.

##Usage

All interaction with the java78 module can be done through the main java78 class.

###I just want Oracle java 7 & java 8 jdk, what's the minimum I need?
```puppet
include java78
```

##Reference

###Classes

####Public Classes

* java78: Main class

###Parameters

###Facts

##Limitations

This module has been built on and tested against Puppet 3.2 and higher.

The module has been tested on:

* Ubuntu 12.04
* Ubuntu 14.04

Testing on other platforms has been light and cannot be guaranteed.

## Development

## Release Notes/Contributors/Etc
