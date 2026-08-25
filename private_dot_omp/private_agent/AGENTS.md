# User Rules

## Remote Commit Safety

Before every `git commit` or `git push` to a remote, MUST inspect the staged diff and the outgoing commits for secrets, credentials, API keys, access tokens, private keys, cookies, signed URLs, personal data, and other PII. MUST remove or redact any such material before committing or pushing. NEVER commit or push sensitive information, including when it appears in generated artifacts, logs, diagnostics, configuration, tests, or documentation.
