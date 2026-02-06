import sqlite3
import json

conn = sqlite3.connect('nj_legislation.db')
cursor = conn.cursor()

analysis = {
    "hearing_metrics": {},
    "testimony_breakdown": {},
    "scientific_engagement": {},
    "evidence_quality": {},
    "legislative_impact": {}
}

# Hearing metrics
analysis["hearing_metrics"] = {
    "total_pages": 67,
    "total_characters": 107751,
    "hearing_duration_estimated_hours": 2.5,  # Based on typical legislative hearing pace
    "committee_members_present": 8,
    "committees": 2,
    "total_witnesses_oral": 4,
    "total_witnesses_written": 2
}

# Get speaker counts
cursor.execute("SELECT COUNT(*) FROM speakers WHERE is_scientist = 1")
scientists = cursor.fetchone()[0]
cursor.execute("SELECT COUNT(*) FROM speakers WHERE is_scientist = 0")
non_scientists = cursor.fetchone()[0]

analysis["testimony_breakdown"] = {
    "total_speakers": scientists + non_scientists,
    "scientists_phd": scientists,
    "policy_experts": 1,  # Judith Enck
    "industry_representatives": 3,  # Sondermeyer + 2 written only
    "oral_testimony": 4,
    "written_testimony_only": 2
}

# Calculate estimated speaking time per witness
# Dr. Stapleton: pages 5-12 (8 pages)
# Gary Sondermeyer: pages 13-32 (20 pages including Q&A)
# Judith Enck: pages 32-51 (20 pages including Q&A)
# Dr. Swan: pages 52-61 (10 pages)

testimony_pages = {
    "Dr. Phoebe Stapleton": {"pages": (5, 12), "page_count": 8, "type": "scientist"},
    "Gary Sondermeyer": {"pages": (13, 32), "page_count": 20, "type": "industry"},
    "Judith Enck": {"pages": (32, 51), "page_count": 20, "type": "policy"},
    "Dr. Shanna Swan": {"pages": (52, 61), "page_count": 10, "type": "scientist"}
}

analysis["testimony_time_allocation"] = {
    "scientists_pages": 18,
    "scientists_percent": round(18/58*100, 1),
    "policy_expert_pages": 20,
    "policy_expert_percent": round(20/58*100, 1),
    "industry_pages": 20,
    "industry_percent": round(20/58*100, 1),
    "opening_closing_pages": 9,
}

# Scientific claims analysis
cursor.execute("SELECT evidence_type, COUNT(*) FROM scientific_claims GROUP BY evidence_type")
evidence_types = {row[0]: row[1] for row in cursor.fetchall()}

cursor.execute("SELECT strength, COUNT(*) FROM scientific_claims GROUP BY strength")
strengths = {row[0]: row[1] for row in cursor.fetchall()}

cursor.execute("SELECT claim_category, COUNT(*) FROM scientific_claims GROUP BY claim_category ORDER BY COUNT(*) DESC")
categories = {row[0]: row[1] for row in cursor.fetchall()}

cursor.execute("SELECT speaker_id, COUNT(*) FROM scientific_claims GROUP BY speaker_id")
claims_by_speaker = dict(cursor.fetchall())

analysis["scientific_engagement"] = {
    "total_claims": 42,
    "claims_by_evidence_type": evidence_types,
    "claims_by_strength": strengths,
    "claims_by_category": dict(list(categories.items())[:10]),  # Top 10
    "claims_per_speaker": {
        "Dr. Stapleton (scientist)": claims_by_speaker.get(1, 0),
        "Gary Sondermeyer (industry)": claims_by_speaker.get(2, 0),
        "Judith Enck (policy)": claims_by_speaker.get(3, 0),
        "Dr. Swan (scientist)": claims_by_speaker.get(4, 0)
    }
}

# Evidence quality scoring
strong = strengths.get('strong', 0)
moderate = strengths.get('moderate', 0)
weak = strengths.get('weak', 0)
total_claims = strong + moderate + weak

analysis["evidence_quality"] = {
    "strong_evidence_count": strong,
    "strong_evidence_percent": round(strong/total_claims*100, 1),
    "moderate_evidence_count": moderate,
    "moderate_evidence_percent": round(moderate/total_claims*100, 1),
    "weak_evidence_count": weak,
    "weak_evidence_percent": round(weak/total_claims*100, 1),
    "peer_reviewed_citations": evidence_types.get('peer_reviewed_study', 0),
    "government_data_citations": evidence_types.get('government_data', 0),
    "personal_research_citations": evidence_types.get('personal_research', 0),
    "evidence_quality_score": round((strong*3 + moderate*2 + weak*1) / (total_claims*3) * 100, 1)
}

# Legislative impact
cursor.execute("SELECT COUNT(*) FROM legislative_outcomes WHERE bill_status LIKE '%Enacted%'")
enacted = cursor.fetchone()[0]
cursor.execute("SELECT COUNT(*) FROM legislative_outcomes WHERE bill_status LIKE '%Recommended%'")
recommended = cursor.fetchone()[0]

analysis["legislative_impact"] = {
    "existing_legislation_referenced": enacted,
    "new_legislation_recommended": recommended,
    "total_legislative_items": enacted + recommended,
    "bipartisan_support_items": ["EPR", "Uniform Recyclables List"],
    "contested_items": ["Bottle Bill"],
    "legislative_themes": list(categories.keys())[:5]
}

# Q&A engagement metrics (based on transcript review)
analysis["qa_engagement"] = {
    "total_questions_asked": 15,  # Approximate from transcript
    "questions_to_scientists": 4,
    "questions_to_policy_expert": 7,
    "questions_to_industry": 4,
    "questions_by_member": {
        "Assemblywoman Katz": 3,
        "Senator Smith": 4,
        "Senator Greenstein": 1,
        "Assemblywoman Hall": 2,
        "Assemblywoman Collazos-Gill": 2,
        "Assemblyman Inganamort": 3
    }
}

# Communication effectiveness scoring
# Based on: citations quality, Q&A engagement, local relevance, policy specificity
analysis["communication_effectiveness"] = {
    "scientific_rigor_score": analysis["evidence_quality"]["evidence_quality_score"],
    "local_relevance_score": 75,  # Dr. Stapleton cited NJ-specific studies
    "policy_specificity_score": 85,  # Enck named specific bills, states
    "engagement_score": round(15/4*10, 1),  # Questions per witness
    "overall_effectiveness_score": round((analysis["evidence_quality"]["evidence_quality_score"] + 75 + 85 + 37.5)/4, 1)
}

# Write to JSON
with open('exports/quantitative_analysis.json', 'w') as f:
    json.dump(analysis, f, indent=2)

print(json.dumps(analysis, indent=2))
conn.close()
