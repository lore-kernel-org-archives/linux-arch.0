From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Date: Thu, 15 Oct 2009 11:36:52 +0530
Message-ID: <20091015060651.GA4569@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
	<8763akh4re.fsf@basil.nowhere.org>
	<20091014061727.GA8605@linux.vnet.ibm.com>
	<20091014071838.GE23248@one.firstfloor.org>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20091014071838.GE23248@one.firstfloor.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Arun Bharadwaj <arun@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-arch.vger.kernel.org

* Andi Kleen <andi@firstfloor.org> [2009-10-14 09:18:38]:

> > How about something like this..
> > If the arch does not enable CONFIG_CPU_IDLE, the cpuidle_idle_call
> > which is called from cpu_idle() should call default_idle without
> > involving the registering cpuidle steps. This should prevent bloating
> > up of the kernel for archs which dont want to use cpuidle.
> 
> On x86 some people want small kernel too, so selecting it on a architecture
> granuality is not good. Also you can make it default, you just need
> to slim it down first.
> 

No, I dont mean selecting it on an architecture granularity.

At compile time, if CONFIG_CPU_IDLE is disabled, the arch can redefine
cpuidle_idle_call. For e.g. in arch/x86/kernel/process.c

#ifndef CONFIG_CPU_IDLE
void cpuidle_idle_call(void)
{
	if (local_idle)
		local_idle();
	else
		default_idle();
}
#endif

where local_idle points to the idle routine selected using
select_idle_routine() which can be poll, mwait, c1e.

So this way, we still preserve the exact same functionality as before
and we also remove the ugly pm_idle exported function pointer and we
avoid unnecessary code bloat for platforms who do not want to use
cpuidle.

--arun
