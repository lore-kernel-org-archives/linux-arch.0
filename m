From: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/10] x86: convert to generic helpers for IPI function calls
Date: Wed, 30 Apr 2008 05:20:01 -0700
Message-ID: <20080430122001.GS11126@linux.vnet.ibm.com>
References: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com> <1209453990-7735-3-git-send-email-jens.axboe@oracle.com> <481786A5.7010604@goop.org> <20080430113542.GZ12774@kernel.dk>
Reply-To: paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080430113542.GZ12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org

On Wed, Apr 30, 2008 at 01:35:42PM +0200, Jens Axboe wrote:
> On Tue, Apr 29 2008, Jeremy Fitzhardinge wrote:
> > Jens Axboe wrote:
> > >-int xen_smp_call_function_mask(cpumask_t mask, void (*func)(void *),
> > >-			       void *info, int wait)
> > >  
> > [...]
> > >-	/* Send a message to other CPUs and wait for them to respond */
> > >-	xen_send_IPI_mask(mask, XEN_CALL_FUNCTION_VECTOR);
> > >-
> > >-	/* Make sure other vcpus get a chance to run if they need to. */
> > >-	yield = false;
> > >-	for_each_cpu_mask(cpu, mask)
> > >-		if (xen_vcpu_stolen(cpu))
> > >-			yield = true;
> > >-
> > >-	if (yield)
> > >-		HYPERVISOR_sched_op(SCHEDOP_yield, 0);
> > >  
> > 
> > I added this to deal with the case where you're sending an IPI to 
> > another VCPU which isn't currently running on a real cpu.  In this case 
> > you could end up spinning while the other VCPU is waiting for a real CPU 
> > to run on.  (Basically the same problem that spinlocks have in a virtual 
> > environment.)
> > 
> > However, this is at best a partial solution to the problem, and I never 
> > benchmarked if it really makes a difference.  Since any other virtual 
> > environment would have the same problem, its best if we can solve it 
> > generically.  (Of course a synchronous single-target cross-cpu call is a 
> > simple cross-cpu rpc, which could be implemented very efficiently in the 
> > host/hypervisor by simply doing a vcpu context switch...)
> 
> So, what would your advice be? Seems safe enough to ignore for now and
> attack it if it becomes a real problem.

How about an arch-specific function/macro invoked in the spin loop?
The generic implementation would do nothing, but things like Xen
could implement as above.

						Thanx, Paul
