# Deployment Guide

This guide covers deploying the Cybersecurity Vulnerabilities website to various platforms.

## 🚀 Vercel Deployment (Recommended)

Vercel is the easiest way to deploy Next.js applications and is created by the same team.

### Prerequisites
- GitHub account
- Vercel account (free tier available)
- Supabase project set up

### Steps

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Ready for deployment"
   git push origin main
   ```

2. **Connect to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Click "New Project"
   - Import your GitHub repository
   - Vercel will auto-detect Next.js settings

3. **Configure Environment Variables**
   In Vercel dashboard, add these environment variables:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Deploy**
   - Click "Deploy"
   - Vercel will build and deploy automatically
   - Get your live URL (e.g., `your-app.vercel.app`)

### Automatic Deployments
- Every push to main branch triggers automatic deployment
- Preview deployments for pull requests
- Rollback capability

## 🌐 Netlify Deployment

### Prerequisites
- Netlify account
- Built project files

### Steps

1. **Build the Project**
   ```bash
   npm run build
   npm run export  # If using static export
   ```

2. **Deploy via Drag & Drop**
   - Go to [netlify.com](https://netlify.com)
   - Drag the `out` folder (or `.next` for server-side)
   - Configure environment variables in site settings

3. **Deploy via Git**
   - Connect your GitHub repository
   - Set build command: `npm run build`
   - Set publish directory: `.next`
   - Add environment variables

## 🐳 Docker Deployment

### Dockerfile
Create a `Dockerfile` in the project root:

```dockerfile
FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public

# Set the correct permission for prerender cache
RUN mkdir .next
RUN chown nextjs:nodejs .next

COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]
```

### Docker Commands
```bash
# Build image
docker build -t cybersecurity-web .

# Run container
docker run -p 3000:3000 \
  -e NEXT_PUBLIC_SUPABASE_URL=your_url \
  -e NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key \
  cybersecurity-web
```

## ☁️ AWS Deployment

### Using AWS Amplify

1. **Connect Repository**
   - Go to AWS Amplify Console
   - Connect your GitHub repository
   - Choose the main branch

2. **Build Settings**
   ```yaml
   version: 1
   frontend:
     phases:
       preBuild:
         commands:
           - npm ci
       build:
         commands:
           - npm run build
     artifacts:
       baseDirectory: .next
       files:
         - '**/*'
     cache:
       paths:
         - node_modules/**/*
   ```

3. **Environment Variables**
   Add in Amplify console:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### Using EC2

1. **Launch EC2 Instance**
   - Choose Ubuntu/Amazon Linux
   - Configure security groups (port 3000)
   - SSH into instance

2. **Install Dependencies**
   ```bash
   # Install Node.js
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs

   # Install PM2 for process management
   sudo npm install -g pm2
   ```

3. **Deploy Application**
   ```bash
   # Clone repository
   git clone your-repo-url
   cd cyber_sercerity_web

   # Install dependencies
   npm install

   # Build application
   npm run build

   # Start with PM2
   pm2 start npm --name "cybersecurity-web" -- start
   pm2 startup
   pm2 save
   ```

## 🔧 Environment Variables for Production

Ensure these are set in your deployment platform:

```env
# Required
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key

# Optional (for analytics, monitoring, etc.)
NEXT_PUBLIC_GA_ID=your-google-analytics-id
SENTRY_DSN=your-sentry-dsn
```

## 🔍 Pre-Deployment Checklist

- [ ] Database is set up and populated
- [ ] Environment variables are configured
- [ ] Build passes locally (`npm run build`)
- [ ] All TypeScript errors resolved
- [ ] ESLint warnings addressed
- [ ] Images optimized and accessible
- [ ] SEO metadata configured
- [ ] Error pages tested
- [ ] Performance optimized

## 🚨 Troubleshooting

### Build Failures
- Check Node.js version compatibility
- Verify all dependencies are installed
- Review TypeScript errors
- Check environment variable names

### Runtime Errors
- Verify Supabase connection
- Check environment variables in production
- Review browser console for client-side errors
- Check server logs for SSR issues

### Performance Issues
- Enable Next.js Image Optimization
- Configure CDN for static assets
- Implement proper caching headers
- Monitor Core Web Vitals

## 📊 Monitoring

### Recommended Tools
- **Vercel Analytics** (if using Vercel)
- **Google Analytics** for user tracking
- **Sentry** for error monitoring
- **Lighthouse** for performance audits

### Health Checks
Set up monitoring for:
- Application uptime
- Database connectivity
- API response times
- Error rates

## 🔄 CI/CD Pipeline

Example GitHub Actions workflow (`.github/workflows/deploy.yml`):

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - run: npm run test # if you have tests
      - name: Deploy to Vercel
        uses: vercel/action@v1
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

This deployment guide ensures your cybersecurity vulnerabilities website is production-ready and can be deployed to any modern hosting platform.
