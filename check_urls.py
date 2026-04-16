import urllib.request
import re
import os

candidate_ids = [
    "1540611025311-01df3cef54b5", # Valid
    "1528127269322-539801943592", # Ha Long? Let's check
    "1533050487297-09b450131914", 
    "1553531384-cc64ac80f931",
    "1507003211169-0a1dd7228f2d",
    "1476514525535-07fb3b4ae5f1",
    "1555881400-74d7acaacd8b",
    "1506905925346-21bda4d32df4",
    "1516035069371-29a1b244cc32",
    "1524661135-423995f22d0b"
]

valid_ids = []
for cid in candidate_ids:
    url = f"https://images.unsplash.com/photo-{cid}?w=500"
    try:
        req = urllib.request.Request(url, method='HEAD')
        resp = urllib.request.urlopen(req, timeout=3)
        if resp.status == 200:
            valid_ids.append(cid)
            print(f"Valid: {cid}")
    except Exception as e:
        print(f"Invalid {cid}: {e}")

if len(valid_ids) == 0:
    print("NO VALID IDS!")
    exit(1)

# Now scan lib folder and replace all unsplash URLs
unsplash_pattern = re.compile(r'https://images.unsplash.com/photo-[a-zA-Z0-9-]+\?[^\"\']+')
total_replaced = 0

for root, _, files in os.walk("lib/features"):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()
            
            new_content = content
            matches = unsplash_pattern.findall(content)
            changed = False
            
            for i, match in enumerate(matches):
                # Pick a valid ID round-robin
                vid = valid_ids[i % len(valid_ids)]
                good_url = f"https://images.unsplash.com/photo-{vid}?w=800"
                new_content = new_content.replace(match, good_url)
                changed = True
            
            if changed:
                with open(path, "w", encoding="utf-8") as f:
                    f.write(new_content)
                total_replaced += len(matches)
                print(f"Patched {path}")

print(f"Total replaced: {total_replaced}")
