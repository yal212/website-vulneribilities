# Database Setup Instructions

## Quick Setup

To set up your Supabase database for the cybersecurity vulnerabilities website:

### 1. Access Supabase Dashboard
1. Go to [supabase.com](https://supabase.com)
2. Sign in to your account
3. Navigate to your project dashboard

### 2. Execute Database Setup
1. In your Supabase dashboard, go to the **SQL Editor**
2. Create a new query
3. Copy and paste the entire contents of `database/setup.sql`
4. Click **Run** to execute the script

### 3. Verify Setup
After running the script, you should see:
- A new `vulnerabilities` table created
- 5 vulnerability records inserted
- Proper indexes and security policies applied

### 4. Test the Application
1. Make sure your `.env.local` file has the correct Supabase credentials
2. Start the development server: `npm run dev`
3. Visit `http://localhost:3001` to see the home page
4. Click on any vulnerability to view its details

## What the Setup Script Does

The `database/setup.sql` script:

1. **Creates the vulnerabilities table** with proper schema
2. **Sets up indexes** for optimal query performance
3. **Enables Row Level Security (RLS)** for data protection
4. **Creates read policies** allowing public access to vulnerability data
5. **Inserts seed data** for all 5 vulnerabilities:
   - SQL Injection
   - Cross-Site Scripting (XSS)
   - Cross-Site Request Forgery (CSRF)
   - Insecure Direct Object Reference (IDOR)
   - Broken Authentication

## Troubleshooting

### If you get permission errors:
- Make sure you're signed in to Supabase
- Verify you have admin access to the project

### If the vulnerabilities don't load:
- Check your `.env.local` file has the correct Supabase URL and API key
- Verify the database setup completed successfully
- Check the browser console for any errors

### If pages show 404:
- Ensure the database setup script ran completely
- Verify the vulnerability slugs match the expected format
- Check that the Supabase client is properly configured

## Environment Variables

Make sure your `.env.local` file contains:

```
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

Replace the values with your actual Supabase project credentials.

## Available Vulnerability Pages

After setup, these pages will be available:

- `/vulnerabilities/sql-injection`
- `/vulnerabilities/cross-site-scripting`
- `/vulnerabilities/cross-site-request-forgery`
- `/vulnerabilities/insecure-direct-object-reference`
- `/vulnerabilities/broken-authentication`
