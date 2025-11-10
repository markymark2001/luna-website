# Luna Website

Official website for Luna - AI-Powered Astrology mobile app.

This website hosts the Privacy Policy and Terms of Service required for App Store submission.

## Contents

- `index.html` - Landing page
- `privacy.html` - Privacy Policy
- `terms.html` - Terms of Service
- `style.css` - Stylesheet

## Setup Instructions

### 1. Create GitHub Repository

```bash
# Navigate to the website directory
cd luna-website

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial Luna website with privacy policy and terms"

# Create repository on GitHub (via web interface or gh CLI)
# If using gh CLI:
gh repo create luna-website --public --source=. --remote=origin --push

# If creating manually on GitHub, add remote and push:
git remote add origin https://github.com/YOUR_USERNAME/luna-website.git
git branch -M main
git push -u origin main
```

### 2. Enable GitHub Pages

**Option A: Via GitHub Web Interface (Recommended)**

1. Go to your repository: `https://github.com/YOUR_USERNAME/luna-website`
2. Click **Settings** (top navigation)
3. Click **Pages** (left sidebar)
4. Under "Build and deployment":
   - Source: **Deploy from a branch**
   - Branch: **main** (or **master**)
   - Folder: **/ (root)**
5. Click **Save**
6. Wait 1-2 minutes for deployment

Your site will be available at: `https://YOUR_USERNAME.github.io/luna-website/`

**Option B: Via GitHub CLI**

```bash
gh repo edit --enable-pages --pages-branch main
```

### 3. Connect Custom Domain (lunaapp.io)

#### Step 1: Configure DNS Settings

Log into your domain registrar (where you purchased lunaapp.io) and add these DNS records:

**For Root Domain (lunaapp.io):**

| Type | Name | Value | TTL |
|------|------|-------|-----|
| A | @ | 185.199.108.153 | 3600 |
| A | @ | 185.199.109.153 | 3600 |
| A | @ | 185.199.110.153 | 3600 |
| A | @ | 185.199.111.153 | 3600 |
| CNAME | www | YOUR_USERNAME.github.io | 3600 |

**Replace `YOUR_USERNAME` with your actual GitHub username.**

**Popular Domain Registrars:**

<details>
<summary>Namecheap</summary>

1. Log in to Namecheap
2. Go to Domain List → Manage
3. Advanced DNS tab
4. Add the A and CNAME records above
5. Save changes
</details>

<details>
<summary>Cloudflare</summary>

1. Log in to Cloudflare
2. Select your domain
3. DNS tab
4. Add the A and CNAME records above
5. **Important:** Set Proxy status to "DNS only" (gray cloud) for GitHub Pages
</details>

<details>
<summary>Google Domains</summary>

1. Log in to Google Domains
2. Select lunaapp.io
3. DNS tab → Manage Custom Records
4. Add the A and CNAME records above
</details>

<details>
<summary>GoDaddy</summary>

1. Log in to GoDaddy
2. My Products → DNS
3. Add the A and CNAME records above
4. Save changes
</details>

#### Step 2: Configure GitHub Pages Custom Domain

1. Go to your GitHub repository settings
2. Click **Pages** (left sidebar)
3. Under "Custom domain", enter: **lunaapp.io**
4. Click **Save**
5. Wait for DNS check to complete (may take a few minutes)
6. Once verified, check **Enforce HTTPS** (automatic via Let's Encrypt)

**Note:** DNS propagation can take 24-48 hours, but usually completes within 15-30 minutes.

#### Step 3: Verify Setup

After DNS propagation, your website will be accessible at:

- `https://lunaapp.io`
- `https://www.lunaapp.io`
- `https://lunaapp.io/privacy.html`
- `https://lunaapp.io/terms.html`

**Test your setup:**

```bash
# Check DNS records (should show GitHub IPs)
dig lunaapp.io A

# Check CNAME (should show your GitHub Pages URL)
dig www.lunaapp.io CNAME

# Test HTTPS (should return 200 OK)
curl -I https://lunaapp.io
```

### 4. App Store Connect Configuration

Once your website is live, use these URLs in App Store Connect:

**App Information:**
- **Marketing URL:** `https://lunaapp.io`
- **Privacy Policy URL:** `https://lunaapp.io/privacy.html`
- **Terms of Service URL:** `https://lunaapp.io/terms.html` (if requested)

**Subscription Information:**
- Include privacy policy and terms URLs in subscription descriptions

## Updating Content

To update the website content:

```bash
# Make your edits to HTML/CSS files
vim privacy.html  # or use your preferred editor

# Commit changes
git add .
git commit -m "Update privacy policy"

# Push to GitHub
git push origin main

# GitHub Pages will automatically redeploy (1-2 minutes)
```

## Troubleshooting

### DNS Not Working

**Problem:** Custom domain shows "Page not found" or "DNS_PROBE_FINISHED_NXDOMAIN"

**Solutions:**
1. Wait longer - DNS can take up to 48 hours to propagate
2. Check DNS records are correct: `dig lunaapp.io A`
3. Clear your DNS cache:
   - Mac: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`
   - Windows: `ipconfig /flushdns`
4. Try accessing in incognito mode or different browser

### HTTPS Not Working

**Problem:** "Your connection is not private" or HTTPS checkbox is grayed out

**Solutions:**
1. Wait for DNS verification to complete (green checkmark in GitHub Pages settings)
2. Ensure DNS records are correct
3. Disable and re-enable custom domain in GitHub Pages settings
4. Wait 15-30 minutes for Let's Encrypt certificate to be issued

### 404 Error on Subpages

**Problem:** `lunaapp.io` works but `lunaapp.io/privacy.html` shows 404

**Solutions:**
1. Ensure files are in the root directory (not in a subdirectory)
2. Check file names are lowercase and match exactly: `privacy.html`, not `Privacy.html`
3. Clear GitHub Pages cache by making a small commit and pushing

### Cloudflare Issues

**Problem:** Custom domain not working with Cloudflare

**Solutions:**
1. Set DNS records to "DNS only" (gray cloud), not "Proxied" (orange cloud)
2. Disable Cloudflare's "Always Use HTTPS" temporarily during setup
3. Add page rule to bypass cache: `lunaapp.io/*` → Cache Level: Bypass

## Legal Compliance Checklist

Before submitting to App Store, verify:

- [ ] Privacy Policy is accessible at `https://lunaapp.io/privacy.html`
- [ ] Terms of Service is accessible at `https://lunaapp.io/terms.html`
- [ ] HTTPS is enabled (green padlock in browser)
- [ ] Links work on mobile devices (test in Safari on iPhone)
- [ ] Contact email is correct and monitored: mark@mediakey.io
- [ ] Company name is correct: TEAM DECA LTD
- [ ] Effective dates are current
- [ ] Age restriction is 17+ (matches App Store rating)

## Maintenance

**Annual Reviews:**
- Review and update privacy policy annually
- Update effective dates when making changes
- Notify users of material changes (via email/in-app notification)

**Monitoring:**
- Monitor mark@mediakey.io for privacy inquiries
- Respond to user data requests within 30 days (GDPR/CCPA)
- Keep GitHub repository private if you add sensitive information

## Support

For questions about this website setup, contact:
- Email: mark@mediakey.io
- GitHub: https://github.com/YOUR_USERNAME/luna-website

---

**Created for TEAM DECA LTD - Luna App**
