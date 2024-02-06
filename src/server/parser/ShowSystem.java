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
import de.independit.scheduler.server.exception.*;
import de.independit.scheduler.server.locking.*;
import de.independit.scheduler.server.output.*;
import de.independit.scheduler.server.repository.*;
import de.independit.scheduler.server.util.*;

public class ShowSystem extends Node
{

	public final static String __version = "@(#) $Id: ShowSystem.java,v 2.14.4.3 2013/06/18 09:49:38 ronald Exp $";

	final static String[] props = {
		"java.version",
		"java.vendor",
		"java.vendor.url",
		"java.home",
		"java.vm.specification.version",
		"java.vm.specification.vendor",
		"java.vm.specification.name",
		"java.vm.version",
		"java.vm.vendor",
		"java.vm.name",
		"java.specification.version",
		"java.specification.vendor",
		"java.specification.name",
		"java.class.version",
		"java.class.path",
		"java.library.path",
		"java.io.tmpdir",
		"java.compiler",
		"java.ext.dirs",
		"os.name",
		"os.arch",
		"os.version"
	};

	private final static String ExpireDate = "ExpireDate";

	private boolean withLocks;

	public ShowSystem(boolean withLocks)
	{
		super();
		txMode = SDMSTransaction.READONLY;
		auditFlag = false;
		this.withLocks = withLocks;
	}

	public void go(SystemEnvironment sysEnv)
		throws SDMSException
	{
		SystemEnvironment.getCompatLevel(true);
		SDMSOutputContainer d_container = null;
		SDMSOutputContainer w_container = null;
		Vector desc = new Vector();
		Vector w_desc = new Vector();
		Runtime r = Runtime.getRuntime();
		Set s = SystemEnvironment.props.keySet();

		desc.add("VERSION");
		desc.add("MAX_LEVEL");
		desc.add("BUILD_DATE");
		desc.add("BUILD_HASH");
		desc.add("NUM_CPU");
		desc.add("MEM_USED");
		desc.add("MEM_FREE");
		desc.add("MEM_MAX");
		desc.add("STARTTIME");
		desc.add("UPTIME");
		desc.add("HITRATE");
		desc.add("LOCK_HWM");
		desc.add("LOCKS_REQUESTED");
		desc.add("LOCKS_USED");
		desc.add("LOCKS_DISCARDED");
		desc.add("CNT_RW_TX");
		desc.add("CNT_DL");
		desc.add("CNT_WL");
		Iterator i = s.iterator();
		Vector conf = new Vector();
		while(i.hasNext()) {
			String str = (String) i.next();
			if(!str.equals(SystemEnvironment.S_DBPASSWD) &&
			    !str.equals(SystemEnvironment.S_KEYSTOREPASSWORD) &&
			    !str.equals(SystemEnvironment.S_TRUSTSTOREPASSWORD) &&
			    !str.equals(SystemEnvironment.S_SUPPORTKEY) &&
			    !str.equals(SystemEnvironment.S_SYSPASSWD))
				conf.add(str);
			else if (str.equals(SystemEnvironment.S_SUPPORTKEY)) {
				conf.add(ExpireDate);
			}
		}
		Collections.sort(conf);
		desc.addAll(conf);
		for(int j = 0; j < props.length; j++) {
			String prop = props[j].toUpperCase();
			desc.add(prop);
		}
		desc.add("WORKER");
		if (withLocks)
			desc.add("LOCKING STATUS");

		Vector data = new Vector();
		data.add(SystemEnvironment.programVersion);
		data.add(SystemEnvironment.programLevel);
		data.add(SystemEnvironment.buildDate);
		data.add(SystemEnvironment.buildHash);
		data.add(Integer.valueOf(r.availableProcessors()));
		data.add(Long.valueOf(r.totalMemory()));
		data.add(Long.valueOf(r.freeMemory()));
		data.add(Long.valueOf(r.maxMemory()));
		data.add(new Date(SystemEnvironment.startTime));
		long uptime = (System.currentTimeMillis() - SystemEnvironment.startTime)/1000;
		int upsec = (int) uptime%60;
		uptime /= 60;
		int upmin = (int) uptime%60;
		uptime /= 60;
		int uphr = (int) uptime%24;
		uptime /= 24;
		String uptimeAsString = (uptime > 0 ? "" + uptime + " day(s) " : "") +
					(uphr + uptime > 0 ? "" + uphr + " hour(s) " : "") +
					(upmin + uphr + uptime > 0 ? "" + upmin + " min(s) " : "") + "" + upsec + " sec(s)";
		data.add(uptimeAsString);
		if (SystemEnvironment.sched.envhit == 0)
			data.add("0 %");
		else
			data.add("" + (int) (SystemEnvironment.sched.envhit * 100.0)/(SystemEnvironment.sched.envhit + SystemEnvironment.sched.envmiss) + " %");

		data.add(Long.valueOf(ObjectLock.lockHWM));
		data.add(Long.valueOf(ObjectLock.lockRequest));
		data.add(Long.valueOf(ObjectLock.lockUsed));
		data.add(Long.valueOf(ObjectLock.lockDiscarded));
		data.add(Long.valueOf(SystemEnvironment.cntRwTx));
		data.add(Long.valueOf(SystemEnvironment.cntDl));
		data.add(Long.valueOf(SystemEnvironment.cntWl));
		i = conf.iterator();
		while(i.hasNext()) {
			String str = (String) i.next();
			if(!str.equals(SystemEnvironment.S_DBPASSWD) &&
			    !str.equals(SystemEnvironment.S_KEYSTOREPASSWORD) &&
			    !str.equals(SystemEnvironment.S_TRUSTSTOREPASSWORD) &&
			    !str.equals(ExpireDate) &&
			    !str.equals(SystemEnvironment.S_SYSPASSWD)
			  )
				data.add(SystemEnvironment.props.get(str));
			else if (str.equals(ExpireDate)) {
			}
		}
		for(int j = 0; j < props.length; j++) {
			String prop = props[j].toUpperCase();
			data.add(System.getProperty(props[j]));
		}

		w_desc = new Vector();
		w_desc.add("ID");
		w_desc.add("TYPE");
		w_desc.add("NAME");
		w_desc.add("STATE");
		w_desc.add("TIME");
		w_container = new SDMSOutputContainer(sysEnv, "worker", w_desc);

		add_worker(sysEnv, w_container);
		data.add(w_container);

		if (withLocks)
			data.add(LockingSystemSynchronized.strDump().toString());

		listObjects(sysEnv);

		d_container = new SDMSOutputContainer(sysEnv, "System", desc, data);

		result.setOutputContainer(d_container);

		result.setFeedback(new SDMSMessage(sysEnv, "03202252102", "System shown"));
	}

	private void add_worker(SystemEnvironment sysEnv, SDMSOutputContainer w_container)
		throws SDMSException
	{
		Vector data;
		ThreadGroup wg = SystemEnvironment.wg;
		WorkerThread[] wt = new WorkerThread[SystemEnvironment.maxWorker + SystemEnvironment.maxWriter];

		if(wt != null) {
			wg.enumerate(wt);
			for(int i = 0; i < wt.length; ++i) {
				if(wt[i] != null) {
					if(wt[i].isAlive()) {
						data = new Vector();
						data.add(Integer.valueOf(wt[i].id()));
						data.add(i < SystemEnvironment.maxWriter ? "RW" : "RO");
						data.add(wt[i].getName());
						data.add(wt[i].getWorkerState());
						data.add(wt[i].getWorkerStateTS(sysEnv));
						w_container.addData(sysEnv, data);
					}
				}
			}
		}

	}

	private void listObjects(SystemEnvironment sysEnv)
		throws SDMSException
	{
		Iterator i = SystemEnvironment.repository.getTableIterator(sysEnv);

		while (i.hasNext()) {
			SDMSTable t = (SDMSTable) i.next();

			SDMSThread.doTrace(sysEnv.cEnv, t.getClass().getName() + "\t:\t" + t.rawSize(), SDMSThread.SEVERITY_DEBUG);
		}
	}

}

