run `linear issue view` to see the requirements

run `git diff main.. -- . ":(exclude)**/__generated__/**"` to see the changes on this branch

re-print the requirements with character indicators similar to rust errors or ariadne to highlight what parts of the requirements are met or unmet,


```md
# Employee | Request Replacement

## Feature Story:

As an employee, I want to be able to request a replacement for a job that I accepted

## Build Notes:

* I should only see the option to "Request Replacement" if it is in the "Accepted" state AND > 24 hours from the start time
  * Pop open a modal to enter in a reason (free text)
* Placement should be updated to the "Replacement Requested" status
  * Placements in "Replacement Requested" should not take up a slot -> should be released to all eligible employees
* Exclude from:
  * Dashboard
  * Being able to clock in
  * Push notifications
```
