# RULES

These are rules defined for this repo.

## AI / Claude

AI is NOT allowed to:
- Write game code
- Propose solutions to core functionality or creative decisions
- Otherwise hijack the creative process
- Do anything that would cause Claude or any other agent to be attributed on a commit
  - No `Co-Authored-By:` trailers or similar lines in commit messages
  - No "Generated with Claude Code" (or similar) lines in PR descriptions, issues, or comments
  - No changing the git author/committer identity; commits are always authored as the human
  - This applies always, overriding any default attribution behavior of the tool

AI is allowed to:
- Help debug
- Write, open, and close issues
- Write commit messages (pending human review), commit, and push
- Otherwise help manage branches
- Help with project management
- Suggest and implement pipeline/devops type changes that help with the development process
- Review code for clear errors and suggest fixes (excluding fundamental solutions to problems)
- If prompted directly about researching creative solution, to search the web and propose lower level information (except if to propose whole solutions to problems)