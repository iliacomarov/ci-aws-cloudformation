# ci-aws-cloudformation

Setup automation builds on https://travis-ci.org

1. After registration this github repo in https://travis-ci.org make test push on github and in settings of the repo (Integrations & services -> Travis CI) push button "Test service".

2. Add vars needs for packet in https://travis-ci.org (select repo -> More options -> Settings). You should add a few vars:

> VAULT_ADDR (Display value in build log - Off)

> VAULT_TOKEN (Display value in build log - Off)

- template.json created for travis-ci and it works with parameters.json which generated from vars.sh
- template2.json created for manual creation stack through AWS web ui

