# Changelog
All notable changes to NEOSDiscovery project will be documented in this file. Discovery is the NEOS Consortium's catalogue interface, built using Blacklight: http://projectblacklight.org/. https://catalogue.neoslibraries.ca.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and releases in NEOSDiscovery project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.77] - 2022-10-28

- bump depenendencies

## [1.0.76] - 2022-09-12

- update README.md testing: add search history 
- bump dependencies

## [1.0.75] - 2022-07-21
### Fixed 
- Address regression from the Rails 5.2.8.1 upgrade impacting storage of ActiveSupport::HashWithIndifferentAccess yaml serializations (that impacts the Search model in Blacklight) 

## [1.0.74] - 2022-07-13

### Security
- Bump rails from 5.2.8 to 5.2.8.1

## [1.0.73] - 2022-05-04

### Security
- bump Rails to 5.2.7.1 to address CVEs 

### Changed
- update README.md documentation
- Red Deer Polytechnic image

### Removed
- Disable suggest [#562](https://github.com/ualbertalib/NEOSDiscovery/issues/562)

## [1.0.72] - 2022-02-01

### Changed
- dependency bumps for maintenance
### Fixed
- faraday configuration error

## [1.0.71] - 2022-01-04

### Changed
- dependency bumps for maintenance

### Security
- address brakeman warnings [di_internal#61](https://github.com/ualbertalib/di_internal/issues/61#issuecomment-494452697)

## [1.0.70] - 2021-08-25

### Fixed
- Maintain branding across advanced search (and all actions) [OTRS#61391](https://helpdesk.library.ualberta.ca/otrs/index.pl?Action=AgentTicketZoom;TicketID=61391)

## [1.0.69] - 2021-05-05

### Security
- bump Rails to 5.2.6 to address CVEs 

## [1.0.68] - 2021-04-06

### Changed
- silence blacklight deprecation warnings [#135](https://github.com/ualbertalib/NEOSDiscovery/issues/135)

## [1.0.67] - 2021-04-06

### Changed
- dependency bumps for maintenance

## [1.0.66] - 2021-01-13

### Changed
- revert solr url configuration change 

### Added
- staging Rails environment

## [1.0.65] - 2021-01-05

### Changed
- make solr configuration more configurable and similar to Discovery
- dependency bumps for maintenance

## [1.0.64] - 2020-11-05

### Fixed
- changed colors in uofa logo.

## [1.0.63] - 2020-09-21

### Changed
- Removed feedback link as it is not monitored (requested by Scott through email)
- Updated Grand Praire and UofA Library logos
- log level from debug to warn [PR#412](https://github.com/ualbertalib/NEOSDiscovery/pull/412)

## [1.0.62] - 2020-07-20

### Fixed
- journal internet access links [#393](https://github.com/ualbertalib/NEOSDiscovery/issues/393)

## [1.0.61] - 2020-06-17

### Security
- Resolved brakeman warning [PR#384](https://github.com/ualbertalib/NEOSDiscovery/pull/384)
- Bumps rack from 2.2.2 to 2.2.3. [PR#390](https://github.com/ualbertalib/NEOSDiscovery/pull/390)

### Fixed
- safe navigation operator for potential nil location_tesim [PR#383](https://github.com/ualbertalib/NEOSDiscovery/pull/383)

## [1.0.60] - 2020-05-28

### Security 
- Bump kaminari from 1.2.0 to 1.2.1 [PR#382](https://github.com/ualbertalib/NEOSDiscovery/pull/382)

## [1.0.59] - 2020-05-21

### Changed
- pin version of VCR until we can determine if we can except an ethical license [PR#334](https://github.com/ualbertalib/NEOSDiscovery/pull/334)
- create migration and models to replace status, library and locations data from static config files and refactor to replace related constants [#320](https://github.com/ualbertalib/NEOSDiscovery/issues/320)

### Fixed
-  "The Economist" rollbar error, short_code normalization, and an undeclared e [PR#375](https://github.com/ualbertalib/NEOSDiscovery/pull/375)

## [1.0.58] - 2020-02-25

### Security
- Bumps nokogiri from 1.10.7 to 1.10.8 [PR#337](https://github.com/ualbertalib/NEOSDiscovery/pull/337)

### Added
- add regression tests [PR#330](https://github.com/ualbertalib/NEOSDiscovery/pull/330)
- add initialization for rollbar proxy [#271](https://github.com/ualbertalib/NEOSDiscovery/issues/271)
- Add version file and meta generator tag 

### Changed
- change what appears in the open search description [#258](https://github.com/ualbertalib/NEOSDiscovery/issues/258)
- refactor holdings table logic into a helper [#320](https://github.com/ualbertalib/NEOSDiscovery/issues/320)

## [1.0.56 / 1.0.57] - 2020-01-21

### Fixed
- returned aginternet to the locations file [PR#316](https://github.com/ualbertalib/NEOSDiscovery/pull/316)

## [1.0.55] - 2019-11-26
### Security
- Bumps nokogiri from 1.10.3 to 1.10.4 [PR#295](https://github.com/ualbertalib/NEOSDiscovery/pull/295)
- Bumps nokogiri from 1.10.4 to 1.10.5 [PR#312](https://github.com/ualbertalib/NEOSDiscovery/pull/312)

### Changed
- Updated statuses and locations based on emailed symphony policy file [PR#314](https://github.com/ualbertalib/NEOSDiscovery/pull/314)

### Added
- Added missing pop-up and artists statuses [#257](https://github.com/ualbertalib/NEOSDiscovery/issues/257)
- Added javascript to ensure the cursor goes to the main search box [#197](https://github.com/ualbertalib/NEOSDiscovery/issues/197)
- Added missing Concordia Internet Library location [#304](https://github.com/ualbertalib/NEOSDiscovery/issues/304)

## [1.0.54] - 2019-07-19

### Added
- Added missing statuses [PR#290](https://github.com/ualbertalib/NEOSDiscovery/pull/290)

### Fixed
- Fixed broken link in locations.yml for concordia lutheran seminary [#286](https://github.com/ualbertalib/NEOSDiscovery/issues/286)
- Fix for no links for electronic resources for King's [#285](https://github.com/ualbertalib/NEOSDiscovery/issues/285)

## [1.0.53] - 2019-07-09

## Changed
- removed link from Series title on catalog show page [#274](https://github.com/ualbertalib/NEOSDiscovery/issues/274)

## [1.0.52] - 2019-4-26

### Security
- Bumps nokogiri from 1.10.2 to 1.10.3. [PR#265](https://github.com/ualbertalib/NEOSDiscovery/pull/265)

### Changed
- Northern Lakes College Library url [#263](https://github.com/ualbertalib/NEOSDiscovery/issues/263)

### Removed
-  Subtitles from display [PR#1510](https://github.com/ualbertalib/discovery/pull/1510)

## [1.0.51] - 2019-03-14
### Security
- Bump rails from 4.2.11 to 4.2.11.1. This update addresses [Two Vulnerabilities in Action View](https://weblog.rubyonrails.org/2019/3/13/Rails-4-2-5-1-5-1-6-2-have-been-released/). [PR#251](https://github.com/ualbertalib/NEOSDiscovery/pull/251)

## [1.0.50] - 2019-02-07
### Added
-  Added our own custom error pages for 404/500 [#200](https://github.com/ualbertalib/NEOSDiscovery/issues/200)
-  Link to Course Reserves page [#40](https://github.com/ualbertalib/NEOSDiscovery/issues/40)

## [1.0.49] - 2018-12-19
### Added 
- Text to caution user about use of provided citations [#186](https://github.com/ualbertalib/NEOSDiscovery/issues/186)
- Github issue templates [PR#206](https://github.com/ualbertalib/NEOSDiscovery/pull/206)

### Changed
- Locations, status and libraries data updated [#173](https://github.com/ualbertalib/NEOSDiscovery/issues/173)

### Removed
- Removed beta labeling on NEOSDiscovery [#223](https://github.com/ualbertalib/NEOSDiscovery/issues/223)
- Unused gems [PR#212](https://github.com/ualbertalib/NEOSDiscovery/pull/212)

### Security
- Bump Rack from 2.0.5 to 2.0.6 [PR#209](https://github.com/ualbertalib/NEOSDiscovery/pull/209)
- Bump Loofah from 2.2.2 to 2.2.3 [PR#203](https://github.com/ualbertalib/NEOSDiscovery/pull/203)
- Bump rails from 5.2.1 to 5.2.2 [PR#220](https://github.com/ualbertalib/NEOSDiscovery/pull/220)

## [1.0.48] - 2018-10-17
### Fixed
- Style issues with the popup/modal windows [#195](https://github.com/ualbertalib/NEOSDiscovery/issues/195)

## [1.0.47] - 2018-10-12
### Fixed
- Persist library branding accross user session [#107](https://github.com/ualbertalib/NEOSDiscovery/issues/107)
- Text me this Item (changed configuration) [#132](https://github.com/ualbertalib/NEOSDiscovery/issues/132)
- Correction Form [#154](https://github.com/ualbertalib/NEOSDiscovery/issues/154)

## [1.0.46] - 2018-10-09
### Added
- Rollbar to resolve production errors in minutes (requires new secret) [#155](https://github.com/ualbertalib/discovery/issues/1287)

### Changed
- Fix incorrect libraries listed under 'copies owned' [#152](https://github.com/ualbertalib/NEOSDiscovery/issues/152)
