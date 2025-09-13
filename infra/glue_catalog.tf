# Arquivo: glue_catalog.tf

# 1. Recurso para o S3 Bucket que armazenará os dados
resource "aws_s3_bucket" "data_bucket" {
  bucket = var.data_bucket_name

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

# 2. Recurso para o banco de dados do Glue Data Catalog
# O Athena precisa de um banco de dados para organizar as tabelas.
resource "aws_glue_catalog_database" "data_database" {
  name = "${var.project_name}-${var.environment}-db"
}

# 3. Recurso para a tabela do Glue Data Catalog (que será usada pelo Athena)
# Este recurso aponta para o bucket S3 que acabamos de criar.
resource "aws_glue_catalog_table" "data_table" {
  name          = "portos_data_catalog"
  database_name = aws_glue_catalog_database.data_database.name
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    # Referencia o bucket S3 criado acima
    location      = "s3://${aws_s3_bucket.data_bucket.bucket}/spec_portos/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns {
      name = "nome_porto"
      type = "string"
    }
    columns {
      name = "tipo_porto"
      type = "string"
    }
    columns {
      name = "uf"
      type = "string"
    }
    columns {
      name = "regiao"
      type = "string"
    }
    columns {
      name = "data_registro"
      type = "string"
    }
    columns {
      name = "hora_registro"
      type = "string"
    }
    columns {
      name = "status_operacao"
      type = "string"
    }
    columns {
      name = "status_via_acesso"
      type = "string"
    }
    columns {
      name = "nivel_criticidade"
      type = "float"
    }
    columns {
      name = "data_inicio_situacao"
      type = "string"
    }
    columns {
      name = "hora_inicio_situacao"
      type = "string"
    }
    columns {
      name = "duracao_situacao"
      type = "int"
    }
    columns {
      name = "data_termino_situacao"
      type = "string"
    }
    columns {
      name = "hora_termino_situacao"
      type = "string"
    }
    columns {
      name = "fonte_informacao"
      type = "string"
    }
    columns {
      name = "situacao_atual"
      type = "string"
    }
  }

  partition_keys {
    name = "ano"
    type = "string"
  }
  partition_keys {
    name = "mes"
    type = "string"
  }
  partition_keys {
    name = "dia"
    type = "string"
  }
}