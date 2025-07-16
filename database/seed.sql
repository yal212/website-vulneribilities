-- Insert vulnerability data
INSERT INTO vulnerabilities (slug, name, description, real_life_example, prevention_methods, code_snippet) VALUES
(
  'sql-injection',
  'SQL Injection',
  'SQL injection is a code injection technique that exploits vulnerabilities in an application''s software when user input is not properly sanitized before being included in SQL queries. Attackers can manipulate SQL queries to access, modify, or delete data from the database.',
  'In 2008, Heartland Payment Systems suffered a massive data breach due to SQL injection attacks, resulting in the theft of over 130 million credit and debit card numbers. The attackers exploited SQL injection vulnerabilities in the company''s payment processing systems.',
  '1. Use parameterized queries or prepared statements\n2. Implement input validation and sanitization\n3. Use stored procedures with proper parameter handling\n4. Apply the principle of least privilege for database accounts\n5. Regularly update and patch database software\n6. Use web application firewalls (WAF)\n7. Conduct regular security audits and penetration testing',
  '-- Vulnerable code (PHP)\n$query = "SELECT * FROM users WHERE username = ''" . $_POST[''username''] . "'' AND password = ''" . $_POST[''password''] . "''";\n\n-- Secure code (PHP with prepared statements)\n$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND password = ?");\n$stmt->execute([$_POST[''username''], $_POST[''password'']]);'
),
(
  'cross-site-scripting',
  'Cross-Site Scripting (XSS)',
  'Cross-Site Scripting (XSS) is a security vulnerability that allows attackers to inject malicious scripts into web pages viewed by other users. These scripts can steal sensitive information, manipulate page content, or perform actions on behalf of the victim.',
  'In 2005, the Samy worm spread across MySpace through a stored XSS vulnerability. The worm automatically added the attacker as a friend and replicated itself on victims'' profiles, affecting over one million users within 20 hours.',
  '1. Encode output data before displaying it in HTML\n2. Validate and sanitize all user inputs\n3. Use Content Security Policy (CSP) headers\n4. Implement proper session management\n5. Use HTTPOnly and Secure flags for cookies\n6. Regularly update web frameworks and libraries\n7. Perform security code reviews',
  '<!-- Vulnerable code -->\n<div>Welcome, <?php echo $_GET[''name'']; ?>!</div>\n\n<!-- Secure code -->\n<div>Welcome, <?php echo htmlspecialchars($_GET[''name''], ENT_QUOTES, ''UTF-8''); ?>!</div>\n\n<!-- JavaScript secure encoding -->\nfunction escapeHtml(text) {\n  const div = document.createElement(''div'');\n  div.textContent = text;\n  return div.innerHTML;\n}'
),
(
  'cross-site-request-forgery',
  'Cross-Site Request Forgery (CSRF)',
  'Cross-Site Request Forgery (CSRF) is an attack that forces an end user to execute unwanted actions on a web application in which they are currently authenticated. Attackers can trick users into performing actions they did not intend to perform.',
  'In 2008, a CSRF vulnerability in Gmail allowed attackers to add email filters to victims'' accounts. By tricking users into visiting a malicious website while logged into Gmail, attackers could redirect emails to their own accounts.',
  '1. Implement CSRF tokens for state-changing operations\n2. Use SameSite cookie attributes\n3. Verify the Origin and Referer headers\n4. Implement proper session management\n5. Use double-submit cookies pattern\n6. Require re-authentication for sensitive actions\n7. Implement proper CORS policies',
  '<!-- Vulnerable form -->\n<form action="/transfer" method="POST">\n  <input name="amount" value="1000">\n  <input name="to_account" value="attacker_account">\n  <button type="submit">Transfer</button>\n</form>\n\n<!-- Secure form with CSRF token -->\n<form action="/transfer" method="POST">\n  <input type="hidden" name="csrf_token" value="<?php echo $_SESSION[''csrf_token'']; ?>">\n  <input name="amount" value="1000">\n  <input name="to_account" value="recipient_account">\n  <button type="submit">Transfer</button>\n</form>'
),
(
  'insecure-direct-object-reference',
  'Insecure Direct Object Reference (IDOR)',
  'Insecure Direct Object Reference (IDOR) occurs when an application provides direct access to objects based on user-supplied input. This vulnerability allows attackers to bypass authorization and access resources belonging to other users.',
  'In 2019, Facebook experienced an IDOR vulnerability that allowed users to view private photos of other users by manipulating photo IDs in URLs. This affected millions of users before being patched.',
  '1. Implement proper access controls and authorization checks\n2. Use indirect reference maps or random tokens\n3. Validate user permissions for each object access\n4. Implement session-based authorization\n5. Use UUIDs instead of sequential IDs\n6. Log and monitor access attempts\n7. Conduct regular security assessments',
  '// Vulnerable code\napp.get(''/user/:id'', (req, res) => {\n  const user = getUserById(req.params.id);\n  res.json(user);\n});\n\n// Secure code\napp.get(''/user/:id'', authenticateUser, (req, res) => {\n  const userId = req.params.id;\n  const currentUser = req.user;\n  \n  // Check if user can access this resource\n  if (userId !== currentUser.id && !currentUser.isAdmin) {\n    return res.status(403).json({ error: ''Access denied'' });\n  }\n  \n  const user = getUserById(userId);\n  res.json(user);\n});'
),
(
  'broken-authentication',
  'Broken Authentication',
  'Broken Authentication vulnerabilities occur when authentication mechanisms are implemented incorrectly, allowing attackers to compromise passwords, keys, or session tokens, or exploit other implementation flaws to assume other users'' identities.',
  'In 2012, LinkedIn suffered a data breach where over 6.5 million user passwords were stolen. The passwords were stored using unsalted SHA-1 hashes, making them vulnerable to rainbow table attacks and easy to crack.',
  '1. Implement multi-factor authentication (MFA)\n2. Use strong password policies and complexity requirements\n3. Implement account lockout mechanisms\n4. Use secure session management\n5. Hash passwords with strong, salted algorithms (bcrypt, Argon2)\n6. Implement proper logout functionality\n7. Use HTTPS for all authentication-related communications\n8. Regularly rotate session tokens',
  '// Vulnerable password storage\nconst password = req.body.password;\nconst hashedPassword = md5(password); // Weak hashing\n\n// Secure password storage\nconst bcrypt = require(''bcrypt'');\nconst saltRounds = 12;\nconst password = req.body.password;\nconst hashedPassword = await bcrypt.hash(password, saltRounds);\n\n// Secure password verification\nconst isValid = await bcrypt.compare(password, hashedPassword);'
)
