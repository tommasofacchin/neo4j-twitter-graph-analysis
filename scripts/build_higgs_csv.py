from pathlib import Path
import csv

BASE_DIR = Path(__file__).resolve().parent.parent
RAW_DIR = BASE_DIR / "data" / "raw"
PROCESSED_DIR = BASE_DIR / "data" / "processed"

PROCESSED_DIR.mkdir(parents=True, exist_ok=True)

FILES = {
    "social": RAW_DIR / "higgs-social_network.edgelist",
    "retweet": RAW_DIR / "higgs-retweet_network.edgelist",
    "reply": RAW_DIR / "higgs-reply_network.edgelist",
    "mention": RAW_DIR / "higgs-mention_network.edgelist",
}

# Parse a dataset edge line and return source, target and optional weight.
def parse_edge_line(line: str):
    parts = line.strip().split()
    if len(parts) < 2:
        return None

    source_id = parts[0]
    target_id = parts[1]
    weight = parts[2] if len(parts) >= 3 else None

    return source_id, target_id, weight


# Read an edge list file, skipping comments and invalid lines.
def read_edges(file_path: Path):
    if not file_path.exists():
        raise FileNotFoundError(f"Missing input file: {file_path}")

    with file_path.open("r", encoding="utf-8") as f:
        for line in f:
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                continue

            parsed = parse_edge_line(stripped)
            if parsed is not None:
                yield parsed

# Collect unique users from all relationship files and write the corresponding CSVs.
def collect_users_and_write_relationships():
    users = set()
    stats = {}

    relationship_configs = {
        "social": ("follows.csv", ["sourceId", "targetId"]),
        "retweet": ("retweets.csv", ["sourceId", "targetId", "weight"]),
        "reply": ("replies.csv", ["sourceId", "targetId", "weight"]),
        "mention": ("mentions.csv", ["sourceId", "targetId", "weight"]),
    }

    for key, input_file in FILES.items():
        output_name, headers = relationship_configs[key]
        output_file = PROCESSED_DIR / output_name
        row_count = 0

        with output_file.open("w", newline="", encoding="utf-8") as f_out:
            writer = csv.writer(f_out)
            writer.writerow(headers)

            for source_id, target_id, weight in read_edges(input_file):
                users.add(source_id)
                users.add(target_id)

                if "weight" in headers:
                    writer.writerow([source_id, target_id, weight if weight is not None else ""])
                else:
                    writer.writerow([source_id, target_id])

                row_count += 1

        stats[output_name] = row_count

    return users, stats

# Write the unique user IDs to users.csv.
def write_users_csv(users):
    output_file = PROCESSED_DIR / "users.csv"

    with output_file.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["userId"])

        for user_id in sorted(users, key=lambda x: int(x)):
            writer.writerow([user_id])

    return len(users)


def main():
    print("Building processed CSV files from Higgs raw dataset...")
    print(f"Raw directory: {RAW_DIR}")
    print(f"Processed directory: {PROCESSED_DIR}")

    users, relationship_stats = collect_users_and_write_relationships()
    user_count = write_users_csv(users)

    print("\nDone.")
    print(f"Users written: {user_count}")

    for file_name, count in relationship_stats.items():
        print(f"{file_name}: {count} rows")

    print("\nGenerated files:")
    for path in sorted(PROCESSED_DIR.glob("*.csv")):
        print(f"- {path.relative_to(BASE_DIR)}")


if __name__ == "__main__":
    main()