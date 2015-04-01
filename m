From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Wed, 1 Apr 2015 19:12:23 +0200
Message-ID: <20150401171223.GO23123@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
 <20150316133112.278511476@infradead.org>
 <5509E51D.7040909@hp.com>
 <20150319101242.GM21418@twins.programming.kicks-ass.net>
 <20150319122536.GD11574@worktop.ger.corp.intel.com>
 <551C1ACE.4090408@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <551C1ACE.4090408@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 01, 2015 at 12:20:30PM -0400, Waiman Long wrote:
> After more careful reading, I think the assumption that the presence of an
> unused bucket means there is no match is not true. Consider the scenario:
> 
> 1. cpu 0 puts lock1 into hb[0]
> 2. cpu 1 puts lock2 into hb[1]
> 3. cpu 2 clears hb[0]
> 4. cpu 3 looks for lock2 and doesn't find it

Hmm, yes. The only way I can see that being true is if we assume entries
are never taken out again.

The wikipedia page could use some clarification here, this is not clear.

> At this point, I am thinking using back your previous idea of passing the
> queue head information down the queue.

Having to scan the entire array for a lookup sure sucks, but the wait
loops involved in the other idea can get us in the exact predicament we
were trying to get out, because their forward progress depends on other
CPUs.

Hohumm.. time to think more I think ;-)
