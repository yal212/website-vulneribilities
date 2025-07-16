# Cybersecurity Vulnerabilities Website

A modern, interactive educational website built with Next.js 15 that explores common web application security vulnerabilities. This project provides detailed information about various cybersecurity threats, real-world examples, and prevention strategies.

## 🚀 Features

- **Interactive Home Page** with animated vulnerability cards
- **Detailed Vulnerability Pages** covering 5 major security threats
- **Real-world Examples** from actual security breaches
- **Code Examples** showing vulnerable vs. secure implementations
- **Prevention Strategies** and best practices
- **Responsive Design** that works on all devices
- **Smooth Animations** using Framer Motion
- **Modern UI** with Tailwind CSS and glass morphism effects

## 🔒 Covered Vulnerabilities

1. **SQL Injection** - Database manipulation attacks
2. **Cross-Site Scripting (XSS)** - Client-side code injection
3. **Cross-Site Request Forgery (CSRF)** - Unauthorized action execution
4. **Insecure Direct Object Reference (IDOR)** - Access control bypasses
5. **Broken Authentication** - Authentication mechanism flaws

## 🛠️ Technology Stack

- **Framework**: Next.js 15 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS v4
- **Animations**: Framer Motion
- **Database**: Supabase (PostgreSQL)
- **Deployment**: Ready for Vercel, Netlify, or any Node.js hosting

## 📋 Prerequisites

- Node.js 18+
- npm or yarn
- Supabase account (free tier available)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd cyber_sercerity_web
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Set Up Environment Variables

Copy the example environment file:

```bash
cp .env.example .env.local
```

Update `.env.local` with your Supabase credentials:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Set Up Database

1. Go to your [Supabase Dashboard](https://supabase.com)
2. Navigate to the SQL Editor
3. Copy and paste the contents of `database/setup.sql`
4. Execute the script to create tables and insert data

### 5. Run Development Server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the application.

## 📁 Project Structure

```
src/
├── app/                          # Next.js App Router
│   ├── vulnerabilities/[slug]/   # Dynamic vulnerability pages
│   ├── globals.css              # Global styles
│   ├── layout.tsx               # Root layout
│   └── page.tsx                 # Home page
├── components/                   # React components
│   ├── HomePage.tsx             # Landing page component
│   ├── VulnerabilityDetail.tsx  # Vulnerability display
│   └── CodeBlock.tsx            # Code syntax highlighting
├── hooks/                       # Custom React hooks
│   └── useScrollAnimation.ts    # Scroll-triggered animations
├── lib/                         # Utility libraries
│   └── supabase.ts             # Supabase client
└── types/                       # TypeScript definitions
    └── vulnerability.ts         # Type definitions
```

## 🗄️ Database Schema

The application uses a single `vulnerabilities` table with the following structure:

- `id` (UUID) - Primary key
- `slug` (VARCHAR) - URL-friendly identifier
- `name` (VARCHAR) - Vulnerability name
- `description` (TEXT) - Detailed description
- `real_life_example` (TEXT) - Historical examples
- `prevention_methods` (TEXT) - Security measures
- `code_snippet` (TEXT) - Code examples
- `image_url` (TEXT) - Optional images
- `created_at` / `updated_at` (TIMESTAMP) - Metadata

## 🚀 Deployment

### Deploy to Vercel (Recommended)

1. Push your code to GitHub
2. Connect your repository to [Vercel](https://vercel.com)
3. Add environment variables in Vercel dashboard
4. Deploy automatically on every push

### Deploy to Netlify

1. Build the project: `npm run build`
2. Deploy the `.next` folder to Netlify
3. Configure environment variables
4. Set up continuous deployment

### Deploy to Any Node.js Host

1. Build the project: `npm run build`
2. Start the production server: `npm start`
3. Ensure environment variables are set
4. Configure reverse proxy if needed

## 🔧 Build Commands

```bash
# Development
npm run dev

# Production build
npm run build

# Start production server
npm start

# Lint code
npm run lint
```

## 🎨 Customization

### Adding New Vulnerabilities

1. Insert data into the `vulnerabilities` table
2. The pages will be automatically generated
3. Update the home page cards if needed

### Styling

- Modify `src/app/globals.css` for global styles
- Update Tailwind classes in components
- Customize animations in `useScrollAnimation.ts`

### Content

- Edit vulnerability data in the database
- Update code examples and prevention methods
- Add images via Supabase Storage

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Support

If you encounter any issues:

1. Check the [DATABASE_SETUP.md](DATABASE_SETUP.md) guide
2. Verify your environment variables
3. Ensure Supabase is properly configured
4. Check the browser console for errors

## 🎯 Educational Use

This website is designed for educational purposes to raise awareness about cybersecurity vulnerabilities. It should be used responsibly and ethically for learning and training purposes only.
