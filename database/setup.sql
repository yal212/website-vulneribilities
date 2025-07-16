-- Complete database setup for cybersecurity vulnerabilities website
-- Run this script in your Supabase SQL Editor

-- Create vulnerabilities table
CREATE TABLE IF NOT EXISTS vulnerabilities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  slug VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  real_life_example TEXT NOT NULL,
  prevention_methods TEXT NOT NULL,
  code_snippet TEXT,
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create an index on slug for faster lookups
CREATE INDEX IF NOT EXISTS idx_vulnerabilities_slug ON vulnerabilities(slug);

-- Enable Row Level Security (RLS)
ALTER TABLE vulnerabilities ENABLE ROW LEVEL SECURITY;

-- Create a policy that allows read access to all users
CREATE POLICY "Allow read access to vulnerabilities" ON vulnerabilities
  FOR SELECT USING (true);

-- Create a function to update the updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create a trigger to automatically update the updated_at column
CREATE TRIGGER update_vulnerabilities_updated_at
  BEFORE UPDATE ON vulnerabilities
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Insert vulnerability data
INSERT INTO vulnerabilities (slug, name, description, real_life_example, prevention_methods, code_snippet) VALUES
(
  'sql-injection',
  'SQL Injection',
  'SQL injection is a code injection technique that exploits vulnerabilities in an application''s software when user input is not properly sanitized before being included in SQL queries. Attackers can manipulate SQL queries to access, modify, or delete data from the database.',
  'In 2008, Heartland Payment Systems suffered a massive data breach due to SQL injection attacks, resulting in the theft of over 130 million credit and debit card numbers. The attackers exploited SQL injection vulnerabilities in the company''s payment processing systems.',
  '1. Use parameterized queries or prepared statements
2. Implement input validation and sanitization
3. Use stored procedures with proper parameter handling
4. Apply the principle of least privilege for database accounts
5. Regularly update and patch database software
6. Use web application firewalls (WAF)
7. Conduct regular security audits and penetration testing',
  '-- Vulnerable code (PHP)
$query = "SELECT * FROM users WHERE username = ''" . $_POST[''username''] . "'' AND password = ''" . $_POST[''password''] . "''";

-- Secure code (PHP with prepared statements)
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
$stmt->execute([$_POST[''username''], $_POST[''password'']]);'
),
(
  'cross-site-scripting',
  'Cross-Site Scripting (XSS)',
  'Cross-Site Scripting (XSS) is a security vulnerability that allows attackers to inject malicious scripts into web pages viewed by other users. These scripts can steal sensitive information, manipulate page content, or perform actions on behalf of the victim.',
  'In 2005, the Samy worm spread across MySpace through a stored XSS vulnerability. The worm automatically added the attacker as a friend and replicated itself on victims'' profiles, affecting over one million users within 20 hours.',
  '1. Encode output data before displaying it in HTML
2. Validate and sanitize all user inputs
3. Use Content Security Policy (CSP) headers
4. Implement proper session management
5. Use HTTPOnly and Secure flags for cookies
6. Regularly update web frameworks and libraries
7. Perform security code reviews',
  '<!-- Vulnerable code -->
<div>Welcome, <?php echo $_GET[''name'']; ?>!</div>

<!-- Secure code -->
<div>Welcome, <?php echo htmlspecialchars($_GET[''name''], ENT_QUOTES, ''UTF-8''); ?>!</div>

<!-- JavaScript secure encoding -->
function escapeHtml(text) {
  const div = document.createElement(''div'');
  div.textContent = text;
  return div.innerHTML;
}'
),
(
  'cross-site-request-forgery',
  'Cross-Site Request Forgery (CSRF)',
  'Cross-Site Request Forgery (CSRF) is an attack that forces an end user to execute unwanted actions on a web application in which they are currently authenticated. Attackers can trick users into performing actions they did not intend to perform.',
  'In 2008, a CSRF vulnerability in Gmail allowed attackers to add email filters to victims'' accounts. By tricking users into visiting a malicious website while logged into Gmail, attackers could redirect emails to their own accounts.',
  '1. Implement CSRF tokens for state-changing operations
2. Use SameSite cookie attributes
3. Verify the Origin and Referer headers
4. Implement proper session management
5. Use double-submit cookies pattern
6. Require re-authentication for sensitive actions
7. Implement proper CORS policies',
  '<!-- Vulnerable form -->
<form action="/transfer" method="POST">
  <input name="amount" value="1000">
  <input name="to_account" value="attacker_account">
  <button type="submit">Transfer</button>
</form>

<!-- Secure form with CSRF token -->
<form action="/transfer" method="POST">
  <input type="hidden" name="csrf_token" value="<?php echo $_SESSION[''csrf_token'']; ?>">
  <input name="amount" value="1000">
  <input name="to_account" value="recipient_account">
  <button type="submit">Transfer</button>
</form>'
),
(
  'insecure-direct-object-reference',
  'Insecure Direct Object Reference (IDOR)',
  'Insecure Direct Object Reference (IDOR) occurs when an application provides direct access to objects based on user-supplied input. This vulnerability allows attackers to bypass authorization and access resources belonging to other users.',
  'In 2019, Facebook experienced an IDOR vulnerability that allowed users to view private photos of other users by manipulating photo IDs in URLs. This affected millions of users before being patched.',
  '1. Implement proper access controls and authorization checks
2. Use indirect reference maps or random tokens
3. Validate user permissions for each object access
4. Implement session-based authorization
5. Use UUIDs instead of sequential IDs
6. Log and monitor access attempts
7. Conduct regular security assessments',
  '// Vulnerable code
app.get(''/user/:id'', (req, res) => {
  const user = getUserById(req.params.id);
  res.json(user);
});

// Secure code
app.get(''/user/:id'', authenticateUser, (req, res) => {
  const userId = req.params.id;
  const currentUser = req.user;
  
  // Check if user can access this resource
  if (userId !== currentUser.id && !currentUser.isAdmin) {
    return res.status(403).json({ error: ''Access denied'' });
  }
  
  const user = getUserById(userId);
  res.json(user);
});'
),
(
  'broken-authentication',
  'Broken Authentication',
  'Broken Authentication vulnerabilities occur when authentication mechanisms are implemented incorrectly, allowing attackers to compromise passwords, keys, or session tokens, or exploit other implementation flaws to assume other users'' identities.',
  'In 2012, LinkedIn suffered a data breach where over 6.5 million user passwords were stolen. The passwords were stored using unsalted SHA-1 hashes, making them vulnerable to rainbow table attacks and easy to crack.',
  '1. Implement multi-factor authentication (MFA)
2. Use strong password policies and complexity requirements
3. Implement account lockout mechanisms
4. Use secure session management
5. Hash passwords with strong, salted algorithms (bcrypt, Argon2)
6. Implement proper logout functionality
7. Use HTTPS for all authentication-related communications
8. Regularly rotate session tokens',
  '// Vulnerable password storage
const password = req.body.password;
const hashedPassword = md5(password); // Weak hashing

// Secure password storage
const bcrypt = require(''bcrypt'');
const saltRounds = 12;
const password = req.body.password;
const hashedPassword = await bcrypt.hash(password, saltRounds);

// Secure password verification
const isValid = await bcrypt.compare(password, hashedPassword);'
)
ON CONFLICT (slug) DO NOTHING;
