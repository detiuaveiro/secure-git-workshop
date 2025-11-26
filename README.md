## step5 - dynamic analysis

### 1. What is dynamic analysis ?

Dynamic application security testing (DAST): "Technologies designed to detect conditions indicative of a security vulnerability in an application in its running state."
  (Gartner, 2022)

### 2. Run OWASP ZAP 
```
- We will use OWASP ZAP container
- And a GitHub Workflow
- To analyse a REST API
- DAST API scanning
```

### 3. Preview the REST API application code
```
- https://github.com/optiv/rest-api-goat
```

### 4. Analyze the Workflow definition
```bash
cat .github/workflows/api-scanning.yml
```

Put the `api-scanning.yaml` file in the `main` branch, under `.github/workflows`.

### 5. View the Workflow actions running   
If you forked the repository, change the following URL accordingly.
```
https://github.com/detiuaveiro/secure-git-workshop/actions/workflows/api-scanning.yml
```

### Your done 👍 move to step 6
```bash
git checkout step6
```
