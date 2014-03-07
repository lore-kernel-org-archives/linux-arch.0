From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 14/52] powerpc, sysfs: Fix CPU hotplug callback
 registration
Date: Fri, 7 Mar 2014 11:51:58 +0530
Message-ID: <20140307062157.GA2737@in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
 <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
 <1394161051.26321.71.camel@pasglop>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:44697 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbaCGGWO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Mar 2014 01:22:14 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 7 Mar 2014 01:22:13 -0500
Content-Disposition: inline
In-Reply-To: <1394161051.26321.71.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Olof Johansson <olof@lixom.net>, Wang Dongsheng <dongsheng.wang@freescale.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Hello Ben,

On Fri, Mar 07, 2014 at 01:57:31PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-02-14 at 13:22 +0530, Srivatsa S. Bhat wrote:
> > Subsystems that want to register CPU hotplug callbacks, as well as perform
> > initialization for the CPUs that are already online, often do it as shown
> > below:
> > 
> > 	get_online_cpus();
> > 
> > 	for_each_online_cpu(cpu)
> > 		init_cpu(cpu);
> > 
> > 	register_cpu_notifier(&foobar_cpu_notifier);
> > 
> > 	put_online_cpus();
> 
> This patch breaks a good half of my test configs with:
> 
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c: In function 'topology_init':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:979:2: error: implicit declaration of function 'cpu_notifier_register_begin' [-Werror=implicit-function-declaration]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:1004:2: error: implicit declaration of function '__register_cpu_notifier' [-Werror=implicit-function-declaration]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:1006:2: error: implicit declaration of function 'cpu_notifier_register_done' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/powerpc/kernel/sysfs.o] Error 1
> make[2]: *** Waiting for unfinished jobs....

This patch depends on
"[PATCH v2 02/52] CPU hotplug: Provide lockless versions of callback registration functions" 
of the series (Can be found here: https://lkml.org/lkml/2014/2/14/59).
This particular patch defines 'cpu_notifier_register_begin',
'__register_cpu_notifier', and 'cpu_notifier_register_done' in the
cpu-hotplug core. Are you seeing the build breakage with this patch on
?

--
Thanks and Regards
gautham.
