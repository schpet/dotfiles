review the changed code between this branch and main with `git diff main..`

add a changelog entry with the `changelog` cli

    changelog add --type <TYPE> <DESCRIPTION>

note that:

- description should be lowercase
- types is one of added|changed|deprecated|removed|fixed|security
- write in the imperative (i.e. 'fix' and not 'fixes' or 'fixed')
