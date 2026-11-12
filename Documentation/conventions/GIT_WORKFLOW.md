# GIT WORKFLOW

Game work happens on milestone branches, and features branch off those. `main` receives finished milestones, plus repo housekeeping.

```
main ──────────────────────────────●  milestone merge commit (#N)
     \                            /
      milestone/1.2 ──●────●────●     one squash commit per feature PR
                       \    \    \
                        feature branches (deleted after merge)
```

## Branches

- `main`: finished milestones only.
    - Exception: repo housekeeping (rules, pipeline, conventions) can be committed directly.
    - Design doc edits made during a milestone go on the milestone branch, so the same files aren't edited in two places.
- `milestone/<number>`, e.g. `milestone/1.2`: cut from `main` when a milestone starts.
    - One open milestone at a time.
    - Small changes, and early exploratory work before features are well-defined, can be committed directly to it.
- `feature/<short-name>`, e.g. `feature/item-stacking`: cut from the milestone branch.
    - If the feature has its own sub-issue, include the number: `feature/14-item-stacking`.
    - Always branch from the milestone, not from another feature branch.
        - Why: once the parent feature is squash-merged, the child branch still holds the parent's original commits and conflicts when rebased.

## Merging

| PR | Base branch | Merge type |
|---|---|---|
| Feature → milestone | `milestone/<number>` | Squash |
| Milestone → main | `main` | Merge commit |

- Squash features
    - Why: each feature becomes one meaningful commit, and the detailed history stays in its PR.
- Merge commit for milestones
    - Why: it groups the milestone and keeps the feature commits on `main`.
    - `git log --first-parent main` shows milestones (and housekeeping commits). `git log` shows features too.
- Check commit messages before merging. GitHub pre-fills squashes with the commit list and merges with "Merge pull request #N from ...". Rewrite them as a short summary and keep the `(#N)` PR reference.
- PRs default to `main` as their base, both on GitHub and in `gh pr create`. For features, use `gh pr create --base milestone/<number>` or change the base on GitHub.

## Keeping branches up to date

- Feature branches: rebase onto the milestone branch as needed. Use `git push --force-with-lease`, never plain `--force`.
- Milestone branches: don't rebase once feature branches exist. To catch up with `main`, merge `main` into the milestone branch.
- Never rewrite `main` history.

## Cleanup

- Delete branches after merging. The PR keeps the commits and discussion, and can restore the branch.
- Locally: `git fetch --prune`, then `git branch -D <branch>`.
    - Why `-D`: git doesn't recognise squash-merged branches as merged, so `-d` refuses.

## Commits

- Keep commits small, with plain, descriptive messages.
- Squash or reword throwaway commits ("wip", "typo") before pushing, if you feel like it. Feature branches get squashed anyway.

## Issues

- Each milestone has one issue (see [ROADMAP.md](../../ROADMAP.md)). Tick its checklist as features land, and put `Closes #<milestone issue>` in the milestone PR.
- Closing keywords only take effect once they reach `main`. A feature PR merged into a milestone branch won't close anything on its own.
    - For feature sub-issues, keep `Closes #N` in the squash commit message; it closes the issue when the milestone merges.
