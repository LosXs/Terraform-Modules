locals {
  # Single source of truth for Azure Policy "Required Tags" allowed values (update here when policy changes).
  allowed_business_units = [
    "AVM Team",
    "B2C",
    "Clients",
    "Customer Care",
    "Data (MI)",
    "Field Operations",
    "Field Operations B2C",
    "Field Operations Central Operations",
    "IT",
    "Procurement",
    "Risk & Audit",
  ]

  allowed_environments = [
    "Production",
    "Staging",
    "Test",
    "Development",
    "Disaster Recovery",
  ]

  allowed_services = [
    "Shared Services",
    "AD Management",
    "Affiliates",
    "Audit",
    "Autopilot",
    "AVM",
    "Azure Workstations",
    "Backup",
    "Certificate Services",
    "Cladding",
    "Cloudflare",
    "Cognos",
    "Complaints",
    "Compute Gateway",
    "CRM",
    "EDR",
    "Equipment Portal",
    "Fees",
    "File Repo",
    "Firewall",
    "FOS",
    "FTP",
    "HB terms",
    "Infrastructure Workstations",
    "KEP",
    "KMS",
    "M2L Discrepency",
    "MI Data Gateway",
    "MI System",
    "Monitoring",
    "NBCM",
    "Non-Trad API",
    "PAL",
    "PAM",
    "Patch Management",
    "Print Services",
    "Quest",
    "Risk Server",
    "RPA",
    "SIEM",
    "Surveyor Workstations",
    "Testing Automation",
    "Vulnerability Scanning",
    "WFS Terms",
  ]

  allowed_service_support_teams = [
    "IT",
    "AVM Team",
    "Business Solutions",
    "Data Connect",
    "Data (MI)",
  ]

  allowed_criticalities = [
    "Critical",
    "Important",
    "Low",
  ]

  allowed_exposures = [
    "Internal",
    "External",
    "Public",
  ]
}
