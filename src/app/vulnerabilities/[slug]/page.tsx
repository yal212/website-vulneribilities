import { notFound } from 'next/navigation'
import { supabase } from '@/lib/supabase'
import { Vulnerability, VulnerabilityPageProps } from '@/types/vulnerability'
import VulnerabilityDetail from '@/components/VulnerabilityDetail'

async function getVulnerability(slug: string): Promise<Vulnerability | null> {
  const { data, error } = await supabase
    .from('vulnerabilities')
    .select('*')
    .eq('slug', slug)
    .single()

  if (error || !data) {
    return null
  }

  return data
}

export async function generateStaticParams() {
  const { data: vulnerabilities } = await supabase
    .from('vulnerabilities')
    .select('slug')

  return vulnerabilities?.map((vulnerability) => ({
    slug: vulnerability.slug,
  })) || []
}

export async function generateMetadata({ params }: VulnerabilityPageProps) {
  const { slug } = await params
  const vulnerability = await getVulnerability(slug)

  if (!vulnerability) {
    return {
      title: 'Vulnerability Not Found',
    }
  }

  return {
    title: `${vulnerability.name} | Cybersecurity Vulnerabilities`,
    description: vulnerability.description.substring(0, 160),
  }
}

export default async function VulnerabilityPage({ params }: VulnerabilityPageProps) {
  const { slug } = await params
  const vulnerability = await getVulnerability(slug)

  if (!vulnerability) {
    notFound()
  }

  return <VulnerabilityDetail vulnerability={vulnerability} />
}
