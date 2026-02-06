import sqlite3
import re

# Read transcript
with open('transcript-full.txt', 'r') as f:
    transcript = f.read()

# Split by pages
pages = re.split(r'--- PAGE (\d+) ---', transcript)
page_content = {}
for i in range(1, len(pages), 2):
    page_num = int(pages[i])
    content = pages[i+1] if i+1 < len(pages) else ""
    page_content[page_num] = content

def find_page_for_text(search_text, speaker_name=None):
    """Find which page contains text closest to search_text"""
    search_lower = search_text[:100].lower()  # First 100 chars
    for page_num in sorted(page_content.keys()):
        content = page_content[page_num].lower()
        # Check if key phrases appear
        if any(phrase in content for phrase in search_lower.split()[:5]):
            return page_num
    return None

# Connect to DB
conn = sqlite3.connect('nj_legislation.db')
cursor = conn.cursor()

# Add page_reference column if not exists
try:
    cursor.execute("ALTER TABLE scientific_claims ADD COLUMN page_reference INTEGER")
except:
    pass

# Key phrase to page mapping based on manual transcript review
claim_pages = {
    "9.2 billion tons": 10,
    "400 million tons": 10,
    "Microplastics found in Raritan": 7,
    "Indoor air can have": 7,
    "Collaborative study with Columbia": 8,
    "Nanoplastics in bottled water not derived": 8,
    "Tea bags and hot container cups": 8,
    "Microplastics identified in human lung": 9,
    "Hawaii placenta samples": 9,
    "Nanoplastics identified in placenta and fetal": 9,
    "Particles persist in offspring": 9,
    "Microplastics in fecal matter": 10,
    "New England Journal of Medicine": 10,
    "Less than 10%": 33,
    "In 1950, 2 million tons": 33,
    "Microplastics in carotid plaque": 35,
    "By 2030, for every 3 pounds": 36,
    "NJ exports second-most": 43,
    "Chemical recycling handles only": 37,
    "Bottle bill states: aluminum": 40,
    "Bottle bill states: glass": 40,
    "Bottle bill states: PET": 40,
    "Plastics have 16,000": 33,
    "More than 15,000 chemicals": 53,
    "National Toxicology Program": 55,
    "Personal research demonstrated Phthalate": 56,
    "Research influenced Consumer Protection": 56,
    "Worldwide sperm counts": 58,
    "2023 update": 58,
    "Total fertility rate": 58,
    "Number of endangered species": 59,
    "South Korea fertility": 59,
    "California study: 28-day": 59,
    "California Prop 65": 55,
    "NJ recovered 113,000": 14,
    "75% overall container": 14,
    "Average 133,000 tons": 14,
    "1.67 metric tons CO2": 14,
    "For every pound of recycled": 14,
    "NJ has 23 MRFs": 15,
    "Average disposal cost": 15,
    "Approximately 10% residue": 29,
}

# Update claims with page references
for key_phrase, page_num in claim_pages.items():
    cursor.execute("""
        UPDATE scientific_claims 
        SET page_reference = ? 
        WHERE claim_text LIKE ?
    """, (page_num, f"%{key_phrase}%"))

conn.commit()

# Verify
cursor.execute("SELECT COUNT(*) FROM scientific_claims WHERE page_reference IS NOT NULL")
updated = cursor.fetchone()[0]
print(f"Updated {updated} claims with page references")

conn.close()
