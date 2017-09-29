From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Date: Fri, 29 Sep 2017 21:38:53 +1000
Message-ID: <20170929213853.46c4675b@roar.ozlabs.ibm.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
        <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
        <20170927230436.4af88a62@roar.ozlabs.ibm.com>
        <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
        <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
        <20170928155115.fou577qzxepnnxqc@hirez.programming.kicks-ass.net>
        <20170929022757.62d43dfc@roar.ozlabs.ibm.com>
        <20170929103131.un7tzxsixjoretal@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929103131.un7tzxsixjoretal@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 29 Sep 2017 12:31:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 29, 2017 at 02:27:57AM +1000, Nicholas Piggin wrote:
> 
> > The biggest power boxes are more tightly coupled than those big
> > SGI systems, but even so just plodding along taking and releasing
> > locks in turn would be fine on those SGI ones as well really. Not DoS
> > level. This is not a single mega hot cache line or lock that is
> > bouncing over the entire machine, but one process grabbing a line and
> > lock from each of 1000 CPUs.
> > 
> > Slight disturbance sure, but each individual CPU will see it as 1/1000th
> > of a disturbance, most of the cost will be concentrated in the syscall
> > caller.  
> 
> But once the:
> 
> 	while (1)
> 		sys_membarrier()
> 
> thread has all those (lock) lines in M state locally, it will become
> very hard for the remote CPUs to claim them back, because its constantly

Not really. There is some ability to hold onto a line for a time, but
there is no way to starve them, let alone starve hundreds of other
CPUs. They will request the cacheline exclusive and eventually get it.
Then the membarrier CPU has to pay to get it back. If there is a lot of
activity on the locks, the membarrier will have a difficult time to take
each one.

I don't say there is zero cost or can't interfere with others, only that
it does not seem particularly bad compared with other things. Once you
restrict it to mm_cpumask, then it's quite partitionable.

I would really prefer to go this way on powerpc first. We could add the
the registration APIs as basically no-ops, but which would allow the
locking approach to be changed if we find it causes issues. I'll try to
find some time and a big system when I can.

> touching them. Sure it will touch a 1000 other lines before its back to
> this one, but if they're all local that's fairly quick.
> 
> But you're right, your big machines have far smaller NUMA factors.
> 
> > > Bouncing that lock across the machine is *painful*, I have vague
> > > memories of cases where the lock ping-pong was most the time spend.
> > > 
> > > But only Power needs this, all the other architectures are fine with the
> > > lockless approach for MEMBAR_EXPEDITED_PRIVATE.  
> > 
> > Yes, we can add an iterator function that power can override in a few
> > lines. Less arch specific code than this proposal.  
> 
> A semi related issue; I suppose we can do a arch upcall to flush_tlb_mm
> and reset the mm_cpumask when we change cpuset groups.

For powerpc we have been looking at how mm_cpumask can be improved.
It has real drawbacks even when you don't consider this new syscall.

Thanks,
Nick
