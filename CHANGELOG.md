# Changelog

## [5.2.0](https://github.com/seuros/capistrano-puma/tree/5.2.0) (2021-09-11)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.1.1...5.2.0)

**Merged pull requests:**

- Add option for phased restart of puma [\#333](https://github.com/seuros/capistrano-puma/pull/333) ([phylor](https://github.com/phylor))

## [v5.1.1](https://github.com/seuros/capistrano-puma/tree/v5.1.1) (2021-09-03)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.1.0...v5.1.1)

**Merged pull requests:**

- Reload also should support system mode. [\#331](https://github.com/seuros/capistrano-puma/pull/331) ([Eric-Guo](https://github.com/Eric-Guo))

## [v5.1.0](https://github.com/seuros/capistrano-puma/tree/v5.1.0) (2021-09-02)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.0.4...v5.1.0)

**Merged pull requests:**

- Phased restart [\#329](https://github.com/seuros/capistrano-puma/pull/329) ([mksvdmtr](https://github.com/mksvdmtr))
- fix typo in README.md [\#325](https://github.com/seuros/capistrano-puma/pull/325) ([Yuki-Inoue](https://github.com/Yuki-Inoue))
- Implement puma systemd sockets [\#324](https://github.com/seuros/capistrano-puma/pull/324) ([chriscz](https://github.com/chriscz))

## [v5.0.4](https://github.com/seuros/capistrano-puma/tree/v5.0.4) (2021-03-03)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.0.3...v5.0.4)

**Merged pull requests:**

- fix: puma\_systemctl\_user default value [\#319](https://github.com/seuros/capistrano-puma/pull/319) ([davegudge](https://github.com/davegudge))

## [v5.0.3](https://github.com/seuros/capistrano-puma/tree/v5.0.3) (2021-02-23)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.0.2...v5.0.3)

**Merged pull requests:**

- update systemd template accept puma\_service\_unit\_env\_file and puma\_se… [\#315](https://github.com/seuros/capistrano-puma/pull/315) ([iscreen](https://github.com/iscreen))
- Remove ExecStop from systemd unit file [\#314](https://github.com/seuros/capistrano-puma/pull/314) ([w-leads](https://github.com/w-leads))
- Default systemd service name on multi-app host [\#309](https://github.com/seuros/capistrano-puma/pull/309) ([bendilley](https://github.com/bendilley))
- Systemd user service manager and lingering [\#307](https://github.com/seuros/capistrano-puma/pull/307) ([farnsworth](https://github.com/farnsworth))
- Update nginx template to support X-Forwarded-Proto and remove executables from \*.erb files [\#283](https://github.com/seuros/capistrano-puma/pull/283) ([dapi](https://github.com/dapi))

## [v5.0.2](https://github.com/seuros/capistrano-puma/tree/v5.0.2) (2020-12-07)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.0.1...v5.0.2)

**Merged pull requests:**

- Single name for systemd config template [\#308](https://github.com/seuros/capistrano-puma/pull/308) ([bendilley](https://github.com/bendilley))

## [v5.0.1](https://github.com/seuros/capistrano-puma/tree/v5.0.1) (2020-12-02)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.0.0...v5.0.1)

**Merged pull requests:**

- Fix \#301, Task "puma:smart\_restart" not found [\#304](https://github.com/seuros/capistrano-puma/pull/304) ([Eric-Guo](https://github.com/Eric-Guo))

## [v5.0.0](https://github.com/seuros/capistrano-puma/tree/v5.0.0) (2020-12-01)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v5.0.0.beta1...v5.0.0)

## [v5.0.0.beta1](https://github.com/seuros/capistrano-puma/tree/v5.0.0.beta1) (2020-11-04)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v4.0.0...v5.0.0.beta1)

**Merged pull requests:**

- Add systemd support and puma 5 support [\#300](https://github.com/seuros/capistrano-puma/pull/300) ([ayamomiji](https://github.com/ayamomiji))
- Update nginx template [\#290](https://github.com/seuros/capistrano-puma/pull/290) ([neolyte](https://github.com/neolyte))
- Improve already running warning message [\#262](https://github.com/seuros/capistrano-puma/pull/262) ([jackbot](https://github.com/jackbot))

## [v4.0.0](https://github.com/seuros/capistrano-puma/tree/v4.0.0) (2019-06-27)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v3.1.1...v4.0.0)

**Merged pull requests:**

- Change 3.4 to 4.0 [\#285](https://github.com/seuros/capistrano-puma/pull/285) ([paulomcnally](https://github.com/paulomcnally))
- Revert "Fixed call parameter" [\#282](https://github.com/seuros/capistrano-puma/pull/282) ([stefanwild](https://github.com/stefanwild))
- Fixed call parameter [\#280](https://github.com/seuros/capistrano-puma/pull/280) ([stefanwild](https://github.com/stefanwild))
- Use HTTP 1.1 for proxying [\#277](https://github.com/seuros/capistrano-puma/pull/277) ([amiuhle](https://github.com/amiuhle))
- Update README.md [\#276](https://github.com/seuros/capistrano-puma/pull/276) ([poyzn](https://github.com/poyzn))
- fix typo in readme [\#275](https://github.com/seuros/capistrano-puma/pull/275) ([knt45](https://github.com/knt45))
- special case: setting X-Forwarded-Proto https even if ngnix is not using SSL [\#265](https://github.com/seuros/capistrano-puma/pull/265) ([anand-c-srinivasan](https://github.com/anand-c-srinivasan))
- \#243 Fix restart task, pumactl don't call bundle exec on restart [\#251](https://github.com/seuros/capistrano-puma/pull/251) ([pgericson](https://github.com/pgericson))
- Wrong path to puma config fixed [\#249](https://github.com/seuros/capistrano-puma/pull/249) ([atilla777](https://github.com/atilla777))
- Update README.md [\#247](https://github.com/seuros/capistrano-puma/pull/247) ([lozhn](https://github.com/lozhn))
- Added shared puma conf as argument to jungle:add [\#238](https://github.com/seuros/capistrano-puma/pull/238) ([anonoz](https://github.com/anonoz))

## [v3.1.1](https://github.com/seuros/capistrano-puma/tree/v3.1.1) (2017-07-04)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v3.1.0...v3.1.1)

**Merged pull requests:**

- Fix jungle setup for debian [\#235](https://github.com/seuros/capistrano-puma/pull/235) ([PavelBezpalov](https://github.com/PavelBezpalov))
- Force SSL/LTS with return directive [\#234](https://github.com/seuros/capistrano-puma/pull/234) ([notapatch](https://github.com/notapatch))
- Use `$host` to prevent forgery [\#232](https://github.com/seuros/capistrano-puma/pull/232) ([teeceepee](https://github.com/teeceepee))
- Fix undefined method 'as' on Capistrano::Puma and 'execute' should be wrapped in an 'on' block [\#230](https://github.com/seuros/capistrano-puma/pull/230) ([4xposed](https://github.com/4xposed))
- Wait for Monit to be reloaded [\#224](https://github.com/seuros/capistrano-puma/pull/224) ([ivanovaleksey](https://github.com/ivanovaleksey))
- Update README.md [\#223](https://github.com/seuros/capistrano-puma/pull/223) ([notapatch](https://github.com/notapatch))
- \[Fix \#219\] Call execute on backend [\#222](https://github.com/seuros/capistrano-puma/pull/222) ([ivanovaleksey](https://github.com/ivanovaleksey))
- Add option to specify the location of SSL certificates [\#221](https://github.com/seuros/capistrano-puma/pull/221) ([wynksaiddestroy](https://github.com/wynksaiddestroy))
- Fix the nginx\_conf can not upgrade to web sockets when using ActionCable [\#218](https://github.com/seuros/capistrano-puma/pull/218) ([Eric-Guo](https://github.com/Eric-Guo))
- Add stage to cap commands [\#216](https://github.com/seuros/capistrano-puma/pull/216) ([wynksaiddestroy](https://github.com/wynksaiddestroy))

## [v3.1.0](https://github.com/seuros/capistrano-puma/tree/v3.1.0) (2017-03-24)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v3.0.3...v3.1.0)

**Merged pull requests:**

- release 3.1.0 [\#212](https://github.com/seuros/capistrano-puma/pull/212) ([seuros](https://github.com/seuros))
- Minor fixes [\#211](https://github.com/seuros/capistrano-puma/pull/211) ([rojosinalma](https://github.com/rojosinalma))
- Fixes issue \#208 [\#209](https://github.com/seuros/capistrano-puma/pull/209) ([rojosinalma](https://github.com/rojosinalma))
- Give hint about appending variable values instead of setting them [\#207](https://github.com/seuros/capistrano-puma/pull/207) ([mcelicalderon](https://github.com/mcelicalderon))

## [v3.0.3](https://github.com/seuros/capistrano-puma/tree/v3.0.3) (2017-03-23)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v3.0.2...v3.0.3)

## [v3.0.2](https://github.com/seuros/capistrano-puma/tree/v3.0.2) (2017-03-22)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v3.0.1...v3.0.2)

**Merged pull requests:**

- Fix vars loading issue during plugin initialization [\#205](https://github.com/seuros/capistrano-puma/pull/205) ([ilyapoz](https://github.com/ilyapoz))

## [v3.0.1](https://github.com/seuros/capistrano-puma/tree/v3.0.1) (2017-03-20)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v3.0.0...v3.0.1)

## [v3.0.0](https://github.com/seuros/capistrano-puma/tree/v3.0.0) (2017-03-18)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v2.0.0...v3.0.0)

**Merged pull requests:**

- Release v3.0.0 candidate [\#201](https://github.com/seuros/capistrano-puma/pull/201) ([seuros](https://github.com/seuros))
- Add 'daemonize' config [\#194](https://github.com/seuros/capistrano-puma/pull/194) ([rhannequin](https://github.com/rhannequin))

## [v2.0.0](https://github.com/seuros/capistrano-puma/tree/v2.0.0) (2017-03-08)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v1.2.1...v2.0.0)

**Merged pull requests:**

- Skip puma start command if puma is running [\#198](https://github.com/seuros/capistrano-puma/pull/198) ([mizukmb](https://github.com/mizukmb))
- Fix puma:monit task for first deployment [\#187](https://github.com/seuros/capistrano-puma/pull/187) ([lucasalves](https://github.com/lucasalves))
- Update workers.rake [\#186](https://github.com/seuros/capistrano-puma/pull/186) ([treenewbee](https://github.com/treenewbee))
- typo [\#178](https://github.com/seuros/capistrano-puma/pull/178) ([BenjaminKim](https://github.com/BenjaminKim))
- Modify README file [\#176](https://github.com/seuros/capistrano-puma/pull/176) ([00dav00](https://github.com/00dav00))
- Remove trailing lines in ERB files [\#171](https://github.com/seuros/capistrano-puma/pull/171) ([papilip](https://github.com/papilip))
- Closing ActiveRecord connections before forking [\#170](https://github.com/seuros/capistrano-puma/pull/170) ([marcoschicote](https://github.com/marcoschicote))
- Add support to plugins [\#168](https://github.com/seuros/capistrano-puma/pull/168) ([seuros](https://github.com/seuros))
- Add server\_name to the http-\>https redirection server block [\#147](https://github.com/seuros/capistrano-puma/pull/147) ([bdewater](https://github.com/bdewater))
- Fix README: default value of puma\_preload\_app is false [\#145](https://github.com/seuros/capistrano-puma/pull/145) ([snoozer05](https://github.com/snoozer05))
- Respect the global puma\_user setting [\#139](https://github.com/seuros/capistrano-puma/pull/139) ([jhollinger](https://github.com/jhollinger))
- Add puma commands to chruby\_map\_bins. [\#135](https://github.com/seuros/capistrano-puma/pull/135) ([linjunpop](https://github.com/linjunpop))
- Run the shell as a login shell. [\#132](https://github.com/seuros/capistrano-puma/pull/132) ([kgiszczak](https://github.com/kgiszczak))
- Issue \#120 -- explicitly pass the config file location to pumactl [\#129](https://github.com/seuros/capistrano-puma/pull/129) ([lhagemann](https://github.com/lhagemann))
- Use SSHKit command\_map [\#128](https://github.com/seuros/capistrano-puma/pull/128) ([hbin](https://github.com/hbin))
- Update Readme [\#127](https://github.com/seuros/capistrano-puma/pull/127) ([h0lyalg0rithm](https://github.com/h0lyalg0rithm))

## [v1.2.1](https://github.com/seuros/capistrano-puma/tree/v1.2.1) (2015-08-20)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v1.2.0...v1.2.1)

**Merged pull requests:**

- Added fix for wrong arguments on puma stop [\#124](https://github.com/seuros/capistrano-puma/pull/124) ([rsov](https://github.com/rsov))

## [v1.2.0](https://github.com/seuros/capistrano-puma/tree/v1.2.0) (2015-08-19)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v1.1.0...v1.2.0)

**Implemented enhancements:**

- Adds ssl configuration for nginx [\#116](https://github.com/seuros/capistrano-puma/pull/116) ([mdesanti](https://github.com/mdesanti))

**Merged pull requests:**

- new puma user log [\#122](https://github.com/seuros/capistrano-puma/pull/122) ([seuros](https://github.com/seuros))
- Don't need establish connection block if `puma\_preload\_app' set to false [\#118](https://github.com/seuros/capistrano-puma/pull/118) ([hbin](https://github.com/hbin))
- Mcb/add support for puma user [\#117](https://github.com/seuros/capistrano-puma/pull/117) ([mcb](https://github.com/mcb))
- Fix puma\_monit\_bin [\#114](https://github.com/seuros/capistrano-puma/pull/114) ([msbrigna](https://github.com/msbrigna))
- Update monit tasks [\#113](https://github.com/seuros/capistrano-puma/pull/113) ([soylent](https://github.com/soylent))

## [v1.1.0](https://github.com/seuros/capistrano-puma/tree/v1.1.0) (2015-06-23)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v1.0.0...v1.1.0)

**Merged pull requests:**

- Always refresh Gemfile. Fixes \#109 [\#110](https://github.com/seuros/capistrano-puma/pull/110) ([sime](https://github.com/sime))
- Reload Monit after uploading any monit configuration [\#108](https://github.com/seuros/capistrano-puma/pull/108) ([suhailpatel](https://github.com/suhailpatel))
- Set :puma\_preload\_app to false [\#104](https://github.com/seuros/capistrano-puma/pull/104) ([rafaelgoulart](https://github.com/rafaelgoulart))

## [v1.0.0](https://github.com/seuros/capistrano-puma/tree/v1.0.0) (2015-05-05)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.9.0...v1.0.0)

**Merged pull requests:**

- Feature/add activate control app [\#103](https://github.com/seuros/capistrano-puma/pull/103) ([askagirl](https://github.com/askagirl))
- Missing 'r' in prune\_bundler [\#101](https://github.com/seuros/capistrano-puma/pull/101) ([sime](https://github.com/sime))

## [v0.9.0](https://github.com/seuros/capistrano-puma/tree/v0.9.0) (2015-03-20)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.8.5...v0.9.0)

**Merged pull requests:**

- Update Typo in README [\#97](https://github.com/seuros/capistrano-puma/pull/97) ([kcollignon](https://github.com/kcollignon))
- bundler prune should be automatically detect [\#96](https://github.com/seuros/capistrano-puma/pull/96) ([crhan](https://github.com/crhan))

## [v0.8.5](https://github.com/seuros/capistrano-puma/tree/v0.8.5) (2015-01-30)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.8.4...v0.8.5)

**Merged pull requests:**

- Fix smart\_restart task to check if puma preloads app [\#93](https://github.com/seuros/capistrano-puma/pull/93) ([sponomarev](https://github.com/sponomarev))

## [v0.8.4](https://github.com/seuros/capistrano-puma/tree/v0.8.4) (2015-01-25)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.8.3...v0.8.4)

**Merged pull requests:**

- Allow PATCH method [\#91](https://github.com/seuros/capistrano-puma/pull/91) ([lonre](https://github.com/lonre))
- Allow unix:/foo/ socket URLs [\#90](https://github.com/seuros/capistrano-puma/pull/90) ([indirect](https://github.com/indirect))
- Fix puma:monit task descriptions [\#88](https://github.com/seuros/capistrano-puma/pull/88) ([jc00ke](https://github.com/jc00ke))
- Convert to spaces [\#85](https://github.com/seuros/capistrano-puma/pull/85) ([lonre](https://github.com/lonre))
- Minor documentation correction [\#84](https://github.com/seuros/capistrano-puma/pull/84) ([neilbartley](https://github.com/neilbartley))
- appending :stage to puma's monit [\#81](https://github.com/seuros/capistrano-puma/pull/81) ([itsNikolay](https://github.com/itsNikolay))

## [v0.8.3](https://github.com/seuros/capistrano-puma/tree/v0.8.3) (2014-10-28)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.8.2...v0.8.3)

## [v0.8.2](https://github.com/seuros/capistrano-puma/tree/v0.8.2) (2014-10-17)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.8.1...v0.8.2)

**Merged pull requests:**

- Start task creates a conf file if none exists. [\#74](https://github.com/seuros/capistrano-puma/pull/74) ([stevemadere](https://github.com/stevemadere))

## [v0.8.1](https://github.com/seuros/capistrano-puma/tree/v0.8.1) (2014-10-08)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.8.0...v0.8.1)

**Merged pull requests:**

- Fix nginx config task work with roles [\#72](https://github.com/seuros/capistrano-puma/pull/72) ([hnatt](https://github.com/hnatt))
- Fix puma\_bind unix socket path [\#70](https://github.com/seuros/capistrano-puma/pull/70) ([hnatt](https://github.com/hnatt))
- Update nginx\_config task call example in README [\#69](https://github.com/seuros/capistrano-puma/pull/69) ([hnatt](https://github.com/hnatt))
- Added config option for prune\_bundler [\#68](https://github.com/seuros/capistrano-puma/pull/68) ([behe](https://github.com/behe))

## [v0.8.0](https://github.com/seuros/capistrano-puma/tree/v0.8.0) (2014-09-23)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.7.0...v0.8.0)

**Merged pull requests:**

- Update puma.cap to add missing , [\#65](https://github.com/seuros/capistrano-puma/pull/65) ([bryanl](https://github.com/bryanl))
- Fixed handling of multiple puma endpoints and of wildcard IP addresses [\#64](https://github.com/seuros/capistrano-puma/pull/64) ([jabbrwcky](https://github.com/jabbrwcky))
- Cannot call nginx:config cap task [\#61](https://github.com/seuros/capistrano-puma/pull/61) ([isc](https://github.com/isc))

## [v0.7.0](https://github.com/seuros/capistrano-puma/tree/v0.7.0) (2014-08-07)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.6.1...v0.7.0)

**Merged pull requests:**

- Add a task for uploading nginx site config and a generator for configuring template before uploadinging [\#57](https://github.com/seuros/capistrano-puma/pull/57) ([dfang](https://github.com/dfang))

## [v0.6.1](https://github.com/seuros/capistrano-puma/tree/v0.6.1) (2014-07-03)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/v0.2.0...v0.6.1)

**Merged pull requests:**

- Explicitly daemonize when needed. [\#54](https://github.com/seuros/capistrano-puma/pull/54) ([crohr](https://github.com/crohr))
- Access and Error logs where backwards [\#52](https://github.com/seuros/capistrano-puma/pull/52) ([rottmanj](https://github.com/rottmanj))
- Fix jungle tasks [\#47](https://github.com/seuros/capistrano-puma/pull/47) ([RavWar](https://github.com/RavWar))
- Make monit play well with chruby. [\#46](https://github.com/seuros/capistrano-puma/pull/46) ([linjunpop](https://github.com/linjunpop))
- fix and beautify puma-deb, closes \#44 [\#45](https://github.com/seuros/capistrano-puma/pull/45) ([masterkain](https://github.com/masterkain))
- puma jungle start stop restart fix [\#38](https://github.com/seuros/capistrano-puma/pull/38) ([petertoth](https://github.com/petertoth))
- check redhat-release first [\#34](https://github.com/seuros/capistrano-puma/pull/34) ([marshall-lee](https://github.com/marshall-lee))
- set rack\_env before command execution [\#29](https://github.com/seuros/capistrano-puma/pull/29) ([arielze](https://github.com/arielze))

## [v0.2.0](https://github.com/seuros/capistrano-puma/tree/v0.2.0) (2014-01-28)

[Full Changelog](https://github.com/seuros/capistrano-puma/compare/4068552029ae7f40963afaa6d45d2877c7806d8d...v0.2.0)

**Merged pull requests:**

- add a trigger to puma config, for support Issue \#25 [\#26](https://github.com/seuros/capistrano-puma/pull/26) ([crhan](https://github.com/crhan))
- bump version for support capistrano v3.1 [\#24](https://github.com/seuros/capistrano-puma/pull/24) ([crhan](https://github.com/crhan))
- capistrano v3.1 compatible improve: dependency solve [\#22](https://github.com/seuros/capistrano-puma/pull/22) ([crhan](https://github.com/crhan))
- phased-restart also check for pid file first [\#21](https://github.com/seuros/capistrano-puma/pull/21) ([crhan](https://github.com/crhan))
- check pid instead of state file [\#20](https://github.com/seuros/capistrano-puma/pull/20) ([crhan](https://github.com/crhan))
- fix puma/puma\#300: Gemfile not refreshed between deploys [\#19](https://github.com/seuros/capistrano-puma/pull/19) ([crhan](https://github.com/crhan))
- Update README.md [\#17](https://github.com/seuros/capistrano-puma/pull/17) ([James-Hendrickson](https://github.com/James-Hendrickson))
- Sane defaults and puma:check [\#15](https://github.com/seuros/capistrano-puma/pull/15) ([shaneog](https://github.com/shaneog))
- run puma and pumactl with bundler [\#14](https://github.com/seuros/capistrano-puma/pull/14) ([ayamomiji](https://github.com/ayamomiji))
- Ensures that it will bundle w/ capistrano 3.1 [\#6](https://github.com/seuros/capistrano-puma/pull/6) ([kyledecot](https://github.com/kyledecot))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
