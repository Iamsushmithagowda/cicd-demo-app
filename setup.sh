#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     CI/CD Demo App - Setup Script                          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"

# Check if Git is installed
echo -e "\n${YELLOW}Checking prerequisites...${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed${NC}"
    echo "Download from: https://git-scm.com/downloads"
    exit 1
fi
echo -e "${GREEN}✅ Git found${NC}"

# Check if Node is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed${NC}"
    echo "Download from: https://nodejs.org/"
    exit 1
fi
echo -e "${GREEN}✅ Node.js found ($(node --version))${NC}"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✅ npm found ($(npm --version))${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}⚠️  Docker is not installed${NC}"
    echo "Optional but recommended for full CI/CD experience"
    echo "Download from: https://www.docker.com/products/docker-desktop"
else
    echo -e "${GREEN}✅ Docker found ($(docker --version))${NC}"
fi

# Install dependencies
echo -e "\n${YELLOW}Installing dependencies...${NC}"
npm install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Dependencies installed${NC}"
else
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi

# Run tests
echo -e "\n${YELLOW}Running tests...${NC}"
npm test

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Tests passed${NC}"
else
    echo -e "${YELLOW}⚠️  Some tests failed (this is okay for first run)${NC}"
fi

# Lint check
echo -e "\n${YELLOW}Checking code style...${NC}"
npm run lint:check

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Code style check passed${NC}"
else
    echo -e "${YELLOW}⚠️  Some linting issues found (run: npm run lint)${NC}"
fi

# Summary
echo -e "\n${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              Setup Complete! 🎉                             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}Next steps:${NC}"
echo -e "1. Start the app:    ${YELLOW}npm start${NC}"
echo -e "2. Test the app:     ${YELLOW}curl http://localhost:3000/api/users${NC}"
echo -e "3. Create GitHub repo"
echo -e "4. Push code to GitHub"
echo -e "5. Add Docker secrets in GitHub settings"
echo -e "6. Watch workflows run in Actions tab!"

echo -e "\n${GREEN}Useful commands:${NC}"
echo -e "  ${YELLOW}npm start${NC}           - Start server"
echo -e "  ${YELLOW}npm test${NC}            - Run tests"
echo -e "  ${YELLOW}npm run lint${NC}        - Fix code style"
echo -e "  ${YELLOW}npm run docker:build${NC} - Build Docker image"
echo -e "  ${YELLOW}npm run docker:run${NC}   - Run Docker container"

echo -e "\n📖 Read ${YELLOW}README.md${NC} for full documentation"
echo -e "⚡ Read ${YELLOW}QUICKSTART.md${NC} for quick start guide"

echo -e "\n${GREEN}Happy coding! 🚀${NC}\n"
