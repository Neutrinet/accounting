# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## TODO

v unique login/password to access everything
v list transactions by year
v public accounting page by year
v add new movement
v do something with the nav header on the public page
- do a print CSS for pdf reporting
v add a "label" field for movements, and a new "custom" movement_type. the "label" will be displayed when the "custom" type is chosen
- upload CSV
  - upload form
  - create a "upload" db entry and fire up a bg job
  - display "import en cours" on the list transaction page
  - allow to filter by "unknown"
  - allow to edit transactions
  - make a difference between transactions created manually or by the import (a field in the DB)
  - generate reports for past years
- add specs for movement scopes
- fix failing spec on csv parsing
- documentation:
  - how to add new type
  - setup dev env
  - deploy to production
  - run tests
