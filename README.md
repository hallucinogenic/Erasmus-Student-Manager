# Erasmus Student Manager
A bash script with the purpose to manage students that are from Erasmus.
It will save all stored data in files, with the following format:

* University: saved in the main folder of the application;
* Students/Professors/Classes are saved in a folder with the University's Initials;

# Functionalities

## Register/Changing/Removing/Listing Universities

* Universities;
* Responsible Professors;
* Erasmus Students;
* Classes;
* Classes that students have when are in Erasmus;

## Backup Feature

* Saving all the current data to a compressed ***BZ2*** file, in a backup folder;
* Remove a certain backup that are stored in the backup folder;
* Restore a previous backup, to ovewrite the old data;

You can simply save a backup of all data that are saved in that specific time.

This was made to the ***Operative System*** Class at **Universidade da Beira Interior, Covilhã, Portugal** at a group of 3 people;

# Changelog

* **1.0** - Release;
* **1.1**:
    * Added an option to Change all the data from a certain Professor;
    * Fixed a bug when it didn't check if the Student's Country is the same as the University's Country;
    * Added an option to Restore a certain backup, which will overwrite the current data;
    * Fixed some comments (in the future, will be in English);
* **1.2**:
    * If you don't have the backup folder, it will create instantly;
    * Now it deletes the backup folder if it removes the last saved backup;
