---
name: deploy
description: Run deployment pipeline with safety checks
arguments:
  - name: environment
    description: Target environment (staging or production)
    required: true
---

# Deploy to {{environment}}

Running deployment pipeline with comprehensive safety checks.

---

## Pre-Deployment Checks

### 1. Test Suite
```bash
npm test || pnpm test
```
**If tests fail: STOP deployment and report failures.**

### 2. Type Check
```bash
npx tsc --noEmit
```
**If type errors exist: STOP deployment and report errors.**

### 3. Lint Check
```bash
npm run lint || pnpm lint
```
**Fix any auto-fixable issues. Report remaining errors.**

### 4. Build
```bash
npm run build || pnpm build
```
**If build fails: STOP deployment and report errors.**

### 5. Security Audit
```bash
npm audit --audit-level=high 2>/dev/null || pnpm audit 2>/dev/null || echo "Audit not available"
```
**Report any high or critical vulnerabilities.**

---

## Deployment

**Only proceed if ALL checks pass.**

### Staging Deployment
```bash
# Typical staging flow
git push origin main
echo "Pushed to main branch"
echo "CI/CD should auto-deploy to staging"
```

### Production Deployment
```bash
# Production requires extra caution
echo "⚠️  PRODUCTION DEPLOYMENT"
echo ""
echo "Pre-production checklist:"
echo "  [ ] All tests passing"
echo "  [ ] Staging tested and verified"
echo "  [ ] No critical security issues"
echo "  [ ] Team notified"
echo ""
echo "To deploy to production, run manually:"
echo "  git tag -a v\$(date +%Y%m%d-%H%M%S) -m 'Production release'"
echo "  git push origin --tags"
```

---

## Post-Deployment Verification

1. **Verify deployment URL is accessible**
2. **Check application logs for errors**
3. **Run smoke tests if available**
4. **Monitor error rates for 15 minutes**

---

## Rollback Plan

If issues are detected after deployment:

```bash
# Revert to previous version
git revert HEAD --no-edit
git push origin main

# Or if using tags
git checkout <previous-tag>
```

---

## Report

Provide deployment summary:
- Pre-check results (pass/fail)
- Deployment status
- Verification results
- Any issues encountered
