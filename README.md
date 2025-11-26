## step2 - pre-commit 🪝

### 1. Setup pre-commit hook
```
- Our pre-commit hook will run a secret detection tool
- The secret detection tool is called Talisman
- Talisman will create a script in .git/hooks and make it executable.
```

### 2. Install talisman as a pre-commit hook
```bash
$ make talisman_setup
```

### 3. Check talisman in action
Add a secret to a file
```bash
$ echo "awsSecretKey=c64e8c79aacf5ddb02f1274db2d973f363f4f553ab1692d8d203b4cc09692f79 ⚡☠️" > insecure_notes.txt
$ git add insecure_notes.txt
```

Try to commit the file, and talisman will prompt a warning.
```bash
$ git commit -m "secret note1"
```
```bash
Talisman Report:
+--------------------+-------------------------------------------------------------------------------+----------+
|        FILE        |                                    ERRORS                                     | SEVERITY |
+--------------------+-------------------------------------------------------------------------------+----------+
| insecure_notes.txt | Expected file to not contain                                                  | high     |
|                    | hex encoded texts such as:                                                    |          |
|                    | awsSecretKey=c64e8c79aacf5ddb02f1274db2d973f363...                            |          |
+--------------------+-------------------------------------------------------------------------------+----------+
| insecure_notes.txt | Potential secret pattern :                                                    | low      |
|                    | awsSecretKey=c64e8c79aacf5ddb02f1274db2d973f363f4f553ab1692d8d203b4cc09692f79 |          |
+--------------------+-------------------------------------------------------------------------------+----------+
```

### 4. Try adding a another secret
Add a secret to a file
```bash
$ echo -e "# new secret \naws_access_key_id = AKIAQYLPMN5HHHFPZAM2\naws_secret_access_key = 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" > insecure_aws.txt
$ git add insecure_aws.txt
```

Try to commit the file, talisman will continue without error 🔥
```bash
$ git commit -m "secret note2"
```

### 5. Let's see with another tool 🧐
```bash
$ make audit_trufflehog
```

Now trufflehog finds the new hardcoded secret 😂
```
✅ Found verified result 🐷🔑
Detector Type: AWS
Decoder Type: PLAIN
Raw result: AKIAQYLPMN5HHHFPZAM2
Resource_type: Access key
Account: 052310077262
Message: This is an AWS canary token generated at canarytokens.org.
Is_canary: true
Arn: arn:aws:iam::052310077262:user/canarytokens.com@@c20nnjzlioibnaxvt392i9ope
File: /target/.git/objects/15/0554cfe0275d2912ce726c72d9fe9d8f52a4f2
Line: 2

✅ Found verified result 🐷🔑
Detector Type: AWS
Decoder Type: PLAIN
Raw result: AKIAQYLPMN5HHHFPZAM2
Resource_type: Access key
Account: 052310077262
Message: This is an AWS canary token generated at canarytokens.org.
Is_canary: true
Arn: arn:aws:iam::052310077262:user/canarytokens.com@@c20nnjzlioibnaxvt392i9ope
File: /target/insecure_aws.txt
Line: 2
```

That's why it's important to have more than one secret detection tool in place!

### Your done 👍 move to step 3
```bash
$ git checkout step3
```

#### +info
Git hooks [+](https://githooks.com)    
Talisman [+](https://github.com/thoughtworks/talisman#recommended-approach)   
Secret detection tools[+](https://github.com/arainho/knowledge-base/tree/main/secret-detection)
