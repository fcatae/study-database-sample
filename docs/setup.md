Setup
======

## First steps

Install Azure CLI 2.0

* Download: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

Login to Azure

    az login

List the Subscription Accounts and set the active account

    az account list
    az account set

Configure defaults for Location

    az configure --defaults location=<region>

Create a Resource Group

    az group create --name <sqllab>

Check the current Resource Groups and Resources

    az group list
    az resource list --resource-group <sqllab>


## Create a SQL Server

Configure the default Resource Group

    az configure --defaults group=<sqllab>

Create SQL Azure Database (Logical Server)

    az sql server create -n <servername> -g <rgname> -u <user> -p <password>

Define the firewall policy

    az sql server firewall-rule --name <rule_name> --server <servername> --start-ip-address <start_ip> --end-ip-address <end_ip>

* Notice that `0.0.0.0` represents the internal Azure network

Check the firewall policy

    az sql server firewall-rule --server <server_name>

## Create an Elastic Pool

    az sql elastic-pool create --name <elastic_name> --server <server_name> --edition Standard
    
The DTU can be updated:

    az sql elastic-pool update -n <elastic_name> -s <server_name> --dtu 100 



## Create databases

Syntax:

    CREATE DATABASE <database_name>

Create new database
```sql
CREATE DATABASE DB01
( SERVICE_OBJECTIVE='P1' )
```

Create database in an Elastic Pool

```sql
CREATE DATABASE DB02
( SERVICE_OBJECTIVE = ELASTIC_POOL(NAME=[DBS]) )
```

Later the database tier can be modified

```sql
ALTER DATABASE DB01
  MODIFY ( SERVICE_OBJECTIVE = ELASTIC_POOL(NAME=[DBS]) )
```

## Resource monitoring

```sql
SELECT * FROM sys.elastic_pool_resource_stats
SELECT * FROM sys.resource_stats
```

