/*
Copyright (c) 2000-2013 "independIT Integrative Technologies GmbH",
Authors: Ronald Jeninga, Dieter Stubler

schedulix Enterprise Job Scheduling System

independIT Integrative Technologies GmbH [http://www.independit.de]
mailto:contact@independit.de

This file is part of schedulix

schedulix is free software: 
you can redistribute it and/or modify it under the terms of the 
GNU Affero General Public License as published by the 
Free Software Foundation, either version 3 of the License, 
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
ALTER TABLE OBJECT_COMMENT
    ADD `TAG` varchar(64);
DROP VIEW SCI_C_OBJECT_COMMENT;
DROP VIEW SCI_V_OBJECT_COMMENT;
CREATE VIEW SCI_C_OBJECT_COMMENT AS
SELECT
    ID
    , `OBJECT_ID`                    AS `OBJECT_ID`
    , CASE `OBJECT_TYPE` WHEN 9 THEN 'JOB_DEFINITION' WHEN 2 THEN 'EXIT_STATE_DEFINITION' WHEN 3 THEN 'EXIT_STATE_PROFILE' WHEN 4 THEN 'EXIT_STATE_MAPPING' WHEN 5 THEN 'EXIT_STATE_TRANSLATION' WHEN 6 THEN 'FOLDER' WHEN 15 THEN 'SCOPE' WHEN 10 THEN 'NAMED_RESOURCE' WHEN 31 THEN 'NICE_PROFILE' WHEN 11 THEN 'RESOURCE' WHEN 1 THEN 'ENVIRONMENT' WHEN 7 THEN 'FOOTPRINT' WHEN 13 THEN 'RESOURCE_STATE_DEFINITION' WHEN 14 THEN 'RESOURCE_STATE_PROFILE' WHEN 12 THEN 'RESOURCE_STATE_MAPPING' WHEN 8 THEN 'USER' WHEN 16 THEN 'TRIGGER' WHEN 17 THEN 'JOB' WHEN 18 THEN 'EVENT' WHEN 19 THEN 'INTERVAL' WHEN 20 THEN 'SCHEDULE' WHEN 22 THEN 'SCHEDULED_EVENT' WHEN 21 THEN 'GROUP' WHEN 23 THEN 'PARAMETER' WHEN 24 THEN 'POOL' WHEN 25 THEN 'DISTRIBUTION' WHEN 29 THEN 'WATCH_TYPE' WHEN 30 THEN 'OBJECT_MONITOR' END AS `OBJECT_TYPE`
    , CASE `INFO_TYPE` WHEN 0 THEN 'TEXT' WHEN 1 THEN 'URL' END AS `INFO_TYPE`
    , `SEQUENCE_NUMBER`              AS `SEQUENCE_NUMBER`
    , `TAG`                          AS `TAG`
    , `DESCRIPTION`                  AS `DESCRIPTION`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
  FROM OBJECT_COMMENT
 WHERE VALID_TO = 9223372036854775807;
CREATE VIEW SCI_V_OBJECT_COMMENT AS
SELECT
    ID
    , `OBJECT_ID`                    AS `OBJECT_ID`
    , CASE `OBJECT_TYPE` WHEN 9 THEN 'JOB_DEFINITION' WHEN 2 THEN 'EXIT_STATE_DEFINITION' WHEN 3 THEN 'EXIT_STATE_PROFILE' WHEN 4 THEN 'EXIT_STATE_MAPPING' WHEN 5 THEN 'EXIT_STATE_TRANSLATION' WHEN 6 THEN 'FOLDER' WHEN 15 THEN 'SCOPE' WHEN 10 THEN 'NAMED_RESOURCE' WHEN 31 THEN 'NICE_PROFILE' WHEN 11 THEN 'RESOURCE' WHEN 1 THEN 'ENVIRONMENT' WHEN 7 THEN 'FOOTPRINT' WHEN 13 THEN 'RESOURCE_STATE_DEFINITION' WHEN 14 THEN 'RESOURCE_STATE_PROFILE' WHEN 12 THEN 'RESOURCE_STATE_MAPPING' WHEN 8 THEN 'USER' WHEN 16 THEN 'TRIGGER' WHEN 17 THEN 'JOB' WHEN 18 THEN 'EVENT' WHEN 19 THEN 'INTERVAL' WHEN 20 THEN 'SCHEDULE' WHEN 22 THEN 'SCHEDULED_EVENT' WHEN 21 THEN 'GROUP' WHEN 23 THEN 'PARAMETER' WHEN 24 THEN 'POOL' WHEN 25 THEN 'DISTRIBUTION' WHEN 29 THEN 'WATCH_TYPE' WHEN 30 THEN 'OBJECT_MONITOR' END AS `OBJECT_TYPE`
    , CASE `INFO_TYPE` WHEN 0 THEN 'TEXT' WHEN 1 THEN 'URL' END AS `INFO_TYPE`
    , `SEQUENCE_NUMBER`              AS `SEQUENCE_NUMBER`
    , `TAG`                          AS `TAG`
    , `DESCRIPTION`                  AS `DESCRIPTION`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
    , VALID_FROM
    , VALID_TO
  FROM OBJECT_COMMENT;
ALTER TABLE PARAMETER_DEFINITION
    ADD `EXPORT_NAME` varchar(64);
DROP VIEW SCI_C_PARAMETER_DEFINITION;
DROP VIEW SCI_V_PARAMETER_DEFINITION;
CREATE VIEW SCI_C_PARAMETER_DEFINITION AS
SELECT
    ID
    , `SE_ID`                        AS `SE_ID`
    , `NAME`                         AS `NAME`
    , CASE `TYPE` WHEN 10 THEN 'REFERENCE' WHEN 20 THEN 'CHILDREFERENCE' WHEN 30 THEN 'CONSTANT' WHEN 40 THEN 'RESULT' WHEN 50 THEN 'PARAMETER' WHEN 60 THEN 'EXPRESSION' WHEN 70 THEN 'IMPORT' WHEN 80 THEN 'DYNAMIC' WHEN 81 THEN 'DYNAMICVALUE' WHEN 90 THEN 'LOCAL_CONSTANT' WHEN 91 THEN 'RESOURCEREFERENCE' END AS `TYPE`
    , CASE `AGG_FUNCTION` WHEN 0 THEN 'NONE' WHEN 61 THEN 'AVG' WHEN 62 THEN 'COUNT' WHEN 63 THEN 'MIN' WHEN 64 THEN 'MAX' WHEN 65 THEN 'SUM' END AS `AGG_FUNCTION`
    , `DEFAULTVALUE`                 AS `DEFAULTVALUE`
    , CASE `IS_LOCAL` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_LOCAL`
    , `LINK_PD_ID`                   AS `LINK_PD_ID`
    , `EXPORT_NAME`                  AS `EXPORT_NAME`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
  FROM PARAMETER_DEFINITION
 WHERE VALID_TO = 9223372036854775807;
CREATE VIEW SCI_V_PARAMETER_DEFINITION AS
SELECT
    ID
    , `SE_ID`                        AS `SE_ID`
    , `NAME`                         AS `NAME`
    , CASE `TYPE` WHEN 10 THEN 'REFERENCE' WHEN 20 THEN 'CHILDREFERENCE' WHEN 30 THEN 'CONSTANT' WHEN 40 THEN 'RESULT' WHEN 50 THEN 'PARAMETER' WHEN 60 THEN 'EXPRESSION' WHEN 70 THEN 'IMPORT' WHEN 80 THEN 'DYNAMIC' WHEN 81 THEN 'DYNAMICVALUE' WHEN 90 THEN 'LOCAL_CONSTANT' WHEN 91 THEN 'RESOURCEREFERENCE' END AS `TYPE`
    , CASE `AGG_FUNCTION` WHEN 0 THEN 'NONE' WHEN 61 THEN 'AVG' WHEN 62 THEN 'COUNT' WHEN 63 THEN 'MIN' WHEN 64 THEN 'MAX' WHEN 65 THEN 'SUM' END AS `AGG_FUNCTION`
    , `DEFAULTVALUE`                 AS `DEFAULTVALUE`
    , CASE `IS_LOCAL` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_LOCAL`
    , `LINK_PD_ID`                   AS `LINK_PD_ID`
    , `EXPORT_NAME`                  AS `EXPORT_NAME`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
    , VALID_FROM
    , VALID_TO
  FROM PARAMETER_DEFINITION;
ALTER TABLE SCHEDULING_HIERARCHY
    ADD `IS_DISABLED` integer NOT NULL DEFAULT 0;
DROP VIEW SCI_C_SCHEDULING_HIERARCHY;
DROP VIEW SCI_V_SCHEDULING_HIERARCHY;
CREATE VIEW SCI_C_SCHEDULING_HIERARCHY AS
SELECT
    ID
    , `SE_PARENT_ID`                 AS `SE_PARENT_ID`
    , `SE_CHILD_ID`                  AS `SE_CHILD_ID`
    , `ALIAS_NAME`                   AS `ALIAS_NAME`
    , CASE `IS_STATIC` WHEN 1 THEN 'STATIC' WHEN 0 THEN 'DYNAMIC' END AS `IS_STATIC`
    , CASE `IS_DISABLED` WHEN 0 THEN 'ENABLED' WHEN 1 THEN 'DISABLED' END AS `IS_DISABLED`
    , `PRIORITY`                     AS `PRIORITY`
    , CASE `SUSPEND` WHEN 1 THEN 'CHILDSUSPEND' WHEN 2 THEN 'NOSUSPEND' WHEN 3 THEN 'SUSPEND' END AS `SUSPEND`
    , `RESUME_AT`                    AS `RESUME_AT`
    , `RESUME_IN`                    AS `RESUME_IN`
    , CASE `RESUME_BASE` WHEN 0 THEN 'MINUTE' WHEN 1 THEN 'HOUR' WHEN 2 THEN 'DAY' WHEN 3 THEN 'WEEK' WHEN 4 THEN 'MONTH' WHEN 5 THEN 'YEAR' END AS `RESUME_BASE`
    , CASE `MERGE_MODE` WHEN 1 THEN 'MERGE_LOCAL' WHEN 2 THEN 'MERGE_GLOBAL' WHEN 3 THEN 'NOMERGE' WHEN 4 THEN 'FAILURE' END AS `MERGE_MODE`
    , `ESTP_ID`                      AS `ESTP_ID`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
  FROM SCHEDULING_HIERARCHY
 WHERE VALID_TO = 9223372036854775807;
CREATE VIEW SCI_V_SCHEDULING_HIERARCHY AS
SELECT
    ID
    , `SE_PARENT_ID`                 AS `SE_PARENT_ID`
    , `SE_CHILD_ID`                  AS `SE_CHILD_ID`
    , `ALIAS_NAME`                   AS `ALIAS_NAME`
    , CASE `IS_STATIC` WHEN 1 THEN 'STATIC' WHEN 0 THEN 'DYNAMIC' END AS `IS_STATIC`
    , CASE `IS_DISABLED` WHEN 0 THEN 'ENABLED' WHEN 1 THEN 'DISABLED' END AS `IS_DISABLED`
    , `PRIORITY`                     AS `PRIORITY`
    , CASE `SUSPEND` WHEN 1 THEN 'CHILDSUSPEND' WHEN 2 THEN 'NOSUSPEND' WHEN 3 THEN 'SUSPEND' END AS `SUSPEND`
    , `RESUME_AT`                    AS `RESUME_AT`
    , `RESUME_IN`                    AS `RESUME_IN`
    , CASE `RESUME_BASE` WHEN 0 THEN 'MINUTE' WHEN 1 THEN 'HOUR' WHEN 2 THEN 'DAY' WHEN 3 THEN 'WEEK' WHEN 4 THEN 'MONTH' WHEN 5 THEN 'YEAR' END AS `RESUME_BASE`
    , CASE `MERGE_MODE` WHEN 1 THEN 'MERGE_LOCAL' WHEN 2 THEN 'MERGE_GLOBAL' WHEN 3 THEN 'NOMERGE' WHEN 4 THEN 'FAILURE' END AS `MERGE_MODE`
    , `ESTP_ID`                      AS `ESTP_ID`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
    , VALID_FROM
    , VALID_TO
  FROM SCHEDULING_HIERARCHY;
ALTER TABLE SUBMITTED_ENTITY
    ADD `IS_DISABLED` integer NOT NULL DEFAULT 0,
    ADD `OLD_STATE` integer;
ALTER TABLE ARC_SUBMITTED_ENTITY
    ADD `IS_DISABLED` integer,
    ADD `OLD_STATE` integer;
DROP VIEW SCI_SUBMITTED_ENTITY;
CREATE VIEW SCI_SUBMITTED_ENTITY AS
SELECT
    ID
    , `MASTER_ID`                    AS `MASTER_ID`
    , `SUBMIT_TAG`                   AS `SUBMIT_TAG`
    , CASE `UNRESOLVED_HANDLING` WHEN 1 THEN 'UH_IGNORE' WHEN 3 THEN 'UH_SUSPEND' WHEN 2 THEN 'UH_ERROR' END AS `UNRESOLVED_HANDLING`
    , `SE_ID`                        AS `SE_ID`
    , `CHILD_TAG`                    AS `CHILD_TAG`
    , `SE_VERSION`                   AS `SE_VERSION`
    , `OWNER_ID`                     AS `OWNER_ID`
    , `PARENT_ID`                    AS `PARENT_ID`
    , `SCOPE_ID`                     AS `SCOPE_ID`
    , CASE `IS_STATIC` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_STATIC`
    , CASE `IS_DISABLED` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_DISABLED`
    , `OLD_STATE`                    AS `OLD_STATE`
    , CASE `MERGE_MODE` WHEN 1 THEN 'MERGE_LOCAL' WHEN 2 THEN 'MERGE_GLOBAL' WHEN 3 THEN 'NOMERGE' WHEN 4 THEN 'FAILURE' END AS `MERGE_MODE`
    , CASE `STATE` WHEN 0 THEN 'SUBMITTED' WHEN 1 THEN 'DEPENDENCY_WAIT' WHEN 2 THEN 'SYNCHRONIZE_WAIT' WHEN 3 THEN 'RESOURCE_WAIT' WHEN 4 THEN 'RUNNABLE' WHEN 5 THEN 'STARTING' WHEN 6 THEN 'STARTED' WHEN 7 THEN 'RUNNING' WHEN 8 THEN 'TO_KILL' WHEN 9 THEN 'KILLED' WHEN 10 THEN 'CANCELLED' WHEN 11 THEN 'FINISHED' WHEN 12 THEN 'FINAL' WHEN 13 THEN 'BROKEN_ACTIVE' WHEN 14 THEN 'BROKEN_FINISHED' WHEN 15 THEN 'ERROR' WHEN 16 THEN 'UNREACHABLE' END AS `STATE`
    , `JOB_ESD_ID`                   AS `JOB_ESD_ID`
    , `JOB_ESD_PREF`                 AS `JOB_ESD_PREF`
    , CASE `JOB_IS_FINAL` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `JOB_IS_FINAL`
    , CASE `JOB_IS_RESTARTABLE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `JOB_IS_RESTARTABLE`
    , `FINAL_ESD_ID`                 AS `FINAL_ESD_ID`
    , `EXIT_CODE`                    AS `EXIT_CODE`
    , `COMMANDLINE`                  AS `COMMANDLINE`
    , `RR_COMMANDLINE`               AS `RR_COMMANDLINE`
    , `RERUN_SEQ`                    AS `RERUN_SEQ`
    , CASE `IS_REPLACED` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_REPLACED`
    , CASE `IS_CANCELLED` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_CANCELLED`
    , `BASE_SME_ID`                  AS `BASE_SME_ID`
    , `REASON_SME_ID`                AS `REASON_SME_ID`
    , `FIRE_SME_ID`                  AS `FIRE_SME_ID`
    , `FIRE_SE_ID`                   AS `FIRE_SE_ID`
    , `TR_ID`                        AS `TR_ID`
    , `TR_SD_ID_OLD`                 AS `TR_SD_ID_OLD`
    , `TR_SD_ID_NEW`                 AS `TR_SD_ID_NEW`
    , `TR_SEQ`                       AS `TR_SEQ`
    , `WORKDIR`                      AS `WORKDIR`
    , `LOGFILE`                      AS `LOGFILE`
    , `ERRLOGFILE`                   AS `ERRLOGFILE`
    , `PID`                          AS `PID`
    , `EXTPID`                       AS `EXTPID`
    , `ERROR_MSG`                    AS `ERROR_MSG`
    , `KILL_ID`                      AS `KILL_ID`
    , `KILL_EXIT_CODE`               AS `KILL_EXIT_CODE`
    , CASE `IS_SUSPENDED` WHEN 2 THEN 'ADMINSUSPEND' WHEN 1 THEN 'SUSPEND' WHEN 0 THEN 'NOSUSPEND' END AS `IS_SUSPENDED`
    , CASE `IS_SUSPENDED_LOCAL` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_SUSPENDED_LOCAL`
    , `PRIORITY`                     AS `PRIORITY`
    , `RAW_PRIORITY`                 AS `RAW_PRIORITY`
    , `NICE`                         AS `NICE`
    , `NP_NICE`                      AS `NP_NICE`
    , `MIN_PRIORITY`                 AS `MIN_PRIORITY`
    , `AGING_AMOUNT`                 AS `AGING_AMOUNT`
    , `PARENT_SUSPENDED`             AS `PARENT_SUSPENDED`
    , `CHILD_SUSPENDED`              AS `CHILD_SUSPENDED`
    , `WARN_COUNT`                   AS `WARN_COUNT`
    , `WARN_LINK`                    AS `WARN_LINK`
    , from_unixtime((`SUBMIT_TS` & ~1125899906842624)/1000) AS `SUBMIT_TS`
    , from_unixtime((`RESUME_TS` & ~1125899906842624)/1000) AS `RESUME_TS`
    , from_unixtime((`SYNC_TS` & ~1125899906842624)/1000) AS `SYNC_TS`
    , from_unixtime((`RESOURCE_TS` & ~1125899906842624)/1000) AS `RESOURCE_TS`
    , from_unixtime((`RUNNABLE_TS` & ~1125899906842624)/1000) AS `RUNNABLE_TS`
    , from_unixtime((`START_TS` & ~1125899906842624)/1000) AS `START_TS`
    , from_unixtime((`FINSH_TS` & ~1125899906842624)/1000) AS `FINSH_TS`
    , from_unixtime((`FINAL_TS` & ~1125899906842624)/1000) AS `FINAL_TS`
    , `IDLE_TIME`                    AS `IDLE_TIME`
    , `DEPENDENCY_WAIT_TIME`         AS `DEPENDENCY_WAIT_TIME`
    , `SUSPEND_TIME`                 AS `SUSPEND_TIME`
    , `SYNC_TIME`                    AS `SYNC_TIME`
    , `RESOURCE_TIME`                AS `RESOURCE_TIME`
    , `JOBSERVER_TIME`               AS `JOBSERVER_TIME`
    , `RESTARTABLE_TIME`             AS `RESTARTABLE_TIME`
    , `CHILD_WAIT_TIME`              AS `CHILD_WAIT_TIME`
    , `OP_SUSRES_TS`                 AS `OP_SUSRES_TS`
    , `NPE_ID`                       AS `NPE_ID`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
    , ((IFNULL(`FINAL_TS`, UNIX_TIMESTAMP(NOW()) * 1000) - `SUBMIT_TS`) / 1000) - `DEPENDENCY_WAIT_TIME` AS `PROCESS_TIME`
  FROM SUBMITTED_ENTITY;
ALTER TABLE TRIGGER_DEFINITION
    ADD `IS_INVERSE` integer NOT NULL DEFAULT 0,
    ADD `LIMIT_STATE` decimal(20);
DROP VIEW SCI_C_TRIGGER_DEFINITION;
DROP VIEW SCI_V_TRIGGER_DEFINITION;
CREATE VIEW SCI_C_TRIGGER_DEFINITION AS
SELECT
    ID
    , `NAME`                         AS `NAME`
    , `FIRE_ID`                      AS `FIRE_ID`
    , CASE `OBJECT_TYPE` WHEN 0 THEN 'JOB_DEFINITION' WHEN 1 THEN 'RESOURCE' WHEN 2 THEN 'NAMED_RESOURCE' WHEN 3 THEN 'OBJECT_MONITOR' END AS `OBJECT_TYPE`
    , `SE_ID`                        AS `SE_ID`
    , `MAIN_SE_ID`                   AS `MAIN_SE_ID`
    , `PARENT_SE_ID`                 AS `PARENT_SE_ID`
    , CASE `IS_ACTIVE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_ACTIVE`
    , CASE `IS_INVERSE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_INVERSE`
    , CASE `ACTION` WHEN 0 THEN 'SUBMIT' WHEN 1 THEN 'RERUN' END AS `ACTION`
    , CASE `TYPE` WHEN 0 THEN 'IMMEDIATE_LOCAL' WHEN 2 THEN 'BEFORE_FINAL' WHEN 3 THEN 'AFTER_FINAL' WHEN 1 THEN 'IMMEDIATE_MERGE' WHEN 4 THEN 'FINISH_CHILD' WHEN 5 THEN 'UNTIL_FINISHED' WHEN 6 THEN 'UNTIL_FINAL' WHEN 7 THEN 'WARNING' END AS `TYPE`
    , CASE `IS_MASTER` WHEN 1 THEN 'MASTER' WHEN 0 THEN 'NOMASTER' END AS `IS_MASTER`
    , CASE `IS_SUSPEND` WHEN 1 THEN 'SUSPEND' WHEN 0 THEN 'NOSUSPEND' END AS `IS_SUSPEND`
    , CASE `IS_CREATE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_CREATE`
    , CASE `IS_CHANGE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_CHANGE`
    , CASE `IS_DELETE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_DELETE`
    , CASE `IS_GROUP` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_GROUP`
    , `RESUME_AT`                    AS `RESUME_AT`
    , `RESUME_IN`                    AS `RESUME_IN`
    , CASE `RESUME_BASE` WHEN 0 THEN 'MINUTE' WHEN 1 THEN 'HOUR' WHEN 2 THEN 'DAY' WHEN 3 THEN 'WEEK' WHEN 4 THEN 'MONTH' WHEN 5 THEN 'YEAR' END AS `RESUME_BASE`
    , CASE `IS_WARN_ON_LIMIT` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_WARN_ON_LIMIT`
    , `LIMIT_STATE`                  AS `LIMIT_STATE`
    , `MAX_RETRY`                    AS `MAX_RETRY`
    , `SUBMIT_OWNER_ID`              AS `SUBMIT_OWNER_ID`
    , `CONDITION`                    AS `CONDITION`
    , `CHECK_AMOUNT`                 AS `CHECK_AMOUNT`
    , CASE `CHECK_BASE` WHEN 0 THEN 'MINUTE' WHEN 1 THEN 'HOUR' WHEN 2 THEN 'DAY' WHEN 3 THEN 'WEEK' WHEN 4 THEN 'MONTH' WHEN 5 THEN 'YEAR' END AS `CHECK_BASE`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
  FROM TRIGGER_DEFINITION
 WHERE VALID_TO = 9223372036854775807;
CREATE VIEW SCI_V_TRIGGER_DEFINITION AS
SELECT
    ID
    , `NAME`                         AS `NAME`
    , `FIRE_ID`                      AS `FIRE_ID`
    , CASE `OBJECT_TYPE` WHEN 0 THEN 'JOB_DEFINITION' WHEN 1 THEN 'RESOURCE' WHEN 2 THEN 'NAMED_RESOURCE' WHEN 3 THEN 'OBJECT_MONITOR' END AS `OBJECT_TYPE`
    , `SE_ID`                        AS `SE_ID`
    , `MAIN_SE_ID`                   AS `MAIN_SE_ID`
    , `PARENT_SE_ID`                 AS `PARENT_SE_ID`
    , CASE `IS_ACTIVE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_ACTIVE`
    , CASE `IS_INVERSE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_INVERSE`
    , CASE `ACTION` WHEN 0 THEN 'SUBMIT' WHEN 1 THEN 'RERUN' END AS `ACTION`
    , CASE `TYPE` WHEN 0 THEN 'IMMEDIATE_LOCAL' WHEN 2 THEN 'BEFORE_FINAL' WHEN 3 THEN 'AFTER_FINAL' WHEN 1 THEN 'IMMEDIATE_MERGE' WHEN 4 THEN 'FINISH_CHILD' WHEN 5 THEN 'UNTIL_FINISHED' WHEN 6 THEN 'UNTIL_FINAL' WHEN 7 THEN 'WARNING' END AS `TYPE`
    , CASE `IS_MASTER` WHEN 1 THEN 'MASTER' WHEN 0 THEN 'NOMASTER' END AS `IS_MASTER`
    , CASE `IS_SUSPEND` WHEN 1 THEN 'SUSPEND' WHEN 0 THEN 'NOSUSPEND' END AS `IS_SUSPEND`
    , CASE `IS_CREATE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_CREATE`
    , CASE `IS_CHANGE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_CHANGE`
    , CASE `IS_DELETE` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_DELETE`
    , CASE `IS_GROUP` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_GROUP`
    , `RESUME_AT`                    AS `RESUME_AT`
    , `RESUME_IN`                    AS `RESUME_IN`
    , CASE `RESUME_BASE` WHEN 0 THEN 'MINUTE' WHEN 1 THEN 'HOUR' WHEN 2 THEN 'DAY' WHEN 3 THEN 'WEEK' WHEN 4 THEN 'MONTH' WHEN 5 THEN 'YEAR' END AS `RESUME_BASE`
    , CASE `IS_WARN_ON_LIMIT` WHEN 1 THEN 'TRUE' WHEN 0 THEN 'FALSE' END AS `IS_WARN_ON_LIMIT`
    , `LIMIT_STATE`                  AS `LIMIT_STATE`
    , `MAX_RETRY`                    AS `MAX_RETRY`
    , `SUBMIT_OWNER_ID`              AS `SUBMIT_OWNER_ID`
    , `CONDITION`                    AS `CONDITION`
    , `CHECK_AMOUNT`                 AS `CHECK_AMOUNT`
    , CASE `CHECK_BASE` WHEN 0 THEN 'MINUTE' WHEN 1 THEN 'HOUR' WHEN 2 THEN 'DAY' WHEN 3 THEN 'WEEK' WHEN 4 THEN 'MONTH' WHEN 5 THEN 'YEAR' END AS `CHECK_BASE`
    , `CREATOR_U_ID`                 AS `CREATOR_U_ID`
    , from_unixtime((`CREATE_TS` & ~1125899906842624)/1000) AS `CREATE_TS`
    , `CHANGER_U_ID`                 AS `CHANGER_U_ID`
    , from_unixtime((`CHANGE_TS` & ~1125899906842624)/1000) AS `CHANGE_TS`
    , VALID_FROM
    , VALID_TO
  FROM TRIGGER_DEFINITION;
