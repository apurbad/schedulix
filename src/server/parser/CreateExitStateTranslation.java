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
package de.independit.scheduler.server.parser;

import java.io.*;
import java.util.*;
import java.lang.*;

import de.independit.scheduler.server.*;
import de.independit.scheduler.server.repository.*;
import de.independit.scheduler.server.exception.*;

public class CreateExitStateTranslation extends Node
{

	public final static String __version = "@(#) $Id: CreateExitStateTranslation.java,v 2.4.2.2 2013/03/15 14:36:20 ronald Exp $";

	private String name;
	private Vector trans;
	private boolean replace;

	public CreateExitStateTranslation (String n, Vector p_trans, Boolean r)
	{
		super();
		name = n;
		trans = p_trans;
		replace = r.booleanValue();
	}

	public void go(SystemEnvironment sysEnv)
		throws SDMSException
	{
		sysEnv.checkFeatureAvailability(SystemEnvironment.S_EXIT_STATE_TRANSLATION);
		SDMSExitStateTranslationProfile estp;
		try {
			estp = SDMSExitStateTranslationProfileTable.table.create (sysEnv, name);
		} catch(DuplicateKeyException dke) {
			if(replace) {
				AlterExitStateTranslation aest = new AlterExitStateTranslation(new ObjectURL(SDMSConstants.PS_EXIT_STATUS_TRANSLATION, name), trans, Boolean.FALSE);
				aest.setEnv(env);
				aest.go(sysEnv);
				result = aest.result;
				return;
			} else {
				throw dke;
			}
		}

		Long estpId = estp.getId(sysEnv);
		Long esdIdFrom;
		Long esdIdTo;

		Iterator i;
		i = trans.iterator();
		while (i.hasNext()) {
			StatusTranslation est = (StatusTranslation)i.next();
			esdIdFrom = SDMSExitStateDefinitionTable.idx_name_getUnique(sysEnv, est.sfrom).getId(sysEnv);
			esdIdTo = SDMSExitStateDefinitionTable.idx_name_getUnique(sysEnv, est.sto).getId(sysEnv);
			try {
				SDMSExitStateTranslationTable.table.create (sysEnv, estpId, esdIdFrom, esdIdTo);
			} catch (DuplicateKeyException dke) {
				throw new CommonErrorException(new SDMSMessage (sysEnv, "03110101313",
				                               "Exit State $1 is translated twice", est.sfrom));
			}
		}

		result.setFeedback(new SDMSMessage(sysEnv, "03204112202", "Exit State Translation created"));
	}
}

