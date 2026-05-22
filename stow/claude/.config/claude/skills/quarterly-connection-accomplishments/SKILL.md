---
name: quarterly-connection-accomplishments
description: Gather last quarter's Jira tickets and GitHub PRs, then write a short prose reflection on the most impactful accomplishments - suitable for a quarterly connection or performance review.
allowed-tools: Bash
---

## Determine last quarter's date range

Today's date is available in the system context. Calculate the previous quarter's start and end dates:
- Q1: Jan 1 - Mar 31
- Q2: Apr 1 - Jun 30
- Q3: Jul 1 - Sep 30
- Q4: Oct 1 - Dec 31

## Gather Jira tickets

Search for completed tickets assigned to the current user in the last quarter:

```bash
acli jira workitem search \
  --jql 'assignee = currentUser() AND statusCategory = Done AND resolutiondate >= "YYYY-MM-DD" AND resolutiondate <= "YYYY-MM-DD"' \
  --fields "key,summary,status,assignee" \
  --paginate
```

## Gather GitHub PRs

Search for PRs opened in the pulp GitHub organization during the last quarter:

```bash
gh search prs --author=@me --owner=pulp --created="YYYY-MM-DD..YYYY-MM-DD" --limit=100
```

## Write the accomplishments summary

Analyze both data sets and write a short prose reflection (3 paragraphs). Follow these rules exactly:

**Style:**
- First person, as a human would write - not a list, not headers, just prose
- Use normal dashes (-) not em dashes (—)
- No bullet points, no markdown formatting in the output
- 3 paragraphs, each focused on one theme or accomplishment cluster

**Content:**
- Pick 2-3 of the most impactful items - prioritize: critical/major severity bugs fixed, cross-repo or cross-team work, security fixes, customer-facing impact
- For each item, reflect not just on WHAT was done but HOW - e.g. speed of response, backports shipped same day, cross-repo coordination, systematic approach
- Reference specific ticket numbers (e.g. PULP-1263) and PR numbers where relevant, but keep the language accessible
- Avoid listing every ticket - focus on the story behind the most meaningful work
