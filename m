From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Date: Fri, 29 Sep 2017 02:27:57 +1000
Message-ID: <20170929022757.62d43dfc@roar.ozlabs.ibm.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
        <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
        <20170927230436.4af88a62@roar.ozlabs.ibm.com>
        <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
        <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
        <20170928155115.fou577qzxepnnxqc@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36417 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdI1Q2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2017 12:28:16 -0400
In-Reply-To: <20170928155115.fou577qzxepnnxqc@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>

On Thu, 28 Sep 2017 17:51:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 29, 2017 at 01:01:12AM +1000, Nicholas Piggin wrote:
> > That's fine. If a user is not bound to a subset of CPUs, they could
> > also cause disturbances with other syscalls and faults, taking locks,
> > causing tlb flushes and IPIs and things.  
> 
> So on the big SGI class machines we've had trouble with
> for_each_cpu() loops before, and IIRC the biggest Power box is not too
> far from that 1-2K CPUs IIRC.

This is a loop in process context, interrupts on, can reschedule, no
locks held though.

The biggest power boxes are more tightly coupled than those big
SGI systems, but even so just plodding along taking and releasing
locks in turn would be fine on those SGI ones as well really. Not DoS
level. This is not a single mega hot cache line or lock that is
bouncing over the entire machine, but one process grabbing a line and
lock from each of 1000 CPUs.

Slight disturbance sure, but each individual CPU will see it as 1/1000th
of a disturbance, most of the cost will be concentrated in the syscall
caller.

> 
> Bouncing that lock across the machine is *painful*, I have vague
> memories of cases where the lock ping-pong was most the time spend.
> 
> But only Power needs this, all the other architectures are fine with the
> lockless approach for MEMBAR_EXPEDITED_PRIVATE.

Yes, we can add an iterator function that power can override in a few
lines. Less arch specific code than this proposal.

> 
> The ISYNC variant of the same however appears to want TIF flags or
> something to aid a number of archs, the rq->lock will not help there.

The SYNC_CORE? Yes it seems different. I think that's another issue
though.

Thanks,
Nick
