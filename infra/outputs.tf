output "database_name" {
  description = "The name of the Glue Catalog database created by this module."
  value       = aws_glue_catalog_database.data_database.name
}

# Exporta o nome da tabela do Glue Data Catalog.
output "table_name" {
  description = "The name of the Glue Catalog table created by this module."
  value       = aws_glue_catalog_table.data_table.name
}