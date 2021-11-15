devtools::install_github("OHDSI/ETL-Synthea")
library(ETLSyntheaBuilder)

devtools::install_github("OHDSI/CommonDataModel", "v5.4")

 # We are loading a version 5.4 CDM into a local PostgreSQL database called "synthea10".
 # The ETLSyntheaBuilder package leverages the OHDSI/CommonDataModel package for CDM creation.
 # Valid CDM versions are determined by executing CommonDataModel::listSupportedVersions().
 # The strings representing supported CDM versions are currently "5.3" and "5.4". 
 # The Synthea version we use in this example is 2.7.0.  Since Synthea's MASTER branch is always active, we currently
 # only support version 2.7.0.
 # The schema to load the Synthea tables is called "native".
 # The schema to load the Vocabulary and CDM tables is "cdm_synthea10".  
 # The username and pw are "postgres" and "lollipop".
 # The Synthea and Vocabulary CSV files are located in /tmp/synthea/output/csv and /tmp/Vocabulary_20181119, respectively.
 
 # For those interested in seeing the CDM changes from 5.3 to 5.4, please see: http://ohdsi.github.io/CommonDataModel/cdm54Changes.html
 
cd <- DatabaseConnector::createConnectionDetails(
  dbms     = "postgresql", 
  server   = "172.23.0.2/synthea10", 
  pathToDriver = "/tmp/",
  user     = "postgres", 
  password = "lollipop", 
  port     = 5432
)

cdmSchema      <- "cdm_synthea10"
cdmVersion     <- "5.4"
syntheaVersion <- "2.7.0"
syntheaSchema  <- "native"
syntheaFileLoc <- "/tmp/output/csv"
vocabFileLoc   <- "/tmp/Vocabulary_restricted"

ETLSyntheaBuilder::CreateCDMTables(connectionDetails = cd, cdmSchema = cdmSchema, cdmVersion = cdmVersion)
                                     
ETLSyntheaBuilder::CreateSyntheaTables(connectionDetails = cd, syntheaSchema = syntheaSchema, syntheaVersion = syntheaVersion)
                                       
ETLSyntheaBuilder::LoadSyntheaTables(connectionDetails = cd, syntheaSchema = syntheaSchema, syntheaFileLoc = syntheaFileLoc)
                                     
ETLSyntheaBuilder::LoadVocabFromCsv(connectionDetails = cd, cdmSchema = cdmSchema, vocabFileLoc = vocabFileLoc)
                                    
ETLSyntheaBuilder::LoadEventTables(connectionDetails = cd, cdmSchema = cdmSchema, syntheaSchema = syntheaSchema, cdmVersion = cdmVersion, syntheaVersion = syntheaVersion)


