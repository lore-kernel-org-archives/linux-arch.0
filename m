From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v8 PATCH 1/8]: cpuidle: cleanup drivers/cpuidle/cpuidle.c
Date: Wed, 14 Oct 2009 11:54:12 +0530
Message-ID: <20091014062412.GB8605@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008094942.GB20595@linux.vnet.ibm.com>
	<20091012113602.GC3007@balbir.in.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20091012113602.GC3007@balbir.in.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Arun Bharadwaj <arun@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-arch.vger.kernel.org

* Balbir Singh <balbir@linux.vnet.ibm.com> [2009-10-12 17:06:02]:

> * Arun R B <arun@linux.vnet.ibm.com> [2009-10-08 15:19:42]:
> 
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-08 15:18:28]:
> > 
> > This patch cleans up drivers/cpuidle/cpuidle.c
> > Earlier cpuidle assumed pm_idle as the default idle loop. Break that
> > assumption and make it more generic. cpuidle_idle_call() which is the
> > main idle loop of cpuidle is to be called by architectures which have
> > registered to cpuidle.
> > 
> > Remove routines cpuidle_install/uninstall_idle_handler() which are not
> > needed anymore.
> > 
> >
> 
> [snip]
> 
>   /**
> > - * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
> > - */
> > -void cpuidle_install_idle_handler(void)
> > -{
> > -	if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
> > -		/* Make sure all changes finished before we switch to new idle */
> > -		smp_wmb();
> > -		pm_idle = cpuidle_idle_call;
> > -	}
> > -}
> > -
> > -/**
> > - * cpuidle_uninstall_idle_handler - uninstalls the cpuidle idle loop handler
> > - */
> > -void cpuidle_uninstall_idle_handler(void)
> > -{
> > -	if (enabled_devices && pm_idle_old && (pm_idle != pm_idle_old)) {
> > -		pm_idle = pm_idle_old;
> > -		cpuidle_kick_cpus();
> > -	}
> > -}
> > -
> 
> I see the routines above being called in from
> cpuidle_pause/resume_and_lock/unlock below and they are entries from
> ACPI on ACPI_PROCESSOR_NOTIFY_POWER and from the hotplug path, could
> you test them to make sure they are not broken. We also seem to be
> missing a cpuidle_kick_cpus() in cpuidle_pause_and_lock()
> 
> [snip]
> 

Hi Balbir,

yes, we definitely need a cpuidle_kick_cpus() in
cpuidle_pause_and_lock() since this is used while disabling the
cpuidle_device and the cpus need to be kicked out of the idle states.
I will test this modified code and see if it breaks hotplug.

thanks,
arun

> -- 
> 	Balbir
