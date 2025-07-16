'use client'

import { motion } from 'framer-motion'
import Link from 'next/link'
import { useScrollAnimation, scrollAnimationVariants } from '@/hooks/useScrollAnimation'

const vulnerabilities = [
  {
    slug: 'sql-injection',
    name: 'SQL Injection',
    description: 'Learn about SQL injection attacks and how to prevent them',
    icon: '💉',
    severity: 'Critical',
    color: 'from-red-500 to-red-700'
  },
  {
    slug: 'cross-site-scripting',
    name: 'Cross-Site Scripting (XSS)',
    description: 'Understand XSS vulnerabilities and protection methods',
    icon: '🔗',
    severity: 'High',
    color: 'from-orange-500 to-orange-700'
  },
  {
    slug: 'cross-site-request-forgery',
    name: 'Cross-Site Request Forgery (CSRF)',
    description: 'Explore CSRF attacks and defensive techniques',
    icon: '🎭',
    severity: 'Medium',
    color: 'from-yellow-500 to-yellow-700'
  },
  {
    slug: 'insecure-direct-object-reference',
    name: 'Insecure Direct Object Reference (IDOR)',
    description: 'Discover IDOR vulnerabilities and access control issues',
    icon: '🔓',
    severity: 'High',
    color: 'from-purple-500 to-purple-700'
  },
  {
    slug: 'broken-authentication',
    name: 'Broken Authentication',
    description: 'Learn about authentication flaws and secure practices',
    icon: '🔐',
    severity: 'Critical',
    color: 'from-pink-500 to-pink-700'
  }
]

const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1
    }
  }
}

const itemVariants = {
  hidden: { opacity: 0, y: 20 },
  visible: {
    opacity: 1,
    y: 0
  }
}

export default function HomePage() {
  const heroAnimation = useScrollAnimation()
  const cardsAnimation = useScrollAnimation()

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      {/* Hero Section */}
      <motion.section
        ref={heroAnimation.ref}
        className="relative overflow-hidden py-20 px-4"
        variants={scrollAnimationVariants}
        initial="hidden"
        animate={heroAnimation.controls}
        transition={{ duration: 0.8, ease: "easeOut" }}
      >
        <div className="container mx-auto text-center">
          <motion.div
            className="mb-8"
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.6, delay: 0.2 }}
          >
            <h1 className="text-5xl md:text-7xl font-bold text-white mb-6">
              <span className="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
                Cyber Security
              </span>
              <br />
              Vulnerabilities
            </h1>
            <p className="text-xl md:text-2xl text-gray-300 max-w-3xl mx-auto leading-relaxed">
              Explore common web application vulnerabilities, understand their impact, 
              and learn how to protect your applications from security threats.
            </p>
          </motion.div>

          <motion.div
            className="flex justify-center"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.4 }}
          >
            <div className="w-32 h-1 bg-gradient-to-r from-purple-400 to-pink-400 rounded-full"></div>
          </motion.div>
        </div>

        {/* Animated background elements */}
        <div className="absolute inset-0 overflow-hidden pointer-events-none">
          <motion.div
            className="absolute top-1/4 left-1/4 w-64 h-64 bg-purple-500/10 rounded-full blur-3xl"
            animate={{
              x: [0, 100, 0],
              y: [0, -50, 0],
            }}
            transition={{
              duration: 20,
              repeat: Infinity,
              ease: "linear"
            }}
          />
          <motion.div
            className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-pink-500/10 rounded-full blur-3xl"
            animate={{
              x: [0, -100, 0],
              y: [0, 50, 0],
            }}
            transition={{
              duration: 25,
              repeat: Infinity,
              ease: "linear"
            }}
          />
        </div>
      </motion.section>

      {/* Vulnerabilities Grid */}
      <motion.section
        ref={cardsAnimation.ref}
        className="py-20 px-4"
        variants={scrollAnimationVariants}
        initial="hidden"
        animate={cardsAnimation.controls}
        transition={{ duration: 0.6, delay: 0.2 }}
      >
        <div className="container mx-auto">
          <motion.div
            className="text-center mb-16"
            variants={itemVariants}
            transition={{ duration: 0.5, ease: "easeOut" }}
          >
            <h2 className="text-4xl font-bold text-white mb-4">
              Common Vulnerabilities
            </h2>
            <p className="text-gray-400 text-lg max-w-2xl mx-auto">
              Click on any vulnerability below to learn about its mechanics, real-world examples, 
              and prevention strategies.
            </p>
          </motion.div>

          <motion.div
            className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 max-w-6xl mx-auto"
            variants={containerVariants}
            initial="hidden"
            animate="visible"
          >
            {vulnerabilities.map((vulnerability) => (
              <motion.div
                key={vulnerability.slug}
                variants={itemVariants}
                transition={{ duration: 0.5, ease: "easeOut" }}
                whileHover={{
                  scale: 1.05,
                  transition: { duration: 0.2 }
                }}
                whileTap={{ scale: 0.95 }}
              >
                <Link href={`/vulnerabilities/${vulnerability.slug}`}>
                  <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20 hover:border-white/40 transition-all duration-300 cursor-pointer group h-full">
                    <div className="flex items-center justify-between mb-4">
                      <span className="text-4xl">{vulnerability.icon}</span>
                      <span className={`px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r ${vulnerability.color} text-white`}>
                        {vulnerability.severity}
                      </span>
                    </div>
                    
                    <h3 className="text-xl font-bold text-white mb-3 group-hover:text-purple-300 transition-colors">
                      {vulnerability.name}
                    </h3>
                    
                    <p className="text-gray-400 leading-relaxed mb-4">
                      {vulnerability.description}
                    </p>
                    
                    <div className="flex items-center text-purple-400 font-medium group-hover:text-purple-300 transition-colors">
                      Learn More
                      <svg 
                        className="w-4 h-4 ml-2 transform group-hover:translate-x-1 transition-transform" 
                        fill="none" 
                        stroke="currentColor" 
                        viewBox="0 0 24 24"
                      >
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                      </svg>
                    </div>
                  </div>
                </Link>
              </motion.div>
            ))}
          </motion.div>
        </div>
      </motion.section>

      {/* Footer */}
      <footer className="py-12 px-4 border-t border-white/10">
        <div className="container mx-auto text-center">
          <p className="text-gray-400">
            Built with Next.js 15, TypeScript, Tailwind CSS, and Framer Motion
          </p>
          <p className="text-gray-500 text-sm mt-2">
            Educational content for cybersecurity awareness
          </p>
        </div>
      </footer>
    </div>
  )
}
