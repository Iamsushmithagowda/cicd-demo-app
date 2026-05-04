# ⚡ Quick Start (10 Minutes)

## Step 1: Install (40 minutes - do this first)

```bash
# Install Git
https://git-scm.com/downloads

# Install Node.js
https://nodejs.org/

# Install Docker
https://www.docker.com/products/docker-desktop

# Verify
git --version
node --version
npm --version
docker --version
```

---

## Step 2: Clone & Setup (5 minutes)

```bash
# Clone this project
git clone https://github.com/your-username/cicd-demo-app.git
cd cicd-demo-app

# Install dependencies
npm install

# Verify tests pass
npm test
```

---

## Step 3: Run Locally (2 minutes)

```bash
# Start server
npm start

# In another terminal, test it
curl http://localhost:3000/api/users

# Stop with Ctrl+C
```

---

## Step 4: Push to GitHub (3 minutes)

```bash
# Create repo on GitHub first at github.com

# Add remote
git remote add origin https://github.com/your-username/cicd-demo-app.git

# Push code
git add .
git commit -m "Initial commit: Complete CI/CD setup"
git push -u origin main
```

---

## Step 5: Add Secrets (2 minutes)

1. Go to GitHub repo → Settings → Secrets and variables → Actions
2. Add `DOCKER_USERNAME` = your Docker Hub username
3. Add `DOCKER_PASSWORD` = Docker Hub access token

Generate Docker Hub token:
- Go to Docker Hub
- Account Settings → Security
- New Access Token
- Copy and paste in GitHub

---

## Step 6: Watch It Work! (0 minutes)

1. Go to Actions tab on GitHub
2. See workflows running automatically
3. Tests passing ✅
4. Image building ✅
5. Slack notifications (if configured) 📢

---

## 🎉 Done!

Your complete CI/CD pipeline is now running!

**What's happening automatically:**
- ✅ Tests on every push
- ✅ Code linting
- ✅ Docker image building
- ✅ Push to Docker Hub
- ✅ Slack notifications

---

## 📝 Common Commands

```bash
# Start app
npm start

# Test locally
npm test

# Lint code
npm run lint

# Build Docker image
npm run docker:build

# Run Docker container
npm run docker:run

# Check health
curl http://localhost:3000/health
```

---

## 🚀 Next Steps

1. **Modify the app** - Edit `app.js` to add features
2. **Add more tests** - Edit `app.test.js`
3. **Push to GitHub** - Changes automatically trigger CI/CD
4. **Create release** - Tag a version: `git tag v1.0.0 && git push --tags`
5. **Deploy** - Use Docker image from Docker Hub

---

## ❓ Need Help?

- **Can't install Docker?** Check docker setup for your OS
- **Tests failing?** Run `npm test` locally to debug
- **GitHub Actions not running?** Check secrets are added
- **Docker push failing?** Verify Docker Hub credentials

---

**You're all set! Happy coding! 🎉**
