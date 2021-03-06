USE [master]
GO

CREATE DATABASE [DPR]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DPR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DPR.mdf' , SIZE = 102400KB , MAXSIZE = 2048000KB , FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'DPR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DPR_log.ldf' , SIZE = 51200KB , MAXSIZE = 102400KB , FILEGROWTH = 10240KB )
GO
ALTER DATABASE [DPR] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DPR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DPR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DPR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DPR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DPR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DPR] SET ARITHABORT OFF 
GO
ALTER DATABASE [DPR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DPR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DPR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DPR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DPR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DPR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DPR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DPR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DPR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DPR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DPR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DPR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DPR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DPR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DPR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DPR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DPR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DPR] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DPR] SET  MULTI_USER 
GO
ALTER DATABASE [DPR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DPR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DPR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DPR] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DPR] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DPR', N'ON'
GO
ALTER DATABASE [DPR] SET QUERY_STORE = OFF
GO
USE [DPR]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DPR]
GO
/****** Object:  Schema [common]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE SCHEMA [common]
GO
/****** Object:  Schema [dw]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE SCHEMA [dw]
GO
/****** Object:  Schema [log]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE SCHEMA [log]
GO
/****** Object:  Schema [mssql]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE SCHEMA [mssql]
GO
/****** Object:  Schema [staging]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE SCHEMA [staging]
GO
/****** Object:  Table [mssql].[Instance]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Instance](
	[InstanceID] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentID] [tinyint] NOT NULL,
	[DomainID] [tinyint] NULL,
	[PlatformID] [tinyint] NOT NULL,
	[ServerID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[instance_name] [nvarchar](128) NOT NULL,
	[description] [varchar](1024) NOT NULL,
	[alias] [varchar](8) NULL,
	[ip] [varchar](15) NOT NULL,
	[port] [int] NOT NULL,
	[cname] [varchar](128) NULL,
	[dpe_managed] [bit] NOT NULL,
	[service_account] [nvarchar](128) NOT NULL,
	[deactive_date] [datetime2](2) NULL,
	[is_nppi] [bit] NOT NULL,
	[override_version] [nvarchar](128) NULL,
 CONSTRAINT [PK_Instance_InstanceID] PRIMARY KEY CLUSTERED 
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[InstanceConfig]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[InstanceConfig](
	[InstanceConfigID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[edition] [nvarchar](128) NOT NULL,
	[version] [nvarchar](128) NOT NULL,
	[product_level] [nvarchar](128) NOT NULL,
	[bit_level] [int] NOT NULL,
	[language] [nvarchar](128) NOT NULL,
	[assigned_cpu] [int] NOT NULL,
	[assigned_ram] [int] NOT NULL,
	[root_directory] [nvarchar](128) NOT NULL,
	[collation] [nvarchar](128) NOT NULL,
	[is_clustered] [bit] NOT NULL,
	[is_hadr] [bit] NOT NULL,
	[is_xtp] [bit] NOT NULL,
	[default_data_path] [nvarchar](128) NOT NULL,
	[default_log_path] [nvarchar](128) NOT NULL,
	[default_backup_path] [nvarchar](128) NOT NULL,
	[default_tempdb_data_path] [nvarchar](128) NOT NULL,
	[default_tempdb_log_path] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_InstanceConfig_InstanceConfigID] PRIMARY KEY CLUSTERED 
(
	[InstanceConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_InstanceConfig]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







create view [mssql].[vw_InstanceConfig] with schemabinding as
select
	ic.[InstanceConfigID],
	ic.[InstanceID],
	ic.[load_date],
	ic.[eff_date],
	ic.[edition],
	ic.[version],
	ic.[product_level],
	ic.[bit_level],
	ic.[language],
	ic.[assigned_cpu],
	ic.[assigned_ram],
	ic.[root_directory],
	ic.[collation],
	ic.[is_clustered],
	ic.[is_hadr],
	ic.[is_xtp],
	ic.[default_data_path],
	ic.[default_log_path],
	ic.[default_backup_path],
	ic.[default_tempdb_data_path],
	ic.[default_tempdb_log_path]
from
	mssql.[InstanceConfig] [ic]
	inner join mssql.[Instance] [i] on ic.[InstanceID] = i.[InstanceID]
where
	ic.[eff_date] is not null ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_InstanceConfig_InstanceConfigID]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_InstanceConfig_InstanceConfigID] ON [mssql].[vw_InstanceConfig]
(
	[InstanceConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [common].[Environment]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Environment](
	[EnvironmentID] [tinyint] IDENTITY(1,1) NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[environment_name] [char](3) NOT NULL,
	[common_name] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Environment_EnvironmentID] PRIMARY KEY CLUSTERED 
(
	[EnvironmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_InstanceVersions]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [mssql].[vw_InstanceVersions] as
select
	e.[environment_name],
	i.[instance_name],
	[version] =
		'SQL Server ' +
		case
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 14 then '2017'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 13 then '2016'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 12 then '2014'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 11 then '2012'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 10.5 then	'2008 R2'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 10 then '2008'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 9 then '2005'
			when Convert(decimal(5,2), ParseName(Convert(varchar(16), ic.[version]), 4) + '.' + ParseName(Convert(varchar(16), ic.[version]), 3)) >= 8 then '2000'
			else 'Whaaaaaa?'
	end + ' ' +
	ic.[edition] + ' ' + ic.[product_level],
	[build] = ic.[version]
from
	mssql.[Instance] [i]
	inner join mssql.[vw_InstanceConfig] [ic] on i.[InstanceID] = ic.[InstanceID]
	inner join common.[Environment] [e] on i.[EnvironmentID] = e.[EnvironmentID]

GO
/****** Object:  Table [mssql].[Column]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Column](
	[ColumnID] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentID] [tinyint] NULL,
	[DomainID] [tinyint] NULL,
	[PlatformID] [tinyint] NULL,
	[ServerID] [int] NULL,
	[InstanceID] [int] NULL,
	[DatabaseID] [int] NULL,
	[SchemaID] [int] NULL,
	[TableID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[column_id] [int] NOT NULL,
	[default_object_id] [int] NULL,
	[generated_always_type] [tinyint] NULL,
	[generated_always_type_desc] [nvarchar](60) NULL,
	[is_ansi_padded] [bit] NULL,
	[is_column_set] [bit] NULL,
	[is_computed] [bit] NULL,
	[is_dts_replicated] [bit] NULL,
	[is_filestream] [bit] NULL,
	[is_hidden] [bit] NULL,
	[is_identity] [bit] NULL,
	[is_masked] [bit] NULL,
	[is_merge_published] [bit] NULL,
	[is_non_sql_subscribed] [bit] NULL,
	[is_nullable] [bit] NULL,
	[is_replicated] [bit] NULL,
	[is_rowguidcol] [bit] NULL,
	[is_sparse] [bit] NULL,
	[is_xml_document] [bit] NULL,
	[max_length] [smallint] NULL,
	[name] [nvarchar](128) NOT NULL,
	[object_id] [int] NOT NULL,
	[precision] [tinyint] NULL,
	[rule_object_id] [int] NULL,
	[scale] [tinyint] NULL,
	[system_type_id] [tinyint] NULL,
	[user_type_id] [int] NULL,
	[xml_collection_id] [int] NULL,
	[collation_name] [nvarchar](128) NULL,
	[encryption_type] [int] NULL,
	[encryption_type_desc] [nvarchar](64) NULL,
	[encryption_algorithm_name] [sysname] NULL,
	[column_encryption_key_id] [int] NULL,
	[column_encryption_key_database_name] [sysname] NULL,
	[is_pii] [bit] NULL,
	[is_system] [bit] NULL,
	[pii_type] [varchar](50) NULL,
 CONSTRAINT [PK_Column_ColumnID] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[Table]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Table](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentID] [tinyint] NULL,
	[DomainID] [tinyint] NULL,
	[PlatformID] [tinyint] NULL,
	[ServerID] [int] NULL,
	[InstanceID] [int] NULL,
	[DatabaseID] [int] NOT NULL,
	[SchemaID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[name] [nvarchar](128) NOT NULL,
	[object_id] [int] NOT NULL,
	[principal_id] [int] NULL,
	[schema_id] [int] NULL,
	[parent_object_id] [int] NULL,
	[type] [char](2) NULL,
	[type_desc] [nvarchar](60) NULL,
	[create_date] [datetime] NULL,
	[modify_date] [datetime] NULL,
	[is_ms_shipped] [bit] NULL,
	[is_published] [bit] NULL,
	[is_schema_published] [bit] NULL,
	[lob_data_space_id] [int] NULL,
	[filestream_data_space_id] [int] NULL,
	[max_column_id_used] [int] NULL,
	[lock_on_bulk_load] [bit] NULL,
	[uses_ansi_nulls] [bit] NULL,
	[is_replicated] [bit] NULL,
	[has_replication_filter] [bit] NULL,
	[is_merge_published] [bit] NULL,
	[is_sync_tran_subscribed] [bit] NULL,
	[has_unchecked_assembly_data] [bit] NULL,
	[text_in_row_limit] [int] NULL,
	[large_value_types_out_of_row] [bit] NULL,
	[is_tracked_by_cdc] [bit] NULL,
	[lock_escalation] [tinyint] NULL,
	[lock_escalation_desc] [nvarchar](60) NULL,
	[is_filetable] [bit] NULL,
	[is_memory_optimized] [bit] NULL,
	[durability] [tinyint] NULL,
	[durability_desc] [nvarchar](60) NULL,
	[temporal_type] [tinyint] NULL,
	[temporal_type_desc] [nvarchar](60) NULL,
	[history_table_id] [int] NULL,
	[is_remote_data_archive_enabled] [bit] NULL,
	[is_external] [bit] NULL,
	[has_opaque_metadata] [bit] NULL,
	[with_check_option] [bit] NULL,
	[is_date_correlation_view] [bit] NULL,
	[is_nppi] [bit] NOT NULL,
 CONSTRAINT [PK_Table_TableID] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Column]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [mssql].[vw_Column] with schemabinding as
select
	c.[ColumnID],
	c.[EnvironmentID],
	c.[DomainID],
	c.[PlatformID],
	c.[ServerID],
	c.[InstanceID],
	c.[DatabaseID],
	c.[SchemaID],
	c.[TableID],
	c.[load_date],
	c.[eff_date],
	c.[column_id],
	c.[default_object_id],
	c.[generated_always_type],
	c.[generated_always_type_desc],
	c.[is_ansi_padded],
	c.[is_column_set],
	c.[is_computed],
	c.[is_dts_replicated],
	c.[is_filestream],
	c.[is_hidden],
	c.[is_identity],
	c.[is_masked],
	c.[is_merge_published],
	c.[is_non_sql_subscribed],
	c.[is_nullable],
	c.[is_replicated],
	c.[is_rowguidcol],
	c.[is_sparse],
	c.[is_xml_document],
	c.[max_length],
	c.[name],
	c.[object_id],
	c.[precision],
	c.[rule_object_id],
	c.[scale],
	c.[system_type_id],
	c.[user_type_id],
	c.[xml_collection_id],
	c.[collation_name],
	c.[encryption_type],
	c.[encryption_type_desc],
	c.[encryption_algorithm_name],
	c.[column_encryption_key_id],
	c.[column_encryption_key_database_name],
	c.[is_pii],
	c.[is_system],
	c.[pii_type]
from
	mssql.[Column] [c]
	inner join mssql.[Table] [t] on c.[TableID] = t.[TableID] and t.[eff_date] is not null
where
	c.[eff_date] is not null ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_Column_ColumnID]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_Column_ColumnID] ON [mssql].[vw_Column]
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[Database]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Database](
	[DatabaseID] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentID] [tinyint] NULL,
	[DomainID] [tinyint] NULL,
	[PlatformID] [tinyint] NULL,
	[ServerID] [int] NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[name] [nvarchar](128) NOT NULL,
	[database_id] [int] NOT NULL,
	[owner] [nvarchar](128) NULL,
	[create_date] [datetime] NULL,
	[compatibility_level] [tinyint] NULL,
	[collation_name] [sysname] NULL,
	[user_access] [tinyint] NULL,
	[user_access_desc] [nvarchar](60) NULL,
	[is_read_only] [bit] NULL,
	[is_auto_close_on] [bit] NULL,
	[is_auto_shrink_on] [bit] NULL,
	[state] [tinyint] NULL,
	[state_desc] [nvarchar](60) NULL,
	[is_in_standby] [bit] NULL,
	[is_cleanly_shutdown] [bit] NULL,
	[is_supplemental_logging_enabled] [bit] NULL,
	[snapshot_isolation_state] [tinyint] NULL,
	[snapshot_isolation_state_desc] [nvarchar](60) NULL,
	[is_read_committed_snapshot_on] [bit] NULL,
	[recovery_model] [tinyint] NULL,
	[recovery_model_desc] [nvarchar](60) NULL,
	[page_verify_option] [tinyint] NULL,
	[page_verify_option_desc] [nvarchar](60) NULL,
	[is_auto_create_stats_on] [bit] NULL,
	[is_auto_create_stats_incremental_on] [bit] NULL,
	[is_auto_update_stats_on] [bit] NULL,
	[is_auto_update_stats_async_on] [bit] NULL,
	[is_ansi_null_default_on] [bit] NULL,
	[is_ansi_nulls_on] [bit] NULL,
	[is_ansi_padding_on] [bit] NULL,
	[is_ansi_warnings_on] [bit] NULL,
	[is_arithabort_on] [bit] NULL,
	[is_concat_null_yields_null_on] [bit] NULL,
	[is_numeric_roundabort_on] [bit] NULL,
	[is_quoted_identifier_on] [bit] NULL,
	[is_recursive_triggers_on] [bit] NULL,
	[is_cursor_close_on_commit_on] [bit] NULL,
	[is_local_cursor_default] [bit] NULL,
	[is_fulltext_enabled] [bit] NULL,
	[is_trustworthy_on] [bit] NULL,
	[is_db_chaining_on] [bit] NULL,
	[is_parameterization_forced] [bit] NULL,
	[is_master_key_encrypted_by_server] [bit] NULL,
	[is_query_store_on] [bit] NULL,
	[is_published] [bit] NULL,
	[is_subscribed] [bit] NULL,
	[is_merge_published] [bit] NULL,
	[is_distributor] [bit] NULL,
	[is_sync_with_backup] [bit] NULL,
	[is_broker_enabled] [bit] NULL,
	[log_reuse_wait] [bit] NULL,
	[log_reuse_wait_desc] [nvarchar](60) NULL,
	[is_date_correlation_on] [bit] NULL,
	[is_cdc_enabled] [bit] NULL,
	[is_encrypted] [bit] NULL,
	[is_honor_broker_priority_on] [bit] NULL,
	[default_language_lcid] [smallint] NULL,
	[default_language_name] [nvarchar](128) NULL,
	[default_fulltext_language_lcid] [int] NULL,
	[default_fulltext_language_name] [nvarchar](128) NULL,
	[is_nested_triggers_on] [bit] NULL,
	[is_transform_noise_words_on] [bit] NULL,
	[two_digit_year_cutoff] [smallint] NULL,
	[containment] [tinyint] NULL,
	[containment_desc] [nvarchar](60) NULL,
	[target_recovery_time_in_seconds] [int] NULL,
	[delayed_durability] [int] NULL,
	[delayed_durability_desc] [nvarchar](60) NULL,
	[is_memory_optimized_elevate_to_snapshot_on] [bit] NULL,
	[is_federation_member] [bit] NULL,
	[is_remote_data_archive_enabled] [bit] NULL,
	[is_mixed_page_allocation_on] [bit] NULL,
	[is_nppi] [bit] NULL,
 CONSTRAINT [PK_Database_DatabaseID] PRIMARY KEY CLUSTERED 
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Database]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [mssql].[vw_Database] with schemabinding as
select
	[DatabaseID],
	[EnvironmentID],
	[DomainID],
	[PlatformID],
	[ServerID],
	[InstanceID],
	[load_date],
	[eff_date],
	[name],
	[database_id],
	[owner],
	[create_date],
	[compatibility_level],
	[collation_name],
	[user_access],
	[user_access_desc],
	[is_read_only],
	[is_auto_close_on],
	[is_auto_shrink_on],
	[state],
	[state_desc],
	[is_in_standby],
	[is_cleanly_shutdown],
	[is_supplemental_logging_enabled],
	[snapshot_isolation_state],
	[snapshot_isolation_state_desc],
	[is_read_committed_snapshot_on],
	[recovery_model],
	[recovery_model_desc],
	[page_verify_option],
	[page_verify_option_desc],
	[is_auto_create_stats_on],
	[is_auto_create_stats_incremental_on],
	[is_auto_update_stats_on],
	[is_auto_update_stats_async_on],
	[is_ansi_null_default_on],
	[is_ansi_nulls_on],
	[is_ansi_padding_on],
	[is_ansi_warnings_on],
	[is_arithabort_on],
	[is_concat_null_yields_null_on],
	[is_numeric_roundabort_on],
	[is_quoted_identifier_on],
	[is_recursive_triggers_on],
	[is_cursor_close_on_commit_on],
	[is_local_cursor_default],
	[is_fulltext_enabled],
	[is_trustworthy_on],
	[is_db_chaining_on],
	[is_parameterization_forced],
	[is_master_key_encrypted_by_server],
	[is_query_store_on],
	[is_published],
	[is_subscribed],
	[is_merge_published],
	[is_distributor],
	[is_sync_with_backup],
	[is_broker_enabled],
	[log_reuse_wait],
	[log_reuse_wait_desc],
	[is_date_correlation_on],
	[is_cdc_enabled],
	[is_encrypted],
	[is_honor_broker_priority_on],
	[default_language_lcid],
	[default_language_name],
	[default_fulltext_language_lcid],
	[default_fulltext_language_name],
	[is_nested_triggers_on],
	[is_transform_noise_words_on],
	[two_digit_year_cutoff],
	[containment],
	[containment_desc],
	[target_recovery_time_in_seconds],
	[delayed_durability],
	[delayed_durability_desc],
	[is_memory_optimized_elevate_to_snapshot_on],
	[is_federation_member],
	[is_remote_data_archive_enabled],
	[is_mixed_page_allocation_on],
	[is_nppi]
from
	mssql.[Database] ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_Database_DatabaseID]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_Database_DatabaseID] ON [mssql].[vw_Database]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Instance]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [mssql].[vw_Instance] with schemabinding as
select
	[InstanceID],
	[EnvironmentID],
	[DomainID],
	[PlatformID],
	[ServerID],
	[load_date],
	[eff_date],
	[instance_name],
	[description],
	[alias],
	[ip],
	[port],
	[cname],
	[dpe_managed],
	[service_account],
	[deactive_date],
	[is_nppi],
	[override_version]
from
	mssql.[Instance] ;


GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_Instance_InstanceID]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_Instance_InstanceID] ON [mssql].[vw_Instance]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[Schema]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Schema](
	[SchemaID] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentID] [tinyint] NULL,
	[DomainID] [tinyint] NULL,
	[PlatformID] [tinyint] NULL,
	[ServerID] [int] NULL,
	[InstanceID] [int] NULL,
	[DatabaseID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[name] [nvarchar](128) NOT NULL,
	[schema_id] [int] NOT NULL,
	[principal_id] [int] NULL,
 CONSTRAINT [PK_Schema_SchemaID] PRIMARY KEY CLUSTERED 
(
	[SchemaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Schema]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [mssql].[vw_Schema] as
select * from mssql.[Schema] ;


GO
/****** Object:  View [mssql].[vw_Table]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [mssql].[vw_Table] with schemabinding as
select
	t.[TableID],
	t.[EnvironmentID],
	t.[DomainID],
	t.[PlatformID],
	t.[ServerID],
	t.[InstanceID],
	t.[DatabaseID],
	t.[SchemaID],
	t.[load_date],
	t.[eff_date],
	t.[name],
	t.[object_id],
	t.[principal_id],
	t.[schema_id],
	t.[parent_object_id],
	t.[type],
	t.[type_desc],
	t.[create_date],
	t.[modify_date],
	t.[is_ms_shipped],
	t.[is_published],
	t.[is_schema_published],
	t.[lob_data_space_id],
	t.[filestream_data_space_id],
	t.[max_column_id_used],
	t.[lock_on_bulk_load],
	t.[uses_ansi_nulls],
	t.[is_replicated],
	t.[has_replication_filter],
	t.[is_merge_published],
	t.[is_sync_tran_subscribed],
	t.[has_unchecked_assembly_data],
	t.[text_in_row_limit],
	t.[large_value_types_out_of_row],
	t.[is_tracked_by_cdc],
	t.[lock_escalation],
	t.[lock_escalation_desc],
	t.[is_filetable],
	t.[is_memory_optimized],
	t.[durability],
	t.[durability_desc],
	t.[temporal_type],
	t.[temporal_type_desc],
	t.[history_table_id],
	t.[is_remote_data_archive_enabled],
	t.[is_external],
	t.[has_opaque_metadata],
	t.[with_check_option],
	t.[is_date_correlation_view],
	t.[is_nppi]
from
	mssql.[Table] [t]
	inner join mssql.[Schema] [s] on t.[SchemaID] = s.[SchemaID]
where
	t.[eff_date] is not null ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [VIX_vw_Table_TableID]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE UNIQUE CLUSTERED INDEX [VIX_vw_Table_TableID] ON [mssql].[vw_Table]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [staging].[NPPI]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[NPPI](
	[instance_name] [varchar](128) NOT NULL,
	[database_name] [varchar](128) NOT NULL,
	[schema_name] [varchar](128) NOT NULL,
	[object_name] [varchar](128) NOT NULL,
	[column_name] [varchar](128) NOT NULL,
	[is_pii] [bit] NOT NULL,
	[pii_type] [varchar](32) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_NPPI]    Script Date: 8/20/2018 9:10:04 AM ******/
CREATE UNIQUE CLUSTERED INDEX [UX_NPPI] ON [staging].[NPPI]
(
	[instance_name] ASC,
	[database_name] ASC,
	[schema_name] ASC,
	[object_name] ASC,
	[column_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_nppi_production]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [mssql].[vw_nppi_production] as
select
	i.[instance_name],
	[database_name] = d.[name],
	[schema_name] = s.[name],
	[table_name] = t.[name],
	[column_name] = c.[name],
	[is_pii] = pii.[is_pii],
	[pii_type] = pii.[pii_type]
from
	mssql.[vw_Column] [c]
	inner join mssql.[vw_Table] [t] on c.[TableID] = t.[TableID]
	inner join mssql.[vw_Schema] [s] on t.[SchemaID] = s.[SchemaID]
	inner join mssql.[vw_Database] [d] on s.[DatabaseID] = d.[DatabaseID]
	inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
	inner join common.[Environment] [e] on i.[EnvironmentID] = e.[EnvironmentID]
	inner join staging.[NPPI] [pii] on
		i.[instance_name] = pii.[instance_name]
		and d.[name] = pii.[database_name]
		and s.[name] = pii.[schema_name]
		and t.[name] = pii.[object_name]
		and c.[name] = pii.[column_name]
where
	pii.[is_pii] = 1
	and e.[environment_name] = 'PRD'

GO
/****** Object:  Table [log].[checks]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[checks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ScanTypeID] [tinyint] NOT NULL,
	[dt_begin] [datetime2](2) NOT NULL,
	[dt_end] [datetime2](2) NOT NULL,
	[operation] [varchar](32) NOT NULL,
	[target_type] [nvarchar](128) NOT NULL,
	[target_id] [int] NOT NULL,
	[disposition] [varchar](256) NOT NULL,
	[successful] [bit] NOT NULL,
	[checked_by] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_checks_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Checks]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [mssql].[vw_Checks] as
select
	i.[instance_name],
	log.*
from
	log.[checks] [log]
	inner join mssql.[vw_Instance] [i] on log.[target_id] = i.[InstanceID] ;

GO
/****** Object:  Table [common].[Domain]    Script Date: 8/20/2018 9:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Domain](
	[DomainID] [tinyint] IDENTITY(1,1) NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[domain_name] [nvarchar](128) NOT NULL,
	[root_domain] [nvarchar](128) NULL,
 CONSTRAINT [PK_Domain_DomainID] PRIMARY KEY CLUSTERED 
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [common].[vw_Domain]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [common].[vw_Domain] as
select * from common.[Domain] ;

GO
/****** Object:  View [common].[vw_Environment]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [common].[vw_Environment] as
select * from common.[Environment] ;

GO
/****** Object:  Table [common].[Platform]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Platform](
	[PlatformID] [tinyint] IDENTITY(1,1) NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[platform_name] [varchar](128) NOT NULL,
	[required_version] [nvarchar](128) NOT NULL,
	[platform_schema] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Platform_PlatformID] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [common].[vw_Platform]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [common].[vw_Platform] as
select * from common.[Platform] ;

GO
/****** Object:  Table [common].[ScanInterval]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[ScanInterval](
	[ScanIntervalID] [tinyint] IDENTITY(1,1) NOT NULL,
	[scaninterval_name] [varchar](128) NOT NULL,
	[aging_minutes] [int] NULL,
 CONSTRAINT [PK_ScanInterval_ScanIntervalID] PRIMARY KEY CLUSTERED 
(
	[ScanIntervalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [common].[ScanType]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[ScanType](
	[ScanTypeID] [tinyint] IDENTITY(6,1) NOT NULL,
	[scantype_name] [varchar](128) NOT NULL,
 CONSTRAINT [PK_ScanType_ScanTypeID] PRIMARY KEY CLUSTERED 
(
	[ScanTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [common].[Schedule]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Schedule](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[PlatformID] [tinyint] NOT NULL,
	[EnvironmentID] [tinyint] NOT NULL,
	[ScanTypeID] [tinyint] NOT NULL,
	[ScanIntervalID] [tinyint] NOT NULL,
 CONSTRAINT [PK_Schedule_ScheduleID] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [common].[vw_Schedule]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [common].[vw_Schedule] as
select distinct
	i.[instance_name],
	[environment] = e.[common_name],
	[added] = n.[dt_end],
	st.[scantype_name],
	[last_check] = c.[dt_end],
	si.[aging_minutes],
	[next_check] = DateAdd(minute, si.[aging_minutes], c.[dt_end]),
	[due] = case when c.[dt_end] is null or DateAdd(minute, si.[aging_minutes], c.[dt_end]) <= getdate() - 0.1 then 1 else 0 end
from
	mssql.[Instance] [i]
	inner join common.[Environment] [e] on i.[EnvironmentID] = e.[EnvironmentID]
	inner join common.[Schedule] [s] on i.[EnvironmentID] = s.[EnvironmentID]
	inner join common.[ScanType] [st] on s.[ScanTypeID] = st.[ScanTypeID]
	inner join common.[ScanInterval] [si] on s.[ScanIntervalID] = si.[ScanIntervalID]
	inner join log.[checks] [n] on i.[InstanceID] = n.[target_id] and n.[ScanTypeID] = 1 and n.[successful] = 1 and n.[dt_end] = (select Max([dt_end]) from log.[checks] where [target_id] = i.[InstanceID] and [ScanTypeID] = 1 and [successful] = 1)
	left outer join log.[checks] [c] on i.[InstanceID] = c.[target_id] and c.[ScanTypeID] = st.[ScanTypeID] and c.[successful] = 1 and c.[dt_end] = (select Max([dt_end]) from log.[checks] where [target_id] = i.[InstanceID] and [ScanTypeID] = st.[ScanTypeID] and [successful] = 1)



GO
/****** Object:  Table [common].[Server]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Server](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[DomainID] [tinyint] NOT NULL,
	[ClusterID] [int] NULL,
	[load_date] [datetime2](2) NOT NULL,
	[server_name] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Server_ServerID] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [common].[vw_Server]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [common].[vw_Server] as
select * from common.[Server] ;

GO
/****** Object:  Table [mssql].[FileGroup]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[FileGroup](
	[FileGroupID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[name] [nvarchar](128) NOT NULL,
	[data_space_id] [int] NULL,
	[type] [char](2) NULL,
	[type_desc] [nvarchar](60) NULL,
	[is_default] [bit] NULL,
	[is_system] [bit] NULL,
	[is_read_only] [bit] NULL,
	[is_autogrow_all_files] [bit] NULL,
 CONSTRAINT [PK_FileGroup_FileGroupID] PRIMARY KEY CLUSTERED 
(
	[FileGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_FileGroup]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [mssql].[vw_FileGroup] with schemabinding as
select
	fg.[FileGroupID],
	fg.[DatabaseID],
	fg.[load_date],
	fg.[eff_date],
	fg.[name],
	fg.[data_space_id],
	fg.[type],
	fg.[type_desc],
	fg.[is_default],
	fg.[is_system],
	fg.[is_read_only],
	fg.[is_autogrow_all_files]
from
	mssql.[FileGroup] [fg]
	inner join mssql.[Database] [d] on fg.[DatabaseID] = d.[DatabaseID]
where
	fg.[eff_date] is not null ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_FileGroup_FileGroupID]    Script Date: 8/20/2018 9:10:05 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_FileGroup_FileGroupID] ON [mssql].[vw_FileGroup]
(
	[FileGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[InstanceSysConfig]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[InstanceSysConfig](
	[InstanceSysConfigID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[SysConfigID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[value] [sql_variant] NOT NULL,
	[value_in_use] [sql_variant] NOT NULL,
 CONSTRAINT [PK_InstanceSysConfig_InstanceSysConfigID] PRIMARY KEY CLUSTERED 
(
	[InstanceSysConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_InstanceSysConfig]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







create view [mssql].[vw_InstanceSysConfig] with schemabinding as
select
	isc.[InstanceSysConfigID],
	isc.[InstanceID],
	isc.[SysConfigID],
	isc.[load_date],
	isc.[eff_date],
	isc.[value],
	isc.[value_in_use]
from
	mssql.[InstanceSysConfig] [isc]
	inner join mssql.[Instance] [i] on isc.[InstanceID] = i.[InstanceID]
where
	isc.[eff_date] is not null ;







GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_InstanceSysConfig_InstanceSysConfigID]    Script Date: 8/20/2018 9:10:05 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_InstanceSysConfig_InstanceSysConfigID] ON [mssql].[vw_InstanceSysConfig]
(
	[InstanceSysConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[Job]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Job](
	[JobID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[system_id] [int] NULL,
	[inserted_at] [datetime] NULL,
	[category_id] [int] NULL,
	[date_created] [datetime] NULL,
	[date_modified] [datetime] NULL,
	[delete_level] [int] NULL,
	[description] [nvarchar](1000) NULL,
	[enabled] [tinyint] NULL,
	[job_id] [uniqueidentifier] NULL,
	[name] [nvarchar](1000) NULL,
	[notify_email_operator_id] [int] NULL,
	[notify_level_email] [int] NULL,
	[notify_level_eventlog] [int] NULL,
	[notify_level_netsend] [int] NULL,
	[notify_level_page] [int] NULL,
	[notify_netsend_operator_id] [int] NULL,
	[notify_page_operator_id] [int] NULL,
	[originating_server_id] [int] NULL,
	[start_step_id] [int] NULL,
	[version_number] [int] NULL,
 CONSTRAINT [PK_Job_JobID] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Job]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create view [mssql].[vw_Job] with schemabinding as
select
	j.[JobID],
	j.[InstanceID],
	j.[load_date],
	j.[eff_date],
	j.[system_id],
	j.[inserted_at],
	j.[category_id],
	j.[date_created],
	j.[date_modified],
	j.[delete_level],
	j.[description],
	j.[enabled],
	j.[job_id],
	j.[name],
	j.[notify_email_operator_id],
	j.[notify_level_email],
	j.[notify_level_eventlog],
	j.[notify_level_netsend],
	j.[notify_level_page],
	j.[notify_netsend_operator_id],
	j.[notify_page_operator_id],
	j.[originating_server_id],
	j.[start_step_id],
	j.[version_number]
from
	mssql.[Job] [j]
	inner join mssql.[Instance] [i] on j.[InstanceID] = i.[InstanceID]
where
	j.[eff_date] is not null ;






GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_Job_JobID]    Script Date: 8/20/2018 9:10:05 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_Job_JobID] ON [mssql].[vw_Job]
(
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[JobSnapshot]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[JobSnapshot](
	[JobSnapshotID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[job_name] [sysname] NOT NULL,
	[job_enabled] [tinyint] NOT NULL,
	[schedule_name] [sysname] NULL,
	[schedule_enabled] [int] NULL,
	[frequency] [varchar](22) NULL,
	[interval] [nvarchar](4000) NULL,
	[recurrence] [varchar](24) NULL,
	[next_run_time] [varchar](19) NULL,
	[last_run_time] [varchar](19) NULL,
	[last_status] [int] NULL,
	[last_run_duration] [varchar](101) NULL,
	[last_run_duration_int] [int] NULL,
	[avg_run_duration_all] [varchar](101) NULL,
	[avg_run_duration_all_int] [int] NULL,
	[avg_run_duration_last7] [varchar](101) NULL,
	[avg_run_duration_last7_int] [int] NULL,
 CONSTRAINT [PK_JobSnapshot_JobSnapshotID] PRIMARY KEY CLUSTERED 
(
	[JobSnapshotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_JobSnapshot]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create view [mssql].[vw_JobSnapshot] with schemabinding as
select
	js.[JobSnapshotID],
	js.[InstanceID],
	js.[load_date],
	js.[eff_date],
	js.[job_name],
	js.[job_enabled],
	js.[schedule_name],
	js.[schedule_enabled],
	js.[frequency],
	js.[interval],
	js.[recurrence],
	js.[next_run_time],
	js.[last_run_time],
	js.[last_status],
	js.[last_run_duration],
	js.[last_run_duration_int],
	js.[avg_run_duration_all],
	js.[avg_run_duration_all_int],
	js.[avg_run_duration_last7],
	js.[avg_run_duration_last7_int]
from
	mssql.[JobSnapshot] [js]
	inner join mssql.[Instance] [i] on js.[InstanceID] = i.[InstanceID]
where
	js.[eff_date] is not null ;






GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_JobSnapshot_JobSnapshotID]    Script Date: 8/20/2018 9:10:05 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_JobSnapshot_JobSnapshotID] ON [mssql].[vw_JobSnapshot]
(
	[JobSnapshotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[JobStep]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[JobStep](
	[JobStepID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[system_id] [int] NULL,
	[inserted_at] [datetime] NULL,
	[cmdexec_success_code] [int] NULL,
	[command] [nvarchar](max) NULL,
	[database_name] [nvarchar](1000) NULL,
	[flags] [int] NULL,
	[job_id] [uniqueidentifier] NULL,
	[last_run_date] [int] NULL,
	[last_run_duration] [int] NULL,
	[last_run_outcome] [int] NULL,
	[last_run_retries] [int] NULL,
	[last_run_time] [int] NULL,
	[on_fail_action] [tinyint] NULL,
	[on_fail_step_id] [int] NULL,
	[on_success_action] [tinyint] NULL,
	[on_success_step_id] [int] NULL,
	[os_run_priority] [int] NULL,
	[output_file_name] [nvarchar](1000) NULL,
	[retry_attempts] [int] NULL,
	[retry_interval] [int] NULL,
	[step_id] [int] NULL,
	[step_name] [nvarchar](1000) NULL,
	[step_uid] [uniqueidentifier] NULL,
	[subsystem] [nvarchar](1000) NULL,
 CONSTRAINT [PK_JobStep_JobStepID] PRIMARY KEY CLUSTERED 
(
	[JobStepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_JobStep]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create view [mssql].[vw_JobStep] with schemabinding as
select
	js.[JobStepID],
	js.[InstanceID],
	js.[load_date],
	js.[eff_date],
	js.[system_id],
	js.[inserted_at],
	js.[cmdexec_success_code],
	js.[command],
	js.[database_name],
	js.[flags],
	js.[job_id],
	js.[last_run_date],
	js.[last_run_duration],
	js.[last_run_outcome],
	js.[last_run_retries],
	js.[last_run_time],
	js.[on_fail_action],
	js.[on_fail_step_id],
	js.[on_success_action],
	js.[on_success_step_id],
	js.[os_run_priority],
	js.[output_file_name],
	js.[retry_attempts],
	js.[retry_interval],
	js.[step_id],
	js.[step_name],
	js.[step_uid],
	js.[subsystem]
from
	mssql.[JobStep] [js]
	inner join mssql.[Instance] [i] on js.[InstanceID] = i.[InstanceID]
where
	js.[eff_date] is not null ;






GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_JobStep_JobStepID]    Script Date: 8/20/2018 9:10:05 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_JobStep_JobStepID] ON [mssql].[vw_JobStep]
(
	[JobStepID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[QueryStats_AdHoc]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[QueryStats_AdHoc](
	[QueryStats_AdHocID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[rank] [tinyint] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[usecounts] [int] NOT NULL,
	[mb] [real] NOT NULL,
 CONSTRAINT [PK_QueryStats_AdHoc_QueryStats_AdHocID] PRIMARY KEY CLUSTERED 
(
	[QueryStats_AdHocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_QueryStats_AdHoc]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create view [mssql].[vw_QueryStats_AdHoc] with schemabinding as
select
	qs.[QueryStats_AdHocID],
	qs.[InstanceID],
	qs.[load_date],
	qs.[eff_date],
	qs.[rank],
	qs.[text],
	qs.[usecounts],
	qs.[mb]
from
	mssql.[QueryStats_AdHoc] [qs]
	inner join mssql.[Instance] [i] on qs.[InstanceID] = i.[InstanceID]
where
	qs.[eff_date] is not null ;





GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_QueryStats_AdHoc_QueryStats_AdHocID]    Script Date: 8/20/2018 9:10:05 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_QueryStats_AdHoc_QueryStats_AdHocID] ON [mssql].[vw_QueryStats_AdHoc]
(
	[QueryStats_AdHocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[QueryStats_TopExecutions]    Script Date: 8/20/2018 9:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[QueryStats_TopExecutions](
	[QueryStats_TopExecutionsID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[rank] [tinyint] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[average_worker_time] [bigint] NOT NULL,
 CONSTRAINT [PK_QueryStats_TopExecutions_QueryStats_TopExecutionsID] PRIMARY KEY CLUSTERED 
(
	[QueryStats_TopExecutionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_QueryStats_TopExecutions]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create view [mssql].[vw_QueryStats_TopExecutions] with schemabinding as
select
	qs.[QueryStats_TopExecutionsID],
	qs.[InstanceID],
	qs.[load_date],
	qs.[eff_date],
	qs.[rank],
	qs.[text],
	qs.[execution_count],
	qs.[total_worker_time],
	qs.[average_worker_time]
from
	mssql.[QueryStats_TopExecutions] [qs]
	inner join mssql.[Instance] [i] on qs.[InstanceID] = i.[InstanceID]
where
	qs.[eff_date] is not null ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_QueryStats_TopExecutions_QueryStats_TopExecutionsID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_QueryStats_TopExecutions_QueryStats_TopExecutionsID] ON [mssql].[vw_QueryStats_TopExecutions]
(
	[QueryStats_TopExecutionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[QueryStats_TopExecutions_DB]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[QueryStats_TopExecutions_DB](
	[QueryStats_TopExecutions_DBID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[rank] [tinyint] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[average_worker_time] [bigint] NOT NULL,
 CONSTRAINT [PK_QueryStats_TopExecutions_DB_QueryStats_TopExecutions_DBID] PRIMARY KEY CLUSTERED 
(
	[QueryStats_TopExecutions_DBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_QueryStats_TopExecutions_DB]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [mssql].[vw_QueryStats_TopExecutions_DB] with schemabinding as
select
	qs.[QueryStats_TopExecutions_DBID],
	qs.[DatabaseID],
	qs.[load_date],
	qs.[eff_date],
	qs.[rank],
	qs.[text],
	qs.[execution_count],
	qs.[total_worker_time],
	qs.[average_worker_time]
from
	mssql.[QueryStats_TopExecutions_DB] [qs]
	inner join mssql.[Database] [d] on qs.[DatabaseID] = d.[DatabaseID]
where
	qs.[eff_date] is not null ;



GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_QueryStats_TopExecutions_DB_QueryStats_TopExecutions_DBID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_QueryStats_TopExecutions_DB_QueryStats_TopExecutions_DBID] ON [mssql].[vw_QueryStats_TopExecutions_DB]
(
	[QueryStats_TopExecutions_DBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[QueryStats_TopTime]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[QueryStats_TopTime](
	[QueryStats_TopTimeID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[rank] [tinyint] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[average_worker_time] [bigint] NOT NULL,
 CONSTRAINT [PK_QueryStats_TopTime_QueryStats_TopTimeID] PRIMARY KEY CLUSTERED 
(
	[QueryStats_TopTimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_QueryStats_TopTime]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create view [mssql].[vw_QueryStats_TopTime] with schemabinding as
select
	qs.[QueryStats_TopTimeID],
	qs.[InstanceID],
	qs.[load_date],
	qs.[eff_date],
	qs.[rank],
	qs.[text],
	qs.[execution_count],
	qs.[total_worker_time],
	qs.[average_worker_time]
from
	mssql.[QueryStats_TopTime] [qs]
	inner join mssql.[Instance] [i] on qs.[InstanceID] = i.[InstanceID]
where
	qs.[eff_date] is not null ;




GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_QueryStats_TopTime_QueryStats_TopTimeID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_QueryStats_TopTime_QueryStats_TopTimeID] ON [mssql].[vw_QueryStats_TopTime]
(
	[QueryStats_TopTimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[QueryStats_TopTime_DB]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[QueryStats_TopTime_DB](
	[QueryStats_TopTime_DBID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[rank] [tinyint] NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[average_worker_time] [bigint] NOT NULL,
 CONSTRAINT [PK_QueryStats_TopTime_DB_QueryStats_TopTime_DBID] PRIMARY KEY CLUSTERED 
(
	[QueryStats_TopTime_DBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_QueryStats_TopTime_DB]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [mssql].[vw_QueryStats_TopTime_DB] with schemabinding as
select
	qs.[QueryStats_TopTime_DBID],
	qs.[DatabaseID],
	qs.[load_date],
	qs.[eff_date],
	qs.[rank],
	qs.[text],
	qs.[execution_count],
	qs.[total_worker_time],
	qs.[average_worker_time]
from
	mssql.[QueryStats_TopTime_DB] [qs]
	inner join mssql.[Database] [d] on qs.[DatabaseID] = d.[DatabaseID]
where
	qs.[eff_date] is not null ;


GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_QueryStats_TopTime_DB_QueryStats_TopTime_DBID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_QueryStats_TopTime_DB_QueryStats_TopTime_DBID] ON [mssql].[vw_QueryStats_TopTime_DB]
(
	[QueryStats_TopTime_DBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[Routine]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Routine](
	[RoutineID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[SchemaID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[CREATED] [datetime] NULL,
	[IS_DETERMINISTIC] [nvarchar](1000) NULL,
	[IS_IMPLICITLY_INVOCABLE] [nvarchar](1000) NULL,
	[IS_USER_DEFINED_CAST] [nvarchar](1000) NULL,
	[LAST_ALTERED] [datetime] NULL,
	[MAX_DYNAMIC_RESULT_SETS] [smallint] NULL,
	[ROUTINE_BODY] [nvarchar](1000) NULL,
	[ROUTINE_CATALOG] [nvarchar](1000) NULL,
	[ROUTINE_DEFINITION] [nvarchar](max) NULL,
	[ROUTINE_NAME] [nvarchar](1000) NULL,
	[ROUTINE_SCHEMA] [nvarchar](1000) NULL,
	[ROUTINE_TYPE] [nvarchar](1000) NULL,
	[SCHEMA_LEVEL_ROUTINE] [nvarchar](1000) NULL,
	[SPECIFIC_CATALOG] [nvarchar](1000) NULL,
	[SPECIFIC_NAME] [nvarchar](1000) NULL,
	[SPECIFIC_SCHEMA] [nvarchar](1000) NULL,
	[SQL_DATA_ACCESS] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Routine_RoutineID] PRIMARY KEY CLUSTERED 
(
	[RoutineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Routine]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create view [mssql].[vw_Routine] with schemabinding as
select
	r.[RoutineID],
	r.[DatabaseID],
	r.[SchemaID],
	r.[load_date],
	r.[eff_date],
	r.[CREATED],
	r.[IS_DETERMINISTIC],
	r.[IS_IMPLICITLY_INVOCABLE],
	r.[IS_USER_DEFINED_CAST],
	r.[LAST_ALTERED],
	r.[MAX_DYNAMIC_RESULT_SETS],
	r.[ROUTINE_BODY],
	r.[ROUTINE_CATALOG],
	r.[ROUTINE_DEFINITION],
	r.[ROUTINE_NAME],
	r.[ROUTINE_SCHEMA],
	r.[ROUTINE_TYPE],
	r.[SCHEMA_LEVEL_ROUTINE],
	r.[SPECIFIC_CATALOG],
	r.[SPECIFIC_NAME],
	r.[SPECIFIC_SCHEMA],
	r.[SQL_DATA_ACCESS]
from
	mssql.[Routine] [r]
	inner join mssql.[Schema] [s] on r.[SchemaID] = s.[SchemaID]
where
	r.[eff_date] is not null ;





GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_Routine_RoutineID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_Routine_RoutineID] ON [mssql].[vw_Routine]
(
	[RoutineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[File]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[File](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileGroupID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[file_id] [int] NOT NULL,
	[file_guid] [uniqueidentifier] NULL,
	[type] [tinyint] NULL,
	[type_desc] [nvarchar](60) NULL,
	[data_space_id] [int] NOT NULL,
	[name] [sysname] NULL,
	[physical_name] [nvarchar](260) NULL,
	[state] [tinyint] NULL,
	[state_desc] [nvarchar](60) NULL,
	[size] [int] NULL,
	[max_size] [int] NULL,
	[growth] [int] NULL,
	[is_media_read_only] [bit] NULL,
	[is_read_only] [bit] NULL,
	[is_sparse] [bit] NULL,
	[is_percent_growth] [bit] NULL,
	[is_name_reserved] [bit] NULL,
	[create_lsn] [numeric](25, 0) NULL,
	[drop_lsn] [numeric](25, 0) NULL,
	[read_only_lsn] [numeric](25, 0) NULL,
	[read_write_lsn] [numeric](25, 0) NULL,
	[differential_base_lsn] [numeric](25, 0) NULL,
	[differential_base_guid] [uniqueidentifier] NULL,
	[differential_base_time] [datetime] NULL,
	[redo_start_lsn] [numeric](25, 0) NULL,
	[redo_start_fork_guid] [uniqueidentifier] NULL,
	[redo_target_lsn] [numeric](25, 0) NULL,
	[redo_target_fork_guid] [uniqueidentifier] NULL,
	[backup_lsn] [numeric](25, 0) NULL,
	[sample_ms] [bigint] NULL,
	[num_of_reads] [bigint] NULL,
	[num_of_bytes_read] [bigint] NULL,
	[io_stall_read_ms] [bigint] NULL,
	[io_stall_queued_read_ms] [bigint] NULL,
	[num_of_writes] [bigint] NULL,
	[num_of_bytes_written] [bigint] NULL,
	[io_stall_write_ms] [bigint] NULL,
	[io_stall_queued_write_ms] [bigint] NULL,
	[io_stall] [bigint] NULL,
	[size_on_disk_bytes] [bigint] NULL,
 CONSTRAINT [PK_File_FileID] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_File]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [mssql].[vw_File] with schemabinding as
select
	f.[FileID],
	f.[FileGroupID],
	f.[load_date],
	f.[eff_date],
	f.[file_id],
	f.[file_guid],
	f.[type],
	f.[type_desc],
	f.[data_space_id],
	f.[name],
	f.[physical_name],
	f.[state],
	f.[state_desc],
	f.[size],
	f.[max_size],
	f.[growth],
	f.[is_media_read_only],
	f.[is_read_only],
	f.[is_sparse],
	f.[is_percent_growth],
	f.[is_name_reserved],
	f.[create_lsn],
	f.[drop_lsn],
	f.[read_only_lsn],
	f.[read_write_lsn],
	f.[differential_base_lsn],
	f.[differential_base_guid],
	f.[differential_base_time],
	f.[redo_start_lsn],
	f.[redo_start_fork_guid],
	f.[redo_target_lsn],
	f.[redo_target_fork_guid],
	f.[backup_lsn],
	f.[sample_ms],
	f.[num_of_reads],
	f.[num_of_bytes_read],
	f.[io_stall_read_ms],
	f.[io_stall_queued_read_ms],
	f.[num_of_writes],
	f.[num_of_bytes_written],
	f.[io_stall_write_ms],
	f.[io_stall_queued_write_ms],
	f.[io_stall],
	f.[size_on_disk_bytes]
from
	mssql.[File] [f]
	inner join mssql.[FileGroup] [fg] on f.[FileGroupID] = fg.[FileGroupID]
where
	f.[eff_date] is not null ;


GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_File_FileID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_File_FileID] ON [mssql].[vw_File]
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[SysConfig]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[SysConfig](
	[SysConfigID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[name] [nvarchar](64) NOT NULL,
	[description] [nvarchar](255) NOT NULL,
	[is_dynamic] [bit] NOT NULL,
	[is_advanced] [bit] NOT NULL,
 CONSTRAINT [PK_SysConfig_SysConfigID] PRIMARY KEY CLUSTERED 
(
	[SysConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_SysConfig]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [mssql].[vw_SysConfig] as
select * from mssql.[SysConfig] ;

GO
/****** Object:  Table [mssql].[TableStats]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[TableStats](
	[TableStatsID] [bigint] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[row_count] [bigint] NOT NULL,
	[table_size_mb] [decimal](18, 2) NOT NULL,
	[index_size_mb] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TableStats_TableStatsID] PRIMARY KEY CLUSTERED 
(
	[TableStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_TableStats]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [mssql].[vw_TableStats] with schemabinding as
select
	ts.[TableStatsID],
	ts.[TableID],
	ts.[load_date],
	ts.[eff_date],
	ts.[row_count],
	ts.[table_size_mb],
	ts.[index_size_mb]
from
	mssql.[TableStats] [ts]
	inner join mssql.[Table] [t] on ts.[TableID] = t.[TableID] and t.[eff_date] is not null
where
	ts.[eff_date] is not null ;

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_TableStats_TableStatsID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_TableStats_TableStatsID] ON [mssql].[vw_TableStats]
(
	[TableStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[Trigger]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[Trigger](
	[TriggerID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[SchemaID] [int] NULL,
	[TableID] [int] NULL,
	[load_date] [datetime2](2) NOT NULL,
	[eff_date] [datetime2](2) NULL,
	[name] [nvarchar](128) NOT NULL,
	[object_id] [int] NOT NULL,
	[parent_class] [tinyint] NOT NULL,
	[parent_class_desc] [nvarchar](60) NULL,
	[parent_id] [int] NOT NULL,
	[type] [char](2) NOT NULL,
	[type_desc] [nvarchar](60) NULL,
	[create_date] [datetime] NOT NULL,
	[modify_date] [datetime] NOT NULL,
	[is_ms_shipped] [bit] NOT NULL,
	[is_disabled] [bit] NOT NULL,
	[is_not_for_replication] [bit] NOT NULL,
	[is_instead_of_trigger] [bit] NOT NULL,
	[definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_Trigger_TriggerID] PRIMARY KEY CLUSTERED 
(
	[TriggerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [mssql].[vw_Trigger]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create view [mssql].[vw_Trigger] with schemabinding as
select
	tr.[TriggerID],
	tr.[DatabaseID],
	tr.[SchemaID],
	tr.[TableID],
	tr.[load_date],
	tr.[eff_date],
	tr.[name],
	tr.[object_id],
	tr.[parent_class],
	tr.[parent_class_desc],
	tr.[parent_id],
	tr.[type],
	tr.[type_desc],
	tr.[create_date],
	tr.[modify_date],
	tr.[is_ms_shipped],
	tr.[is_disabled],
	tr.[is_not_for_replication],
	tr.[is_instead_of_trigger],
	tr.[definition]
from
	mssql.[Trigger] [tr]
	inner join mssql.[Schema] [s] on tr.[SchemaID] = s.[SchemaID]
where
	tr.[eff_date] is not null ;




GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_vw_Trigger_TriggerID]    Script Date: 8/20/2018 9:10:06 AM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vw_Trigger_TriggerID] ON [mssql].[vw_Trigger]
(
	[TriggerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [common].[Cluster]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Cluster](
	[ClusterID] [int] IDENTITY(1,1) NOT NULL,
	[load_date] [datetime2](2) NOT NULL,
	[cluster_name] [nvarchar](128) NOT NULL,
	[nodes] [tinyint] NOT NULL,
	[current_node] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Cluster_ClusterID] PRIMARY KEY CLUSTERED 
(
	[ClusterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [log].[imports]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[imports](
	[id] [int] IDENTITY(6,1) NOT NULL,
	[dt_imported] [datetime2](2) NOT NULL,
	[source_file] [nvarchar](512) NOT NULL,
	[target_table] [nvarchar](128) NOT NULL,
	[record_count] [int] NOT NULL,
 CONSTRAINT [PK_imports_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [log].[merges]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[merges](
	[id] [int] IDENTITY(6,1) NOT NULL,
	[dt_merged] [datetime2](2) NOT NULL,
	[source_table] [nvarchar](128) NOT NULL,
	[target_table] [nvarchar](128) NOT NULL,
	[pre_count] [int] NOT NULL,
	[post_count] [int] NOT NULL,
 CONSTRAINT [PK_merges_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mssql].[NPPI_Production_Snapshot]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mssql].[NPPI_Production_Snapshot](
	[instance_name] [nvarchar](128) NOT NULL,
	[database_name] [nvarchar](128) NOT NULL,
	[schema_name] [sysname] NOT NULL,
	[table_name] [sysname] NOT NULL,
	[column_name] [nvarchar](128) NOT NULL,
	[is_pii] [bit] NOT NULL,
	[pii_type] [varchar](32) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Builds]    Script Date: 8/20/2018 9:10:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Builds](
	[Build] [nvarchar](255) NULL,
	[FileVersion] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[ReleaseDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Dictionary_Column_DD]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Dictionary_Column_DD](
	[instance_name] [varchar](100) NOT NULL,
	[database_name] [varchar](100) NOT NULL,
	[schema_name] [varchar](100) NOT NULL,
	[table_name] [varchar](200) NOT NULL,
	[column_name] [varchar](200) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Dictionary_Column_DD_cvr]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE CLUSTERED INDEX [IX_Dictionary_Column_DD_cvr] ON [staging].[Dictionary_Column_DD]
(
	[instance_name] ASC,
	[database_name] ASC,
	[schema_name] ASC,
	[table_name] ASC,
	[column_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Dictionary_Column_DPR]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Dictionary_Column_DPR](
	[instance_name] [nvarchar](128) NOT NULL,
	[database_name] [nvarchar](128) NOT NULL,
	[schema_name] [nvarchar](128) NOT NULL,
	[table_name] [nvarchar](128) NOT NULL,
	[column_name] [nvarchar](128) NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Dictionary_Column_DPR_cvr]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE CLUSTERED INDEX [IX_Dictionary_Column_DPR_cvr] ON [staging].[Dictionary_Column_DPR]
(
	[instance_name] ASC,
	[database_name] ASC,
	[schema_name] ASC,
	[table_name] ASC,
	[column_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Table [staging].[imperva_INFRASTRUCTURE_27Jun2017]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[imperva_INFRASTRUCTURE_27Jun2017](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inserted_at] [datetime] NULL,
	[Column_DB_Type] [nvarchar](1000) NULL,
	[Column_Discovery_Accuracy] [nvarchar](1000) NULL,
	[Column_Length] [nvarchar](1000) NULL,
	[Column_Name] [nvarchar](1000) NULL,
	[Data_Type] [nvarchar](1000) NULL,
	[DB_Name] [nvarchar](1000) NULL,
	[IP] [nvarchar](1000) NULL,
	[Schema_Name] [nvarchar](1000) NULL,
	[Table_Name] [nvarchar](1000) NULL,
	[Table_Type] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[imperva_MGM01_27Jun2017]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[imperva_MGM01_27Jun2017](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inserted_at] [datetime] NULL,
	[Column_DB_Type] [nvarchar](1000) NULL,
	[Column_Discovery_Accuracy] [nvarchar](1000) NULL,
	[Column_Length] [nvarchar](1000) NULL,
	[Column_Name] [nvarchar](1000) NULL,
	[Data_Type] [nvarchar](1000) NULL,
	[DB_Name] [nvarchar](1000) NULL,
	[IP] [nvarchar](1000) NULL,
	[Schema_Name] [nvarchar](1000) NULL,
	[Table_Name] [nvarchar](1000) NULL,
	[Table_Type] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[imperva_MGM02_27Jun2017]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[imperva_MGM02_27Jun2017](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inserted_at] [datetime] NULL,
	[Column_DB_Type] [nvarchar](1000) NULL,
	[Column_Discovery_Accuracy] [nvarchar](1000) NULL,
	[Column_Length] [nvarchar](1000) NULL,
	[Column_Name] [nvarchar](1000) NULL,
	[Data_Type] [nvarchar](1000) NULL,
	[DB_Name] [nvarchar](1000) NULL,
	[IP] [nvarchar](1000) NULL,
	[Schema_Name] [nvarchar](1000) NULL,
	[Table_Name] [nvarchar](1000) NULL,
	[Table_Type] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[imperva_SCRUB_27Jun2017]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[imperva_SCRUB_27Jun2017](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inserted_at] [datetime] NULL,
	[Column_DB_Type] [nvarchar](1000) NULL,
	[Column_Discovery_Accuracy] [nvarchar](1000) NULL,
	[Column_Length] [nvarchar](1000) NULL,
	[Column_Name] [nvarchar](1000) NULL,
	[Data_Type] [nvarchar](1000) NULL,
	[DB_Name] [nvarchar](1000) NULL,
	[IP] [nvarchar](1000) NULL,
	[Schema_Name] [nvarchar](1000) NULL,
	[Table_Name] [nvarchar](1000) NULL,
	[Table_Type] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[imperva_SHAREPOINT_27Jun2017]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[imperva_SHAREPOINT_27Jun2017](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inserted_at] [datetime] NULL,
	[Column_DB_Type] [nvarchar](1000) NULL,
	[Column_Discovery_Accuracy] [nvarchar](1000) NULL,
	[Column_Length] [nvarchar](1000) NULL,
	[Column_Name] [nvarchar](1000) NULL,
	[Data_Type] [nvarchar](1000) NULL,
	[DB_Name] [nvarchar](1000) NULL,
	[IP] [nvarchar](1000) NULL,
	[Schema_Name] [nvarchar](1000) NULL,
	[Table_Name] [nvarchar](1000) NULL,
	[Table_Type] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[NPPI_Production_Snapshot]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[NPPI_Production_Snapshot](
	[instance_name] [nvarchar](128) NOT NULL,
	[database_name] [nvarchar](128) NOT NULL,
	[schema_name] [sysname] NOT NULL,
	[table_name] [sysname] NOT NULL,
	[column_name] [nvarchar](128) NOT NULL,
	[is_pii] [bit] NOT NULL,
	[pii_type] [varchar](32) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[NPPI_Production_Snapshot_backup]    Script Date: 8/20/2018 9:10:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[NPPI_Production_Snapshot_backup](
	[instance_name] [nvarchar](128) NOT NULL,
	[database_name] [nvarchar](128) NOT NULL,
	[schema_name] [sysname] NOT NULL,
	[table_name] [sysname] NOT NULL,
	[column_name] [nvarchar](128) NOT NULL,
	[is_pii] [bit] NOT NULL,
	[pii_type] [varchar](32) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Cluster_cluster_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Cluster_cluster_name] ON [common].[Cluster]
(
	[cluster_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cluster_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Cluster_load_date] ON [common].[Cluster]
(
	[load_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Domain_domain_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Domain_domain_name] ON [common].[Domain]
(
	[domain_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Domain_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Domain_load_date] ON [common].[Domain]
(
	[load_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Environment_environment_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Environment_environment_name] ON [common].[Environment]
(
	[environment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Environment_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Environment_load_date] ON [common].[Environment]
(
	[load_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schedule_EnvironmentID_ScanTypeID_ScanIntervalID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schedule_EnvironmentID_ScanTypeID_ScanIntervalID] ON [common].[Schedule]
(
	[EnvironmentID] ASC,
	[ScanTypeID] ASC,
	[ScanIntervalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schedule_PlatformID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schedule_PlatformID] ON [common].[Schedule]
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Server_ClusterID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Server_ClusterID] ON [common].[Server]
(
	[ClusterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Server_DomainID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Server_DomainID] ON [common].[Server]
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Server_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Server_load_date] ON [common].[Server]
(
	[load_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Server_server_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Server_server_name] ON [common].[Server]
(
	[server_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_checks_dt_begin]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_checks_dt_begin] ON [log].[checks]
(
	[dt_begin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_checks_ScanTypeID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_checks_ScanTypeID] ON [log].[checks]
(
	[ScanTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_merges_source_table]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_merges_source_table] ON [log].[merges]
(
	[source_table] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_merges_target_table]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_merges_target_table] ON [log].[merges]
(
	[target_table] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_column_id]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_column_id] ON [mssql].[Column]
(
	[column_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_DatabaseID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_DatabaseID] ON [mssql].[Column]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_DomainID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_DomainID] ON [mssql].[Column]
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_eff_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_eff_date] ON [mssql].[Column]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_EnvironmentID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_EnvironmentID] ON [mssql].[Column]
(
	[EnvironmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_InstanceID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_InstanceID] ON [mssql].[Column]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_is_pii]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_is_pii] ON [mssql].[Column]
(
	[is_pii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_load_date] ON [mssql].[Column]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Column_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_name] ON [mssql].[Column]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_PlatformID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_PlatformID] ON [mssql].[Column]
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_SchemaID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_SchemaID] ON [mssql].[Column]
(
	[SchemaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_ServerID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_ServerID] ON [mssql].[Column]
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Column_TableID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Column_TableID] ON [mssql].[Column]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_database_id]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_database_id] ON [mssql].[Database]
(
	[database_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_DomainID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_DomainID] ON [mssql].[Database]
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_eff_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_eff_date] ON [mssql].[Database]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_EnvironmentID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_EnvironmentID] ON [mssql].[Database]
(
	[EnvironmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_InstanceID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_InstanceID] ON [mssql].[Database]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_load_date] ON [mssql].[Database]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Database_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_name] ON [mssql].[Database]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_PlatformID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_PlatformID] ON [mssql].[Database]
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Database_ServerID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Database_ServerID] ON [mssql].[Database]
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [UX_Database_InstanceID_database_id]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_Database_InstanceID_database_id] ON [mssql].[Database]
(
	[InstanceID] ASC,
	[database_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_File_eff_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_File_eff_date] ON [mssql].[File]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_File_FileGroupID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_File_FileGroupID] ON [mssql].[File]
(
	[FileGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_File_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_File_load_date] ON [mssql].[File]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_FileGroup_DatabaseID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_FileGroup_DatabaseID] ON [mssql].[FileGroup]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_FileGroup_eff_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_FileGroup_eff_date] ON [mssql].[FileGroup]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_FileGroup_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_FileGroup_load_date] ON [mssql].[FileGroup]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Instance_DomainID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_DomainID] ON [mssql].[Instance]
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Instance_eff_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_eff_date] ON [mssql].[Instance]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Instance_EnvironmentID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_EnvironmentID] ON [mssql].[Instance]
(
	[EnvironmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Instance_instance_name]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_instance_name] ON [mssql].[Instance]
(
	[instance_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Instance_load_date]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_load_date] ON [mssql].[Instance]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Instance_PlatformID]    Script Date: 8/20/2018 9:10:07 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_PlatformID] ON [mssql].[Instance]
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Instance_ServerID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Instance_ServerID] ON [mssql].[Instance]
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceConfig_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceConfig_eff_date] ON [mssql].[InstanceConfig]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceConfig_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceConfig_InstanceID] ON [mssql].[InstanceConfig]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceConfig_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceConfig_load_date] ON [mssql].[InstanceConfig]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceSysConfig_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceSysConfig_eff_date] ON [mssql].[InstanceSysConfig]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceSysConfig_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceSysConfig_InstanceID] ON [mssql].[InstanceSysConfig]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceSysConfig_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceSysConfig_load_date] ON [mssql].[InstanceSysConfig]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_InstanceSysConfig_SysConfigID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_InstanceSysConfig_SysConfigID] ON [mssql].[InstanceSysConfig]
(
	[SysConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Job_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Job_eff_date] ON [mssql].[Job]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Job_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Job_InstanceID] ON [mssql].[Job]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Job_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Job_load_date] ON [mssql].[Job]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_JobSnapshot_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_JobSnapshot_eff_date] ON [mssql].[JobSnapshot]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_JobSnapshot_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_JobSnapshot_InstanceID] ON [mssql].[JobSnapshot]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_JobSnapshot_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_JobSnapshot_load_date] ON [mssql].[JobSnapshot]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_JobStep_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_JobStep_eff_date] ON [mssql].[JobStep]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_JobStep_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_JobStep_InstanceID] ON [mssql].[JobStep]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_JobStep_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_JobStep_load_date] ON [mssql].[JobStep]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_AdHoc_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_AdHoc_eff_date] ON [mssql].[QueryStats_AdHoc]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_AdHoc_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_AdHoc_InstanceID] ON [mssql].[QueryStats_AdHoc]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_AdHoc_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_AdHoc_load_date] ON [mssql].[QueryStats_AdHoc]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopExecutions_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopExecutions_eff_date] ON [mssql].[QueryStats_TopExecutions]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopExecutions_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopExecutions_InstanceID] ON [mssql].[QueryStats_TopExecutions]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopExecutions_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopExecutions_load_date] ON [mssql].[QueryStats_TopExecutions]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopExecutions_DB_DatabaseID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopExecutions_DB_DatabaseID] ON [mssql].[QueryStats_TopExecutions_DB]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopExecutions_DB_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopExecutions_DB_eff_date] ON [mssql].[QueryStats_TopExecutions_DB]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopExecutions_DB_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopExecutions_DB_load_date] ON [mssql].[QueryStats_TopExecutions_DB]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopTime_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopTime_eff_date] ON [mssql].[QueryStats_TopTime]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopTime_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopTime_InstanceID] ON [mssql].[QueryStats_TopTime]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopTime_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopTime_load_date] ON [mssql].[QueryStats_TopTime]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopTime_DB_DatabaseID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopTime_DB_DatabaseID] ON [mssql].[QueryStats_TopTime_DB]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopTime_DB_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopTime_DB_eff_date] ON [mssql].[QueryStats_TopTime_DB]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueryStats_TopTime_DB_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_QueryStats_TopTime_DB_load_date] ON [mssql].[QueryStats_TopTime_DB]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Routine_DatabaseID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Routine_DatabaseID] ON [mssql].[Routine]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Routine_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Routine_eff_date] ON [mssql].[Routine]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Routine_SchemaID_i]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Routine_SchemaID_i] ON [mssql].[Routine]
(
	[SchemaID] ASC
)
INCLUDE ( 	[DatabaseID],
	[load_date],
	[ROUTINE_NAME]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_DatabaseID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_DatabaseID] ON [mssql].[Schema]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_DomainID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_DomainID] ON [mssql].[Schema]
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_eff_date] ON [mssql].[Schema]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_EnvironmentID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_EnvironmentID] ON [mssql].[Schema]
(
	[EnvironmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_InstanceID] ON [mssql].[Schema]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_load_date] ON [mssql].[Schema]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Schema_name]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_name] ON [mssql].[Schema]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_PlatformID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_PlatformID] ON [mssql].[Schema]
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Schema_ServerID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Schema_ServerID] ON [mssql].[Schema]
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_SysConfig_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_SysConfig_load_date] ON [mssql].[SysConfig]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_SysConfig_name]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_SysConfig_name] ON [mssql].[SysConfig]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_DatabaseID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_DatabaseID] ON [mssql].[Table]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_DatabaseID_SchemaID_object_id]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_DatabaseID_SchemaID_object_id] ON [mssql].[Table]
(
	[DatabaseID] ASC,
	[SchemaID] ASC,
	[object_id] ASC,
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_DomainID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_DomainID] ON [mssql].[Table]
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_eff_date] ON [mssql].[Table]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_EnvironmentID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_EnvironmentID] ON [mssql].[Table]
(
	[EnvironmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_InstanceID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_InstanceID] ON [mssql].[Table]
(
	[InstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_load_date] ON [mssql].[Table]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_name]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_name] ON [mssql].[Table]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_object_id]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_object_id] ON [mssql].[Table]
(
	[object_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_PlatformID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_PlatformID] ON [mssql].[Table]
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_SchemaID_i]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_SchemaID_i] ON [mssql].[Table]
(
	[SchemaID] ASC
)
INCLUDE ( 	[DatabaseID],
	[load_date],
	[name],
	[object_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_ServerID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Table_ServerID] ON [mssql].[Table]
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_TableStats_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_TableStats_eff_date] ON [mssql].[TableStats]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_TableStats_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_TableStats_load_date] ON [mssql].[TableStats]
(
	[load_date] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_TableStats_TableID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_TableStats_TableID] ON [mssql].[TableStats]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Trigger_DatabaseID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Trigger_DatabaseID] ON [mssql].[Trigger]
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Trigger_eff_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Trigger_eff_date] ON [mssql].[Trigger]
(
	[eff_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Trigger_load_date]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Trigger_load_date] ON [mssql].[Trigger]
(
	[load_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Trigger_SchemaID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Trigger_SchemaID] ON [mssql].[Trigger]
(
	[SchemaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [IX_Trigger_TableID]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_Trigger_TableID] ON [mssql].[Trigger]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
/****** Object:  Index [CCIX_NPPI_Production_Snapshot]    Script Date: 8/20/2018 9:10:08 AM ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCIX_NPPI_Production_Snapshot] ON [mssql].[NPPI_Production_Snapshot] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PRIMARY]
GO
ALTER TABLE [common].[Cluster] ADD  CONSTRAINT [DF_Cluster_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [common].[Domain] ADD  CONSTRAINT [DF_Domain_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [common].[Environment] ADD  CONSTRAINT [DF_Environment_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [common].[Platform] ADD  CONSTRAINT [DF_Platform_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [common].[Server] ADD  CONSTRAINT [DF_Server_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [log].[checks] ADD  CONSTRAINT [DF_checks_dt_begin]  DEFAULT (getdate()) FOR [dt_begin]
GO
ALTER TABLE [log].[checks] ADD  CONSTRAINT [DF_checks_dt_end]  DEFAULT (getdate()) FOR [dt_end]
GO
ALTER TABLE [log].[checks] ADD  CONSTRAINT [DF_checks_checked_by]  DEFAULT (suser_sname()) FOR [checked_by]
GO
ALTER TABLE [log].[imports] ADD  CONSTRAINT [DF_imports_dt_imported]  DEFAULT (getdate()) FOR [dt_imported]
GO
ALTER TABLE [log].[imports] ADD  CONSTRAINT [DF_imports_record_count]  DEFAULT ((0)) FOR [record_count]
GO
ALTER TABLE [log].[merges] ADD  CONSTRAINT [DF_merges_dt_merged]  DEFAULT (getdate()) FOR [dt_merged]
GO
ALTER TABLE [mssql].[Column] ADD  CONSTRAINT [DF_Column_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Column] ADD  CONSTRAINT [DF_Column_is_pii]  DEFAULT ((0)) FOR [is_pii]
GO
ALTER TABLE [mssql].[Database] ADD  CONSTRAINT [DF_Database_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Database] ADD  CONSTRAINT [DF_Database_is_nppi]  DEFAULT ((0)) FOR [is_nppi]
GO
ALTER TABLE [mssql].[File] ADD  CONSTRAINT [DF_File_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[FileGroup] ADD  CONSTRAINT [DF_FileGroup_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Instance] ADD  CONSTRAINT [DF_Instance_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Instance] ADD  CONSTRAINT [DF_Instance_DPE_Managed]  DEFAULT ((1)) FOR [dpe_managed]
GO
ALTER TABLE [mssql].[Instance] ADD  CONSTRAINT [DF_Instance_is_nppi]  DEFAULT ((0)) FOR [is_nppi]
GO
ALTER TABLE [mssql].[InstanceConfig] ADD  CONSTRAINT [DF_InstanceConfig_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[InstanceSysConfig] ADD  CONSTRAINT [DF_InstanceSysConfig_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Job] ADD  CONSTRAINT [DF_Job_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[JobSnapshot] ADD  CONSTRAINT [DF_JobSnapshot_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[JobStep] ADD  CONSTRAINT [DF_JobStep_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[QueryStats_AdHoc] ADD  CONSTRAINT [DF_QueryStats_AdHoc_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[QueryStats_TopExecutions] ADD  CONSTRAINT [DF_QueryStats_TopExecutions_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[QueryStats_TopExecutions_DB] ADD  CONSTRAINT [DF_QueryStats_TopExecutions_DB_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[QueryStats_TopTime] ADD  CONSTRAINT [DF_QueryStats_TopTime_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[QueryStats_TopTime_DB] ADD  CONSTRAINT [DF_QueryStats_TopTime_DB_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Routine] ADD  CONSTRAINT [DF__Routine__load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Schema] ADD  CONSTRAINT [DF_Schema_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[SysConfig] ADD  CONSTRAINT [DF_SysConfig_name]  DEFAULT (getdate()) FOR [name]
GO
ALTER TABLE [mssql].[Table] ADD  CONSTRAINT [DF_Table_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Table] ADD  CONSTRAINT [DF_Table_is_nppi]  DEFAULT ((0)) FOR [is_nppi]
GO
ALTER TABLE [mssql].[TableStats] ADD  CONSTRAINT [DF_TableStats_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [mssql].[Trigger] ADD  CONSTRAINT [DF_Trigger_load_date]  DEFAULT (getdate()) FOR [load_date]
GO
ALTER TABLE [staging].[imperva_INFRASTRUCTURE_27Jun2017] ADD  DEFAULT (getdate()) FOR [inserted_at]
GO
ALTER TABLE [staging].[imperva_MGM01_27Jun2017] ADD  DEFAULT (getdate()) FOR [inserted_at]
GO
ALTER TABLE [staging].[imperva_MGM02_27Jun2017] ADD  DEFAULT (getdate()) FOR [inserted_at]
GO
ALTER TABLE [staging].[imperva_SCRUB_27Jun2017] ADD  DEFAULT (getdate()) FOR [inserted_at]
GO
ALTER TABLE [staging].[imperva_SHAREPOINT_27Jun2017] ADD  DEFAULT (getdate()) FOR [inserted_at]
GO
ALTER TABLE [common].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedule_EnvironmentID_Environment_EnvironmentID] FOREIGN KEY([EnvironmentID])
REFERENCES [common].[Environment] ([EnvironmentID])
GO
ALTER TABLE [common].[Schedule] CHECK CONSTRAINT [FK_Schedule_EnvironmentID_Environment_EnvironmentID]
GO
ALTER TABLE [common].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedule_PlatformID_Platform_PlatformID] FOREIGN KEY([PlatformID])
REFERENCES [common].[Platform] ([PlatformID])
GO
ALTER TABLE [common].[Schedule] CHECK CONSTRAINT [FK_Schedule_PlatformID_Platform_PlatformID]
GO
ALTER TABLE [common].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedule_ScanIntervalID_ScanInterval_ScanIntervalID] FOREIGN KEY([ScanIntervalID])
REFERENCES [common].[ScanInterval] ([ScanIntervalID])
GO
ALTER TABLE [common].[Schedule] CHECK CONSTRAINT [FK_Schedule_ScanIntervalID_ScanInterval_ScanIntervalID]
GO
ALTER TABLE [common].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedule_ScanTypeID_ScanType_ScanTypeID] FOREIGN KEY([ScanTypeID])
REFERENCES [common].[ScanType] ([ScanTypeID])
GO
ALTER TABLE [common].[Schedule] CHECK CONSTRAINT [FK_Schedule_ScanTypeID_ScanType_ScanTypeID]
GO
ALTER TABLE [common].[Server]  WITH NOCHECK ADD  CONSTRAINT [FK_Server_ClusterID_Cluster_ClusterID] FOREIGN KEY([ClusterID])
REFERENCES [common].[Cluster] ([ClusterID])
GO
ALTER TABLE [common].[Server] CHECK CONSTRAINT [FK_Server_ClusterID_Cluster_ClusterID]
GO
ALTER TABLE [common].[Server]  WITH NOCHECK ADD  CONSTRAINT [FK_Server_DomainID_Domain_DomainID] FOREIGN KEY([DomainID])
REFERENCES [common].[Domain] ([DomainID])
GO
ALTER TABLE [common].[Server] CHECK CONSTRAINT [FK_Server_DomainID_Domain_DomainID]
GO
ALTER TABLE [log].[checks]  WITH CHECK ADD  CONSTRAINT [FK_checks_ScanTypeID_ScanType_ScanTypeID] FOREIGN KEY([ScanTypeID])
REFERENCES [common].[ScanType] ([ScanTypeID])
GO
ALTER TABLE [log].[checks] CHECK CONSTRAINT [FK_checks_ScanTypeID_ScanType_ScanTypeID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_DatabaseID_Database_DatabaseID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_DomainID_Domain_DomainID] FOREIGN KEY([DomainID])
REFERENCES [common].[Domain] ([DomainID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_DomainID_Domain_DomainID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_EnvironmentID_Environment_EnvironmentID] FOREIGN KEY([EnvironmentID])
REFERENCES [common].[Environment] ([EnvironmentID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_EnvironmentID_Environment_EnvironmentID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_PlatformID_Platform_PlatformID] FOREIGN KEY([PlatformID])
REFERENCES [common].[Platform] ([PlatformID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_PlatformID_Platform_PlatformID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_SchemaID_Schema_SchemaID] FOREIGN KEY([SchemaID])
REFERENCES [mssql].[Schema] ([SchemaID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_SchemaID_Schema_SchemaID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_ServerID_Server_ServerID] FOREIGN KEY([ServerID])
REFERENCES [common].[Server] ([ServerID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_ServerID_Server_ServerID]
GO
ALTER TABLE [mssql].[Column]  WITH CHECK ADD  CONSTRAINT [FK_Column_TableID_Table_TableID] FOREIGN KEY([TableID])
REFERENCES [mssql].[Table] ([TableID])
GO
ALTER TABLE [mssql].[Column] CHECK CONSTRAINT [FK_Column_TableID_Table_TableID]
GO
ALTER TABLE [mssql].[Database]  WITH CHECK ADD  CONSTRAINT [FK_Database_DomainID_Domain_DomainID] FOREIGN KEY([DomainID])
REFERENCES [common].[Domain] ([DomainID])
GO
ALTER TABLE [mssql].[Database] CHECK CONSTRAINT [FK_Database_DomainID_Domain_DomainID]
GO
ALTER TABLE [mssql].[Database]  WITH CHECK ADD  CONSTRAINT [FK_Database_EnvironmentID_Environment_EnvironmentID] FOREIGN KEY([EnvironmentID])
REFERENCES [common].[Environment] ([EnvironmentID])
GO
ALTER TABLE [mssql].[Database] CHECK CONSTRAINT [FK_Database_EnvironmentID_Environment_EnvironmentID]
GO
ALTER TABLE [mssql].[Database]  WITH CHECK ADD  CONSTRAINT [FK_Database_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[Database] CHECK CONSTRAINT [FK_Database_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[Database]  WITH CHECK ADD  CONSTRAINT [FK_Database_PlatformID_Platform_PlatformID] FOREIGN KEY([PlatformID])
REFERENCES [common].[Platform] ([PlatformID])
GO
ALTER TABLE [mssql].[Database] CHECK CONSTRAINT [FK_Database_PlatformID_Platform_PlatformID]
GO
ALTER TABLE [mssql].[Database]  WITH CHECK ADD  CONSTRAINT [FK_Database_ServerID_Server_ServerID] FOREIGN KEY([ServerID])
REFERENCES [common].[Server] ([ServerID])
GO
ALTER TABLE [mssql].[Database] CHECK CONSTRAINT [FK_Database_ServerID_Server_ServerID]
GO
ALTER TABLE [mssql].[File]  WITH CHECK ADD  CONSTRAINT [FK_File_FileGroupID_FileGroup_FileGroupID] FOREIGN KEY([FileGroupID])
REFERENCES [mssql].[FileGroup] ([FileGroupID])
GO
ALTER TABLE [mssql].[File] CHECK CONSTRAINT [FK_File_FileGroupID_FileGroup_FileGroupID]
GO
ALTER TABLE [mssql].[FileGroup]  WITH CHECK ADD  CONSTRAINT [FK_FileGroup_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[FileGroup] CHECK CONSTRAINT [FK_FileGroup_DatabaseID_Database_DatabaseID]
GO
ALTER TABLE [mssql].[Instance]  WITH CHECK ADD  CONSTRAINT [FK_Instance_DomainID_Domain_DomainID] FOREIGN KEY([DomainID])
REFERENCES [common].[Domain] ([DomainID])
GO
ALTER TABLE [mssql].[Instance] CHECK CONSTRAINT [FK_Instance_DomainID_Domain_DomainID]
GO
ALTER TABLE [mssql].[Instance]  WITH CHECK ADD  CONSTRAINT [FK_Instance_EnvironmentID_Environment_EnvironmentID] FOREIGN KEY([EnvironmentID])
REFERENCES [common].[Environment] ([EnvironmentID])
GO
ALTER TABLE [mssql].[Instance] CHECK CONSTRAINT [FK_Instance_EnvironmentID_Environment_EnvironmentID]
GO
ALTER TABLE [mssql].[Instance]  WITH CHECK ADD  CONSTRAINT [FK_Instance_PlatformID_Platform_PlatformID] FOREIGN KEY([PlatformID])
REFERENCES [common].[Platform] ([PlatformID])
GO
ALTER TABLE [mssql].[Instance] CHECK CONSTRAINT [FK_Instance_PlatformID_Platform_PlatformID]
GO
ALTER TABLE [mssql].[Instance]  WITH CHECK ADD  CONSTRAINT [FK_Instance_ServerID_Server_ServerID] FOREIGN KEY([ServerID])
REFERENCES [common].[Server] ([ServerID])
GO
ALTER TABLE [mssql].[Instance] CHECK CONSTRAINT [FK_Instance_ServerID_Server_ServerID]
GO
ALTER TABLE [mssql].[InstanceConfig]  WITH CHECK ADD  CONSTRAINT [FK_InstanceConfig_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[InstanceConfig] CHECK CONSTRAINT [FK_InstanceConfig_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[InstanceSysConfig]  WITH CHECK ADD  CONSTRAINT [FK_InstanceSysConfig_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[InstanceSysConfig] CHECK CONSTRAINT [FK_InstanceSysConfig_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[InstanceSysConfig]  WITH NOCHECK ADD  CONSTRAINT [FK_InstanceSysConfig_SysConfigID_SysConfig_SysConfigID] FOREIGN KEY([SysConfigID])
REFERENCES [mssql].[SysConfig] ([SysConfigID])
GO
ALTER TABLE [mssql].[InstanceSysConfig] CHECK CONSTRAINT [FK_InstanceSysConfig_SysConfigID_SysConfig_SysConfigID]
GO
ALTER TABLE [mssql].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[Job] CHECK CONSTRAINT [FK_Job_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[JobSnapshot]  WITH CHECK ADD  CONSTRAINT [FK_JobSnapshot_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[JobSnapshot] CHECK CONSTRAINT [FK_JobSnapshot_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[JobStep]  WITH CHECK ADD  CONSTRAINT [FK_JobStep_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[JobStep] CHECK CONSTRAINT [FK_JobStep_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[QueryStats_AdHoc]  WITH CHECK ADD  CONSTRAINT [FK_QueryStats_AdHoc_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[QueryStats_AdHoc] CHECK CONSTRAINT [FK_QueryStats_AdHoc_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[QueryStats_TopExecutions]  WITH CHECK ADD  CONSTRAINT [FK_QueryStats_TopExecutions_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[QueryStats_TopExecutions] CHECK CONSTRAINT [FK_QueryStats_TopExecutions_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[QueryStats_TopTime]  WITH CHECK ADD  CONSTRAINT [FK_QueryStats_TopTime_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[QueryStats_TopTime] CHECK CONSTRAINT [FK_QueryStats_TopTime_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[QueryStats_TopTime_DB]  WITH CHECK ADD  CONSTRAINT [FK_QueryStats_TopTime_DB_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[QueryStats_TopTime_DB] CHECK CONSTRAINT [FK_QueryStats_TopTime_DB_DatabaseID_Database_DatabaseID]
GO
ALTER TABLE [mssql].[Routine]  WITH CHECK ADD  CONSTRAINT [FK_Routine_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[Routine] CHECK CONSTRAINT [FK_Routine_DatabaseID_Database_DatabaseID]
GO
ALTER TABLE [mssql].[Routine]  WITH CHECK ADD  CONSTRAINT [FK_Routine_SchemaID_Schema_SchemaID] FOREIGN KEY([SchemaID])
REFERENCES [mssql].[Schema] ([SchemaID])
GO
ALTER TABLE [mssql].[Routine] CHECK CONSTRAINT [FK_Routine_SchemaID_Schema_SchemaID]
GO
ALTER TABLE [mssql].[Schema]  WITH CHECK ADD  CONSTRAINT [FK_Schema_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[Schema] CHECK CONSTRAINT [FK_Schema_DatabaseID_Database_DatabaseID]
GO
ALTER TABLE [mssql].[Schema]  WITH CHECK ADD  CONSTRAINT [FK_Schema_DomainID_Domain_DomainID] FOREIGN KEY([DomainID])
REFERENCES [common].[Domain] ([DomainID])
GO
ALTER TABLE [mssql].[Schema] CHECK CONSTRAINT [FK_Schema_DomainID_Domain_DomainID]
GO
ALTER TABLE [mssql].[Schema]  WITH CHECK ADD  CONSTRAINT [FK_Schema_EnvironmentID_Environment_EnvironmentID] FOREIGN KEY([EnvironmentID])
REFERENCES [common].[Environment] ([EnvironmentID])
GO
ALTER TABLE [mssql].[Schema] CHECK CONSTRAINT [FK_Schema_EnvironmentID_Environment_EnvironmentID]
GO
ALTER TABLE [mssql].[Schema]  WITH CHECK ADD  CONSTRAINT [FK_Schema_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[Schema] CHECK CONSTRAINT [FK_Schema_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[Schema]  WITH CHECK ADD  CONSTRAINT [FK_Schema_PlatformID_Platform_PlatformID] FOREIGN KEY([PlatformID])
REFERENCES [common].[Platform] ([PlatformID])
GO
ALTER TABLE [mssql].[Schema] CHECK CONSTRAINT [FK_Schema_PlatformID_Platform_PlatformID]
GO
ALTER TABLE [mssql].[Schema]  WITH CHECK ADD  CONSTRAINT [FK_Schema_ServerID_Server_ServerID] FOREIGN KEY([ServerID])
REFERENCES [common].[Server] ([ServerID])
GO
ALTER TABLE [mssql].[Schema] CHECK CONSTRAINT [FK_Schema_ServerID_Server_ServerID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_DatabaseID_Database_DatabaseID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_DomainID_Domain_DomainID] FOREIGN KEY([DomainID])
REFERENCES [common].[Domain] ([DomainID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_DomainID_Domain_DomainID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_EnvironmentID_Environment_EnvironmentID] FOREIGN KEY([EnvironmentID])
REFERENCES [common].[Environment] ([EnvironmentID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_EnvironmentID_Environment_EnvironmentID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_InstanceID_Instance_InstanceID] FOREIGN KEY([InstanceID])
REFERENCES [mssql].[Instance] ([InstanceID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_InstanceID_Instance_InstanceID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_PlatformID_Platform_PlatformID] FOREIGN KEY([PlatformID])
REFERENCES [common].[Platform] ([PlatformID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_PlatformID_Platform_PlatformID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_SchemaID_Schema_SchemaID] FOREIGN KEY([SchemaID])
REFERENCES [mssql].[Schema] ([SchemaID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_SchemaID_Schema_SchemaID]
GO
ALTER TABLE [mssql].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_ServerID_Server_ServerID] FOREIGN KEY([ServerID])
REFERENCES [common].[Server] ([ServerID])
GO
ALTER TABLE [mssql].[Table] CHECK CONSTRAINT [FK_Table_ServerID_Server_ServerID]
GO
ALTER TABLE [mssql].[TableStats]  WITH CHECK ADD  CONSTRAINT [FK_TableStats_TableID_Table_TableID] FOREIGN KEY([TableID])
REFERENCES [mssql].[Table] ([TableID])
GO
ALTER TABLE [mssql].[TableStats] CHECK CONSTRAINT [FK_TableStats_TableID_Table_TableID]
GO
ALTER TABLE [mssql].[Trigger]  WITH CHECK ADD  CONSTRAINT [FK_Trigger_DatabaseID_Database_DatabaseID] FOREIGN KEY([DatabaseID])
REFERENCES [mssql].[Database] ([DatabaseID])
GO
ALTER TABLE [mssql].[Trigger] CHECK CONSTRAINT [FK_Trigger_DatabaseID_Database_DatabaseID]
GO
/****** Object:  StoredProcedure [mssql].[pr_CompareInstanceBase]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [mssql].[pr_CompareInstanceBase] (
	@source nvarchar(128),
	@destination nvarchar(128)
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_CompareInstanceBase
-- Author:		Phillip Beazley
-- Date:		06/22/2017
--
-- Purpose:		Compares the configuration between two instances (such as prod vs uat datawarehouse).
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 05/30/2017	pbeazley	Initial release.
-- 06/22/2017	pbeazley	Updated to use base views.
-----------------------------------------------------------------------------------------------------------------------

select
	[name] = @source,
	[edition],
	[version],
	[product_level],
	[bit_level],
	[assigned_cpu],
	[assigned_ram],
	[is_clustered]
from
	mssql.[vw_InstanceConfig] [ic]
	inner join mssql.[vw_Instance] [i] on ic.[InstanceID] = i.[InstanceID]
where
	i.[instance_name] = @source

union

select
	[name] = @destination,
	[edition],
	[version],
	[product_level],
	[bit_level],
	[assigned_cpu],
	[assigned_ram],
	[is_clustered]
from
	mssql.[vw_InstanceConfig] [ic]
	inner join mssql.[vw_Instance] [i] on ic.[InstanceID] = i.[InstanceID]
where
	i.[instance_name] = @destination

--with [source] as (
--	select
--		[z] = 1,
--		[name] = @source,
--		[edition],
--		[version],
--		[product_level],
--		[bit_level],
--		[assigned_cpu],
--		[assigned_ram],
--		[is_clustered]
--	from
--		mssql.[vw_InstanceConfig] [ic]
--		inner join mssql.[vw_Instance] [i] on ic.[InstanceID] = i.[InstanceID]
--	where
--		i.[instance_name] = @source
--),
--[destination] as (
--	select
--		[z] = 1,
--		[edition],
--		[version],
--		[product_level],
--		[bit_level],
--		[assigned_cpu],
--		[assigned_ram],
--		[is_clustered]
--	from
--		mssql.[vw_InstanceConfig] [ic]
--		inner join mssql.[vw_Instance] [i] on ic.[InstanceID] = i.[InstanceID]
--	where
--		i.[instance_name] = @destination
--)
--select
--	[source] = @source,
--	[source_edition] = source.[edition],
--	[source_version] = source.[version],
--	[source_product_level] = source.[product_level],
--	[source_bit_level] = source.[bit_level],
--	[source_assigned_cpu] = source.[assigned_cpu],
--	[source_assigned_ram] = source.[assigned_ram],
--	[source_is_clustered] = source.[is_clustered],
--	[destination] = @destination,
--	[destination_edition] = destination.[edition],
--	[destination_version] = destination.[version],
--	[destination_product_level] = destination.[product_level],
--	[destination_bit_level] = destination.[bit_level],
--	[destination_assigned_cpu] = destination.[assigned_cpu],
--	[destination_assigned_ram] = destination.[assigned_ram],
--	[destination_is_clustered] = destination.[is_clustered]
--from
--	[source]
--	left outer join [destination] on source.[z] = destination.[z]
--order by
--	source.[name] asc ;

end

GO
/****** Object:  StoredProcedure [mssql].[pr_CompareInstanceDatabases]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [mssql].[pr_CompareInstanceDatabases] (
	@source nvarchar(128),
	@destination nvarchar(128)
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_CompareInstanceDatabases
-- Author:		Phillip Beazley
-- Date:		06/22/2017
--
-- Purpose:		Compares the databases between two instances (such as prod vs uat datawarehouse).
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 05/26/2017	pbeazley	Initial release.
-- 06/22/2017	pbeazley	Updated to use base views.
-----------------------------------------------------------------------------------------------------------------------

with [source] as (
	select
		d.[name],
		d.[create_date],
		[size] = Sum([table_size_mb]),
		[rows] = Sum([row_count])
	from
		mssql.[vw_Database] [d]
		inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
		inner join mssql.[vw_Table] [t] on d.[DatabaseID] = t.[DatabaseID]
		inner join mssql.[vw_TableStats] [ts] on t.[TableID] = ts.[TableID]
	where
		i.[instance_name] = @source
	group by
		d.[name],
		d.[create_date]
),
[destination] as (
	select
		d.[name],
		d.[create_date],
		[size] = Sum([table_size_mb]),
		[rows] = Sum([row_count])
	from
		mssql.[vw_Database] [d]
		inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
		inner join mssql.[vw_Table] [t] on d.[DatabaseID] = t.[DatabaseID]
		inner join mssql.[vw_TableStats] [ts] on t.[TableID] = ts.[TableID]
	where
		i.[instance_name] = @destination
	group by
		d.[name],
		d.[create_date]
)
select
	[database] = source.[name],
	[source_create_date] = source.[create_date],
	[?] = case
		when source.[create_date] < destination.[create_date] then '<'
		when source.[create_date] = destination.[create_date] then '='
		else '>'
	end,
	[destination_create_date] = destination.[create_date],
	[|] = '',
	[source_size_gb] = Cast(source.[size] / 1024.0 as decimal(10,2)),
	[?] = case
		when source.[size] < destination.[size] then '<'
		when source.[size] = destination.[size] then '='
		else '>'
	end,
	[/\] = case
		when destination.[size] = 0 then 100
		when destination.[size] is not null then Cast((source.[size] * 1.0 / destination.[size] * 1.0) * 100.0 as decimal(10,2))
		else null
	end,
	[destination_size_gb] = Cast(destination.[size] / 1024.0 as decimal(10,2)),
	[|] = '',
	[source_rows_m] = Cast(source.[rows] / 1000000.0 as decimal(10,2)),
	[?] = case
		when source.[rows] < destination.[rows] then '<'
		when source.[rows] = destination.[rows] then '='
		else '>'
	end,
	[/\] = case
		when destination.[rows] = 0 then 100
		when destination.[rows] is not null then Cast((source.[rows] * 1.0 / destination.[rows] * 1.0) * 100.0 as decimal(10,2))
		else null
	end,
	[destination_rows_m] = Cast(destination.[rows] / 1000000.0 as decimal(10,2))
from
	[source]
	left outer join [destination] on source.[name] = destination.[name]
order by
	source.[name] asc ;

end

GO
/****** Object:  StoredProcedure [mssql].[pr_PurgeBatch]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [mssql].[pr_PurgeBatch] (
	@id int
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_PurgeBatch
-- Author:		Phillip Beazley
-- Date:		07/20/2017
--
-- Purpose:		Provides a method to remove the collected results from a specific batch.
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 07/20/2017	pbeazley	Initial release.
-----------------------------------------------------------------------------------------------------------------------

declare
	@load_date varchar(32),
	@dt_begin datetime2(2),
	@dt_end datetime2(2) ;

select
	@dt_begin = [dt_begin],
	@dt_end = [dt_end]
from
	log.[checks]
where
	[id] = @id ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[Trigger] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[Trigger] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[Trigger] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[Trigger] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[Routine] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[Routine] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[Routine] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[Routine] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[Column] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[Column] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[Column] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[Column] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[TableStats] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[TableStats] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[TableStats] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[TableStats] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[Table] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[Table] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[Table] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[Table] ;

--declare bCursor cursor local fast_forward for
--select distinct [load_date] from mssql.[Schema] where [load_date] between @dt_begin and @dt_end ;
--open bCursor ;

--fetch next from bCursor into @load_date ;
--while @@FETCH_STATUS = 0
--begin

--	raiserror('delete from mssql.[Schema] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
--	delete from mssql.[Schema] where [load_date] = @load_date ;

--	fetch next from bCursor into @load_date ;
--end

--close bCursor ;
--deallocate bCursor ;

update statistics mssql.[Schema] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[File] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[File] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[File] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[File] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[FileGroup] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[FileGroup] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[FileGroup] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[FileGroup] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[QueryStats_AdHoc] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[QueryStats_AdHoc] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[QueryStats_AdHoc] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[QueryStats_AdHoc] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[QueryStats_TopExecutions] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[QueryStats_TopExecutions] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[QueryStats_TopExecutions] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[QueryStats_TopExecutions] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[QueryStats_TopExecutions_DB] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[QueryStats_TopExecutions_DB] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[QueryStats_TopExecutions_DB] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[QueryStats_TopExecutions_DB] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[QueryStats_TopTime] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[QueryStats_TopTime] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[QueryStats_TopTime] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[QueryStats_TopTime] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[QueryStats_TopTime_DB] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[QueryStats_TopTime_DB] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[QueryStats_TopTime_DB] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[QueryStats_TopTime_DB] ;

--declare bCursor cursor local fast_forward for
--select distinct [load_date] from mssql.[Database] where [load_date] between @dt_begin and @dt_end ;
--open bCursor ;

--fetch next from bCursor into @load_date ;
--while @@FETCH_STATUS = 0
--begin

--	raiserror('delete from mssql.[Database] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
--	delete from mssql.[Database] where [load_date] = @load_date ;

--	fetch next from bCursor into @load_date ;
--end

--close bCursor ;
--deallocate bCursor ;

update statistics mssql.[Database] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[InstanceConfig] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[InstanceConfig] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[InstanceConfig] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[InstanceConfig] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[Job] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[Job] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[Job] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[Job] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[JobSnapshot] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[JobSnapshot] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[JobSnapshot] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[JobSnapshot] ;

declare bCursor cursor local fast_forward for
select distinct [load_date] from mssql.[JobStep] where [load_date] between @dt_begin and @dt_end ;
open bCursor ;

fetch next from bCursor into @load_date ;
while @@FETCH_STATUS = 0
begin

	raiserror('delete from mssql.[JobStep] where [load_date] = ''%s'' ;', 10, 1, @load_date) with nowait ;
	delete from mssql.[JobStep] where [load_date] = @load_date ;

	fetch next from bCursor into @load_date ;
end

close bCursor ;
deallocate bCursor ;

update statistics mssql.[JobStep] ;

end

GO
/****** Object:  StoredProcedure [mssql].[pr_ShowColumns]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [mssql].[pr_ShowColumns] (
	@instance_name nvarchar(128) = null,
	@database_name nvarchar(128) = null,
	@schema_name nvarchar(128) = 'dbo',
	@table_name nvarchar(128) = null,
	@column_name nvarchar(128) = null
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_ShowColumns
-- Author:		Phillip Beazley
-- Date:		08/04/2017
--
-- Purpose:		Shows the columns by instance, database, schema, table.
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 08/04/2017	pbeazley	Initial release.
-----------------------------------------------------------------------------------------------------------------------

select
	i.[instance_name],
	[database_name] = d.[name],
	[schema_name] = s.[name],
	[table_name] = t.[name],
	t.[type_desc],
	c.[name]
from
	mssql.[vw_Column] [c]
	inner join mssql.[vw_Table] [t] on c.[TableID] = t.[TableID]
	inner join mssql.[vw_Schema] [s] on t.[SchemaID] = s.[SchemaID]
	inner join mssql.[vw_Database] [d] on s.[DatabaseID] = d.[DatabaseID]
	inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
where
	(
		@instance_name is null
		or i.[alias] = @instance_name
		or i.[instance_name] = @instance_name
	)
	and (@database_name is null or d.[name] = @database_name)
	and (@schema_name is null or s.[name] = @schema_name)
	and (@table_name is null or t.[name] like @table_name)
	and (@column_name is null or c.[name] like @column_name)
order by
	i.[instance_name] asc,
	d.[name] asc,
	s.[name] asc,
	t.[name] asc,
	c.[name] asc ;

end

GO
/****** Object:  StoredProcedure [mssql].[pr_ShowRoutines]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [mssql].[pr_ShowRoutines] (
	@instance_name nvarchar(128) = null,
	@database_name nvarchar(128) = null,
	@schema_name nvarchar(128) = 'dbo',
	@routine_name nvarchar(128) = null
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_ShowRoutines
-- Author:		Phillip Beazley
-- Date:		07/17/2017
--
-- Purpose:		Shows the routines by instance, database, schema.
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 06/22/2017	pbeazley	Initial release.
-- 06/29/2017	pbeazley	Added wildcard support for routine name.
-- 06/29/2017	pbeazley	Added output routine type.
-- 07/17/2017	pbeazley	Added trigger support.
-----------------------------------------------------------------------------------------------------------------------

select
	i.[instance_name],
	[database_name] = d.[name],
	[schema_name] = s.[name],
	r.[routine_name],
	r.[routine_type] collate SQL_Latin1_General_CP1_CI_AS
from
	mssql.[vw_Routine] [r]
	inner join mssql.[vw_Schema] [s] on r.[SchemaID] = s.[SchemaID]
	inner join mssql.[vw_Database] [d] on s.[DatabaseID] = d.[DatabaseID]
	inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
where
	(
		@instance_name is null
		or i.[alias] = @instance_name
		or i.[instance_name] = @instance_name
	)
	and (@database_name is null or d.[name] = @database_name)
	and (@schema_name is null or s.[name] = @schema_name)
	and (@routine_name is null or r.[routine_name] like @routine_name)

union

select
	i.[instance_name],
	[database_name] = d.[name],
	[schema_name] = s.[name],
	[routine_name] = tr.[name],
	[routine_type] = tr.[type_desc] collate SQL_Latin1_General_CP1_CI_AS
from
	mssql.[vw_Trigger] [tr]
	inner join mssql.[vw_Schema] [s] on tr.[SchemaID] = s.[SchemaID]
	inner join mssql.[vw_Database] [d] on s.[DatabaseID] = d.[DatabaseID]
	inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
where
	(
		@instance_name is null
		or i.[alias] = @instance_name
		or i.[instance_name] = @instance_name
	)
	and (@database_name is null or d.[name] = @database_name)
	and (@schema_name is null or s.[name] = @schema_name)
	and (@routine_name is null or tr.[name] like @routine_name)

order by
	i.[instance_name] asc,
	d.[name] asc,
	s.[name] asc,
	[routine_name] asc ;

end
GO
/****** Object:  StoredProcedure [mssql].[pr_ShowTables]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [mssql].[pr_ShowTables] (
	@instance_name nvarchar(128) = null,
	@database_name nvarchar(128) = null,
	@schema_name nvarchar(128) = 'dbo',
	@table_name nvarchar(128) = null
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_ShowTables
-- Author:		Phillip Beazley
-- Date:		06/29/2017
--
-- Purpose:		Shows the tables by instance, database, schema.
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 06/22/2017	pbeazley	Initial release.
-- 06/29/2017	pbeazley	Added wildcard support for table name.
-- 06/29/2017	pbeazley	Added output type description.
-----------------------------------------------------------------------------------------------------------------------

select
	i.[instance_name],
	[database_name] = d.[name],
	[schema_name] = s.[name],
	[table_name] = t.[name],
	t.[type_desc]
from
	mssql.[vw_Table] [t]
	inner join mssql.[vw_Schema] [s] on t.[SchemaID] = s.[SchemaID]
	inner join mssql.[vw_Database] [d] on s.[DatabaseID] = d.[DatabaseID]
	inner join mssql.[vw_Instance] [i] on d.[InstanceID] = i.[InstanceID]
where
	(
		@instance_name is null
		or i.[alias] = @instance_name
		or i.[instance_name] = @instance_name
	)
	and (@database_name is null or d.[name] = @database_name)
	and (@schema_name is null or s.[name] = @schema_name)
	and (@table_name is null or t.[name] like @table_name)
order by
	i.[instance_name] asc,
	d.[name] asc,
	s.[name] asc,
	t.[name] asc ;

end

GO
/****** Object:  StoredProcedure [mssql].[pr_TuningCandidates]    Script Date: 8/20/2018 9:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [mssql].[pr_TuningCandidates] (
	@instance nvarchar(128),
	@database nvarchar(128) = null
)
as
begin

set nocount, xact_abort on ;

-----------------------------------------------------------------------------------------------------------------------
-- Procedure:	pr_TuningCandidates
-- Author:		Phillip Beazley
-- Date:		06/22/2017
--
-- Purpose:		Provides a current list of top 20 most expensive queries by instance, and optionally, database.
--
-- Depends:		DPR
--
-- REVISION HISTORY ---------------------------------------------------------------------------------------------------
-- 05/19/2017	pbeazley	Initial release.
-- 06/22/2017	pbeazley	Updated to use base views.
-- 07/27/2017	pbeazley	Updated to allow passing an alias for the instance name.
-----------------------------------------------------------------------------------------------------------------------

declare @InstanceID int = (select [InstanceID] from mssql.[vw_Instance] where [instance_name] = @Instance or [alias] = @Instance) ;

select
	[type] = 'Instance: Ad-Hoc', [rank], [load_date], [text], [usecounts], [mb]
from
	mssql.[vw_QueryStats_AdHoc]
where
	[InstanceID] = @InstanceID
	and [load_date] = (select Max([load_date]) from mssql.[vw_QueryStats_AdHoc] where [InstanceID] = @InstanceID) ;

select
	[type] = 'Instance: Top Exec', [rank], [load_date], [text], [execution_count], [total_worker_time], [average_worker_time]
from
	mssql.[vw_QueryStats_TopExecutions]
where
	[InstanceID] = @InstanceID
	and [load_date] = (select Max([load_date]) from mssql.[vw_QueryStats_TopExecutions] where [InstanceID] = @InstanceID) ;

select
	[type] = 'Instance: Top Time', [rank], [load_date], [text], [execution_count], [total_worker_time], [average_worker_time]
from
	mssql.[vw_QueryStats_TopTime]
where
	[InstanceID] = @InstanceID
	and [load_date] = (select Max([load_date]) from mssql.[vw_QueryStats_TopTime] where [InstanceID] = @InstanceID) ;

-- specific database

declare @DatabaseID int = (select [DatabaseID] from mssql.[vw_Database] where [InstanceID] = @InstanceID and [name] = @Database and [load_date] = (select Max([load_date]) from mssql.[vw_Database] where [InstanceID] = @InstanceID)) ;

select
	[type] = 'Database: Top Exec', [rank], [load_date], [text], [execution_count], [total_worker_time], [average_worker_time]
from
	mssql.[vw_QueryStats_TopExecutions_DB] 
where
	[DatabaseID] = @DatabaseID
	and [load_date] = (select Max([load_date]) from mssql.[vw_QueryStats_TopExecutions_DB] where [DatabaseID] = @DatabaseID) ;

select
	[type] = 'Database: Top Time', [rank], [load_date], [text], [execution_count], [total_worker_time], [average_worker_time]
from
	mssql.[vw_QueryStats_TopTime_DB]
where
	[DatabaseID] = @DatabaseID
	and [load_date] = (select Max([load_date]) from mssql.[vw_QueryStats_TopTime_DB] where [DatabaseID] = @DatabaseID) ;

end

GO
USE [master]
GO
ALTER DATABASE [DPR] SET  READ_WRITE 
GO
