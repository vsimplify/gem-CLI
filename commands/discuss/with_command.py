import os

def run(identifier):
    print(f"Searching for artifacts matching: {identifier}")
    # Placeholder for actual artifact search and context loading logic
    print("Initiating context-aware discussion session...")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        run(sys.argv[1])
    else:
        print("Usage: python with_command.py <identifier>")
