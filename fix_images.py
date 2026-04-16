import os

replacements = {
    "1542314831-c5a4d4071b5e": "1566073771259-6a8506099945",
    "1551280857-2b9bbe52ccbd": "1553531384-cc64ac80f931",
    "1544155452-789dedb62da0": "1507003211169-0a1dd7228f2d",
    "1596700676648-fb2ce57faeab": "1582236306899-7243c3b52f36",
    "1583417316315-d72b226065ea": "1528127269322-539801943592",
    "1544642878-a0066aa489ac": "1533050487297-09b450131914",
    "1499244571948-7cc805840dbf": "1528127269322-539801943592"
}

def process_directory(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
                
                changed = False
                for bad_id, good_id in replacements.items():
                    if bad_id in content:
                        content = content.replace(bad_id, good_id)
                        changed = True
                
                if changed:
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(content)
                    print(f"Updated {path}")

process_directory("lib/features")
