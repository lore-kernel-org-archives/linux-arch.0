Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBJnn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Apr 2019 05:43:43 -0400
Date: Tue, 2 Apr 2019 11:43:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190402094320.GM11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190402094320.zSMNjop3_JNrhsuStrwBOgcziR9MH5vLC9-LQliphoo@z>

On Mon, Apr 01, 2019 at 10:36:19AM -0400, Waiman Long wrote:
> On 03/29/2019 11:20 AM, Alex Kogan wrote:
> > +config NUMA_AWARE_SPINLOCKS
> > +	bool "Numa-aware spinlocks"
> > +	depends on NUMA
> > +	default y
> > +	help
> > +	  Introduce NUMA (Non Uniform Memory Access) awareness into
> > +	  the slow path of spinlocks.
> > +
> > +	  The kernel will try to keep the lock on the same node,
> > +	  thus reducing the number of remote cache misses, while
> > +	  trading some of the short term fairness for better performance.
> > +
> > +	  Say N if you want absolute first come first serve fairness.
> > +
> 
> The patch that I am looking for is to have a separate
> numa_queued_spinlock_slowpath() that coexists with
> native_queued_spinlock_slowpath() and
> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
> appropriate one for the system at hand.

Agreed; and until we have static_call, I think we can abuse the paravirt
stuff for this.

By the time we patch the paravirt stuff:

  check_bugs()
    alternative_instructions()
      apply_paravirt()

we should already have enumerated the NODE topology and so nr_node_ids()
should be set.

So if we frob pv_ops.lock.queued_spin_lock_slowpath to
numa_queued_spin_lock_slowpath before that, it should all get patched
just right.

That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
PARAVIRT_SPINLOCK, which is a bit awkward...
