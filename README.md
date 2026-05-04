# 🚀 CI/CD Demo Application

A complete, production-ready Node.js application with automated CI/CD pipeline using GitHub Actions and Docker.

## 📋 Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Local Setup](#local-setup)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)
- [Docker](#docker)
- [GitHub Actions](#github-actions)
- [Deployment](#deployment)

---

## ✨ Features

✅ **Complete CI/CD Pipeline**
- Automated testing on every push
- Code linting and style checking
- Automated Docker image building
- Push to Docker Hub
- Slack notifications

✅ **RESTful API**
- Get all users
- Get user by ID
- Create new user
- Health check endpoint

✅ **Production Ready**
- Non-root Docker user (security)
- Health checks
- Graceful shutdown
- Error handling
- CORS support

✅ **Testing & Quality**
- Jest unit tests
- ESLint code quality
- Test coverage
- Multiple Node versions

---

## 📁 Project Structure

```
cicd-demo-app/
├── .github/
│   └── workflows/
│       ├── ci.yml              # Testing workflow
│       └── docker.yml          # Docker build workflow
├── app.js                       # Main application
├── app.test.js                  # Test file
├── package.json                 # Dependencies & scripts
├── Dockerfile                   # Docker configuration
├── .dockerignore                # Docker build exclusions
├── .gitignore                   # Git exclusions
├── .eslintrc.json              # ESLint config
├── README.md                    # This file
└── LICENSE                      # MIT License
```

---

## 📦 Prerequisites

Before you start, make sure you have installed:

- **Git** - https://git-scm.com/downloads
- **Node.js 18+** - https://nodejs.org/
- **Docker** - https://www.docker.com/products/docker-desktop
- **GitHub Account** - https://github.com
- **Docker Hub Account** - https://hub.docker.com

### Verify Installation

```bash
git --version
node --version
npm --version
docker --version
```

---

## 🛠️ Local Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/cicd-demo-app.git
cd cicd-demo-app
```

### 2. Install Dependencies

```bash
npm install
```

This installs:
- **jest** - Testing framework
- **eslint** - Code linter

### 3. Verify Installation

```bash
npm run test
npm run lint:check
```

---

## ▶️ Running the Application

### Start Server Locally

```bash
npm start
```

You should see:
```
✅ Server running on http://localhost:3000
📝 Try: curl http://localhost:3000/api/users
```

### Test Health Endpoint

```bash
curl http://localhost:3000/health
```

Response:
```json
{
  "status": "ok",
  "timestamp": "2024-01-15T10:30:45.123Z"
}
```

### Stop Server

Press `Ctrl + C` to stop the server.

---

## 📡 API Endpoints

### 1. Welcome Endpoint
```
GET /
```
Returns welcome message and available endpoints.

```bash
curl http://localhost:3000/
```

### 2. Health Check
```
GET /health
```
Returns server status (used by Docker health checks).

```bash
curl http://localhost:3000/health
```

### 3. Get All Users
```
GET /api/users
```

```bash
curl http://localhost:3000/api/users
```

Response:
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Alice",
      "email": "alice@example.com"
    }
  ]
}
```

### 4. Get User by ID
```
GET /api/users/:id
```

```bash
curl http://localhost:3000/api/users/1
```

### 5. Create User
```
POST /api/users
Content-Type: application/json

{
  "name": "Charlie",
  "email": "charlie@example.com"
}
```

```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Charlie","email":"charlie@example.com"}'
```

---

## 🧪 Testing

### Run Tests

```bash
npm test
```

### Run Tests with Coverage

```bash
npm run test:coverage
```

Shows:
- Lines covered
- Branches covered
- Functions covered
- Statements covered

### Run Tests in Watch Mode

```bash
npm run test:watch
```

Tests re-run automatically when you change files.

---

## 🐳 Docker

### Build Docker Image Locally

```bash
npm run docker:build
```

Or manually:
```bash
docker build -t cicd-demo-app .
```

### Run Docker Container Locally

```bash
npm run docker:run
```

Or manually:
```bash
docker run -p 3000:3000 cicd-demo-app
```

The app will be accessible at `http://localhost:3000`

### Stop Docker Container

Press `Ctrl + C`

### Push to Docker Hub

```bash
# Login to Docker Hub
docker login

# Tag image with your username
docker tag cicd-demo-app your-username/cicd-demo-app:latest

# Push to Docker Hub
docker push your-username/cicd-demo-app:latest
```

---

## ⚙️ GitHub Actions

This project includes two automated workflows:

### 1. CI Pipeline (`.github/workflows/ci.yml`)

**Triggers:** 
- Every push to `main` or `develop`
- Every pull request

**What it does:**
1. ✅ Checks out code
2. ✅ Sets up Node.js (tests on 18.x and 20.x)
3. ✅ Installs dependencies
4. ✅ Runs linting checks
5. ✅ Runs tests
6. ✅ Builds application
7. ✅ Sends Slack notification

### 2. Docker Pipeline (`.github/workflows/docker.yml`)

**Triggers:**
- Push to `main` branch
- Git tags (e.g., `v1.0.0`)

**What it does:**
1. ✅ Builds Docker image
2. ✅ Logs into Docker Hub
3. ✅ Pushes image with tags
4. ✅ Caches layers for speed
5. ✅ Sends Slack notification

### Setup GitHub Secrets

For workflows to work, add these secrets:

1. Go to: **Repository Settings** → **Secrets and variables** → **Actions**

2. Add `DOCKER_USERNAME`:
   - Your Docker Hub username

3. Add `DOCKER_PASSWORD`:
   - Docker Hub access token (NOT your password!)
   - Generate at: Docker Hub → Account Settings → Security

4. (Optional) Add `SLACK_WEBHOOK_URL`:
   - Slack incoming webhook for notifications
   - Create at: https://api.slack.com/messaging/webhooks

---

## 🚀 Deployment

### Option 1: Deploy Docker Image

Once image is pushed to Docker Hub, deploy anywhere:

```bash
docker pull your-username/cicd-demo-app:main
docker run -p 3000:3000 your-username/cicd-demo-app:main
```

### Option 2: Use Docker Compose

```yaml
version: '3.8'
services:
  app:
    image: your-username/cicd-demo-app:main
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - PORT=3000
```

Run:
```bash
docker-compose up
```

### Option 3: Cloud Platforms

The Docker image can be deployed to:
- **Heroku**: `heroku container:push web && heroku container:release web`
- **DigitalOcean**: App Platform or Droplet
- **AWS**: ECS, EKS, or EC2
- **Google Cloud**: Cloud Run, GKE
- **Azure**: Container Instances, App Service

---

## 📊 CI/CD Pipeline Flow

```
Your Code Change
       ↓
Push to GitHub
       ↓
    ┌─────────────────────────────┐
    │   GitHub Actions Triggered  │
    └─────────────────────────────┘
       ↓
    ┌─────────────┬──────────────┐
    │             │              │
    ▼             ▼              ▼
  Tests       Linting        Build
  (Jest)      (ESLint)    (npm build)
    │             │              │
    └─────────────┴──────────────┘
             ↓
        All Pass?
         ↙    ↘
       ✅      ❌
       │       │
       ↓       └→ Notify & Block Merge
       │
    Docker Build
       │
    Docker Push
       │
   Slack Alert
       ↓
   ✅ Done!
```

---

## 🔐 Security

✅ **Best Practices Implemented:**
- Non-root Docker user
- Health checks enabled
- Secrets stored in GitHub (not in code)
- CORS properly configured
- Input validation
- Error handling

⚠️ **Security Notes:**
- Never commit secrets to Git
- Always use GitHub Secrets
- Keep Docker images minimal
- Scan images for vulnerabilities
- Use specific versions in package.json

---

## 📝 Scripts Reference

| Command | Purpose |
|---------|---------|
| `npm start` | Start server |
| `npm test` | Run tests |
| `npm run lint:check` | Check code style |
| `npm run lint` | Fix code style issues |
| `npm run build` | Build application |
| `npm run test:coverage` | Test coverage report |
| `npm run docker:build` | Build Docker image |
| `npm run docker:run` | Run Docker container |

---

## 🐛 Troubleshooting

### Server Won't Start
```bash
# Check if port 3000 is in use
lsof -i :3000  # macOS/Linux
netstat -ano | findstr :3000  # Windows

# Use different port
PORT=3001 npm start
```

### Tests Fail
```bash
# Clear cache
npm test -- --clearCache

# Run with verbose output
npm test -- --verbose
```

### Docker Build Fails
```bash
# Check Dockerfile syntax
docker build . --no-cache

# View build logs
docker build -t app . --progress=plain
```

### GitHub Actions Not Running
- Check `.github/workflows/` folder exists
- Verify workflow YAML syntax
- Check branch protection rules
- Look at Actions tab for error logs

---

## 📚 Learning Resources

- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Docker Documentation](https://docs.docker.com)
- [Node.js Documentation](https://nodejs.org/docs)
- [Jest Testing Guide](https://jestjs.io)
- [ESLint Rules](https://eslint.org/docs/rules)

---

## 📄 License

MIT License - See LICENSE file for details

---

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

All PR automatically run CI/CD checks before merging.

---

## 📞 Support

- **Issues**: Open GitHub issue
- **Discussions**: Use GitHub Discussions
- **Slack**: Check workspace notifications

---

## ✅ Quick Start Checklist

- [ ] Install Git, Node.js, Docker
- [ ] Clone repository
- [ ] Run `npm install`
- [ ] Run `npm test`
- [ ] Run `npm start`
- [ ] Test API endpoints
- [ ] Create GitHub repository
- [ ] Push code to GitHub
- [ ] Add Docker Hub secrets
- [ ] Watch CI/CD run!

---

**Made with ❤️ for learning CI/CD**

Happy coding!! 🚀

