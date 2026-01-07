GPG 签名
================================================================================

Disable GPG signature check for repo init (and/or for git)

https://stackoverflow.com/questions/69256144/disable-gpg-signature-check-for-repo-init-and-or-for-git

git config --global tag.gpgSign false
git config --global commit.gpgSign false
git config --global gpg.program true
