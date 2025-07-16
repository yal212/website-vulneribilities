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
