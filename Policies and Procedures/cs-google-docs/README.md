# CS Department Security Policy Documents

## Source

These documents were downloaded on **2026-04-06** from the UChicago CS Department's
Google Drive, as referenced in the NIST CSF 2.0 Security Framework Assessment (SFA)
spreadsheet: [SFA links to documentation](https://docs.google.com/spreadsheets/d/1tgp2-7u7sq9vSqe36tTUpMYOBGut4mnhPEpAclAyzFk/edit?gid=0#gid=0).

## Contents

### SFA Spreadsheet Data

- **SFA-control-questions.csv** — All 71 NIST CSF 2.0 SFA Tier 2 control questions
  exported from the Google Sheet. Columns: Question, Notes, Link to process or
  procedure, Link to Policy. URLs have been replaced with `[Google Doc]` placeholders;
  the original Google Doc URLs are tracked in `SFA-compliance-plan.md`.

### CS Department Policy Documents (15 files)

Of the 71 SFA control questions, 15 have existing CS Department policy documents
linked in the "Link to Policy" column. Each has been saved as a plain-text `.txt` file
named with the pattern `{Control ID} - {Policy Title}.txt`:

| # | Control ID | Filename |
|---|------------|----------|
| 1 | ID.AM-01.01 | ID.AM-01.01 - Third-party System and Service Inventory Policy.txt |
| 2 | ID.RA-02.01 | ID.RA-02.01 - Vulnerability Identification.txt |
| 3 | ID.RA-03.01 | ID.RA-03.01 - Threat Identification and Documentation.txt |
| 4 | ID.RA-04.01 | ID.RA-04.01 - Risk Assessment Policy.txt |
| 5 | ID.RA-05.01 | ID.RA-05.01 - Risk Calculation Policy.txt |
| 6 | ID.RA-06.01 | ID.RA-06.01 - Risk Response Policy.txt |
| 7 | PR.AT-01.01 | PR.AT-01.01 - Security Training for Personnel Policy.txt |
| 8 | PR.AT-02.01 | PR.AT-02.01 - Security Training for Admin Responsibilities Policy.txt |
| 9 | DE.CM-01.01 | DE.CM-01.01 - Network Monitoring Policy.txt |
| 10 | DE.CM-02.01 | DE.CM-02.01 - Physical Security Monitoring Policy.txt |
| 11 | DE.AE-02.01 | DE.AE-02.01 - Security Event Analysis Policy.txt |
| 12 | DE.AE-03.01 | DE.AE-03.01 - Security Event Impact Assessment Policy.txt |
| 13 | RS.MI-01.01 | RS.MI-01.01 - Quarantine Policies for Impacted Systems.txt |
| 14 | RS.MI-02.01 | RS.MI-02.01 - Cyber Security Incident Mitigation Policy.txt |
| 15 | RC.CO-03.01 | RC.CO-03.01 - Communication of Recovery Activities.txt |

## Status

These policies are **pending individual review and approval** before being imported
into the Jekyll documentation site. The review checklist and workflow are tracked in
the parent directory's `SFA-compliance-plan.md`.

## NIST CSF 2.0 Category Coverage

The 15 existing policies cover the following NIST CSF 2.0 categories:

- **Identify (ID)**: Asset Management (AM), Risk Assessment (RA)
- **Protect (PR)**: Awareness & Training (AT)
- **Detect (DE)**: Continuous Monitoring (CM), Adverse Event Analysis (AE)
- **Respond (RS)**: Mitigation (MI)
- **Recover (RC)**: Communication (CO)

The remaining 56 SFA control questions do not yet have associated CS Department
policy documents and will need new policies drafted as part of the compliance effort.
