# BulkLoadData
Bulk Upload to Dataverse: Automating dataset uploads with metadata and files. 

There is a required folder structure such as files.zip and metadata.json for each dataset. 

Documents\
├── bulkloaddata.ps1           ← The PowerShell script
└── Datasets\                  ← Folder containing all datasets
    ├── Dataset1\
    │   ├── metadata.json      ← Required: Dataset description
    │   └── files.zip          ← Required: Data files (any files zipped)
    ├── Dataset2\
    │   ├── metadata.json
    │   └── files.zip
    └── ...

Script Location: \\utl.utoronto.ca\Staff2025\Data\cevikzey\Documents\bulkloaddata.ps1
Datasets Folder: \\utl.utoronto.ca\Staff2025\Data\cevikzey\Documents\Datasets\

⚠️ Datasets are uploaded as DRAFTS - they need to be manually published in Dataverse
⚠️ File naming must be exact:
      •	metadata.json 
      •	files.zip 
⚠️ PowerShell works better than Git Bash for network drives on Windows
