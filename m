From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Date: Fri, 29 Sep 2017 12:31:31 +0200
Message-ID: <20170929103131.un7tzxsixjoretal@hirez.programming.kicks-ass.net>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
 <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
 <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
 <20170928155115.fou577qzxepnnxqc@hirez.programming.kicks-ass.net>
 <20170929022757.62d43dfc@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34357 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdI2Kbw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2017 06:31:52 -0400
Content-Disposition: inline
In-Reply-To: <20170929022757.62d43dfc@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>

On Fri, Sep 29, 2017 at 02:27:57AM +1000, Nicholas Piggin wrote:

> The biggest power boxes are more tightly coupled than those big
> SGI systems, but even so just plodding along taking and releasing
> locks in turn would be fine on those SGI ones as well really. Not DoS
> level. This is not a single mega hot cache line or lock that is
> bouncing over the entire machine, but one process grabbing a line and
> lock from each of 1000 CPUs.
> 
> Slight disturbance sure, but each individual CPU will see it as 1/1000th
> of a disturbance, most of the cost will be concentrated in the syscall
> caller.

But once the:

	while (1)
		sys_membarrier()

thread has all those (lock) lines in M state locally, it will become
very hard for the remote CPUs to claim them back, because its constantly
touching them. Sure it will touch a 1000 other lines before its back to
this one, but if they're all local that's fairly quick.

But you're right, your big machines have far smaller NUMA factors.

> > Bouncing that lock across the machine is *painful*, I have vague
> > memories of cases where the lock ping-pong was most the time spend.
> > 
> > But only Power needs this, all the other architectures are fine with the
> > lockless approach for MEMBAR_EXPEDITED_PRIVATE.
> 
> Yes, we can add an iterator function that power can override in a few
> lines. Less arch specific code than this proposal.

A semi related issue; I suppose we can do a arch upcall to flush_tlb_mm
and reset the mm_cpumask when we change cpuset groups.
