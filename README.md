## Animals MVC Code Sample

- Code sample using my own MVC setup
- Built using ColdFusion, Bootstrap v4.1.2, jQuery v3.3.1, MySQL 5, and Font Awesome 5.1.0

## Code and Demo

- Code is available on my GitHub at https://github.com/bobbyoliver/animalsdemo
- A live working demo can be viewed at http://animals.bobbyoliver.com

## Additional Info

- This is a simple CRUD app for the user to add/edit/delete animals. It consists of a few grids, add/edit forms, and view pages for single animal records.
- It is built on my own MVC setup. Links are formatted as /index.cfm?controller=animals&action=addanimal, additional URL variables can be added when needed.
- Uses a mix of ORM and queries. ORM is used for all single model/record operations, while queries are used for the grids.
- Forms are validated by calling the same component functions for both client side AJAX validation and server side validation. Most fields do not need to be validated via AJAX, but it's convenient to write the validation functions once for both client and server side.
- There is debug info at the bottom of every page which dump some of the CF scopes.
- The initial DB animal records can be reloaded any time with ORM by clicking "Reload App & DB" (top right of debug).
- There are two controllers: "main" and "animals.

## Installation and Testing

- Install by setting up a new site in your web server environment, create an empty MySQL DB named "animals", and create a CF Admin datasource to that DB named "animals". Then go to the homepage, scroll down to the debug info, and click "Reload App & DB" (top right of debug). This will use ORM to create the needed tables and insert the initial records.
- If you wish to install it on a DB other than MySQL 5 a couple code changes would be needed. Open up Application.cfc and change "THIS.ORMSettings.Dialect" from "MySQL5" to the dialect of your DB. It might be OK to just delete "THIS.ORMSettings.Dialect" and it should work, but that has not been tested. The queries in the dal gateway files would need edited as well since they use a few MySQL specific functions to limit the number of records returned for grids.
- This code sample has been tested on Lucee 5.2.6.60. It should run fine on ACF 9+, but has not been tested on any versions of ACF.