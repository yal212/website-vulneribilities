import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export type Database = {
  public: {
    Tables: {
      vulnerabilities: {
        Row: {
          id: string
          slug: string
          name: string
          description: string
          real_life_example: string
          prevention_methods: string
          code_snippet?: string
          image_url?: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          slug: string
          name: string
          description: string
          real_life_example: string
          prevention_methods: string
          code_snippet?: string
          image_url?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          slug?: string
          name?: string
          description?: string
          real_life_example?: string
          prevention_methods?: string
          code_snippet?: string
          image_url?: string
          created_at?: string
          updated_at?: string
        }
      }
    }
  }
}
