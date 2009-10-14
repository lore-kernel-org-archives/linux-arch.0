From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Date: Wed, 14 Oct 2009 11:47:27 +0530
Message-ID: <20091014061727.GA8605@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
	<8763akh4re.fsf@basil.nowhere.org>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <8763akh4re.fsf@basil.nowhere.org>
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

* Andi Kleen <andi@firstfloor.org> [2009-10-12 20:00:05]:

> Peter Zijlstra <a.p.zijlstra@chello.nl> writes:
> >
> > So does it make sense to have a set of sets?
> >
> > Why not integrate them all into one set to be ruled by this governor
> > thing?
> 
> cpuidle is currently optional, that is why the two level hierarchy
> is there so that you can still have simple idle selection without it.
> 
> % size drivers/cpuidle/*.o
>    text    data     bss     dec     hex filename
>    5514    1416      44    6974    1b3e drivers/cpuidle/built-in.o
> 
> Adding it unconditionally would add ~7k to everyone who wants idle functions.
> 
> I think making it unconditional would require putting it on a serious
> diet first.
> 

Hi Andi,

Yes, this is a valid point.

How about something like this..
If the arch does not enable CONFIG_CPU_IDLE, the cpuidle_idle_call
which is called from cpu_idle() should call default_idle without
involving the registering cpuidle steps. This should prevent bloating
up of the kernel for archs which dont want to use cpuidle.

--arun
> -Andi
> -- 
> ak@linux.intel.com -- Speaking for myself only.
