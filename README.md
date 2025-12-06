# BulkLoadData

# Borealis Bulk Dataset Uploader

This Bash script automates the creation of datasets and the upload of associated files to a **Borealis Dataverse** instance. It processes multiple local directories, reads dataset metadata, creates datasets via the Borealis API, and uploads the corresponding ZIP file for each dataset.

---

## Features

- Automatically reads metadata from `metadata.json` in each dataset folder.
- Removes the `files` section from the JSON before dataset creation.
- Creates a new dataset in the specified Dataverse.
- Uploads a `files.zip` archive associated with each dataset.
- Extracts and displays the DOI of the created dataset.
- Skips file upload if dataset creation fails.

---

## Prerequisites

- Bash shell
- [`jq`](https://stedolan.github.io/jq/) for JSON manipulation
- `curl` for API requests

**Install `jq` on Ubuntu/Debian:**
sudo apt update
sudo apt install jq 

**Install jq on macOS:**
brew install jq

---

## Usage

**1. Clone this repository:**

git clone https://github.com/YOUR_USERNAME/borealis-bulk-uploader.git
cd borealis-bulk-uploader

**2. Prepare your local directories:**
LOCAL_DIRECTORY/
├── Dataset1/
│   ├── metadata.json
│   └── files.zip
├── Dataset2/
│   ├── metadata.json
│   └── files.zip
└── ...

Each dataset folder must contain:
- metadata.json → Dataset metadata
- files.zip → ZIP archive of dataset files

**3. Update the script variables:**

API_TOKEN="YOUR_API_TOKEN"
HOSTNAME="https://demo.borealisdata.ca"
DATAVERSE_ALIAS="YOUR_DATAVERSE_ALIAS"
DIRECTORY="LOCAL_DIRECTORY"
WAIT=0

**4. Run the script:**
./bulkloaddata.sh

**5. Output:**
Dataset creation response
Extracted DOI
Upload status


---
### Alternative Usage (Easy way)

Copy and paste the Bash script into your terminal, after filling in your required information.

