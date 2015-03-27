From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Fri, 27 Mar 2015 10:07:37 -0400
Message-ID: <20150327140737.GD22791@l.oracle.com>
References: <20150316131613.720617163@infradead.org>
 <20150325194739.GK25884@l.oracle.com>
 <20150326202153.GD27490@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150326202153.GD27490@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman.Long@hp.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 26, 2015 at 09:21:53PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 25, 2015 at 03:47:39PM -0400, Konrad Rzeszutek Wilk wrote:
> > Ah nice. That could be spun out as a seperate patch to optimize the existing
> > ticket locks I presume.
> 
> Yes I suppose we can do something similar for the ticket and patch in
> the right increment. We'd need to restructure the code a bit, but
> its not fundamentally impossible.
> 
> We could equally apply the head hashing to the current ticket
> implementation and avoid the current bitmap iteration.
> 
> > Now with the old pv ticketlock code an vCPU would only go to sleep once and
> > be woken up when it was its turn. With this new code it is woken up twice 
> > (and twice it goes to sleep). With an overcommit scenario this would imply
> > that we will have at least twice as many VMEXIT as with the previous code.
> 
> An astute observation, I had not considered that.

Thank you.
> 
> > I presume when you did benchmarking this did not even register? Thought
> > I wonder if it would if you ran the benchmark for a week or so.
> 
> You presume I benchmarked :-) I managed to boot something virt and run
> hackbench in it. I wouldn't know a representative virt setup if I ran
> into it.
> 
> The thing is, we want this qspinlock for real hardware because its
> faster and I really want to avoid having to carry two spinlock
> implementations -- although I suppose that if we really really have to
> we could.

In some way you already have that - for virtualized environments where you
don't have an PV mechanism you just use the byte spinlock - which is good.

And switching to PV ticketlock implementation after boot.. ugh. I feel your pain.

What if you used an PV bytelock implemenation? The code you posted already
'sprays' all the vCPUS to wake up. And that is exactly what you need for PV
bytelocks - well, you only need to wake up the vCPUS that have gone to sleep
waiting on an specific 'struct spinlock' and just stash those in an per-cpu
area. The old Xen spinlock code (Before 3.11?) had this.

Just an idea thought.
