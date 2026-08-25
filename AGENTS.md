# User Rules

## Remote Commit Safety

Before every `git commit` or `git push` to a remote, MUST inspect the staged diff and the outgoing commits for secrets, credentials, API keys, access tokens, private keys, cookies, signed URLs, personal data, and other PII. MUST remove or redact any such material before committing or pushing. NEVER commit or push sensitive information, including when it appears in generated artifacts, logs, diagnostics, configuration, tests, or documentation.

To ensure absolute safety, the commit and push process MUST be explicitly broken down into the following strict sequential steps. Chaining these commands (e.g. using `&&`) without intermediate verification is PROHIBITED:
1. `git add <files>` - Stage the intended changes.
2. `git diff --cached` - Verify the staged diff contains no sensitive information.
3. `git commit -m "..."` - Commit the verified changes.
4. `git log -p @{u}..HEAD` (or `git diff @{u}..HEAD`) - Verify all outgoing commits contain no sensitive information.
5. `git push` - Push to the remote.
