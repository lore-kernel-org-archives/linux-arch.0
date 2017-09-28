Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48351 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdI1Pvi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2017 11:51:38 -0400
Date: Thu, 28 Sep 2017 17:51:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20170928155115.fou577qzxepnnxqc@hirez.programming.kicks-ass.net>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
 <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
 <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>
Message-ID: <20170928155115.N1TpIllqYZ69Os7Q0N1CYdP2yARIzo4h3AUaQwAjlSk@z>

On Fri, Sep 29, 2017 at 01:01:12AM +1000, Nicholas Piggin wrote:
> That's fine. If a user is not bound to a subset of CPUs, they could
> also cause disturbances with other syscalls and faults, taking locks,
> causing tlb flushes and IPIs and things.

So on the big SGI class machines we've had trouble with
for_each_cpu() loops before, and IIRC the biggest Power box is not too
far from that 1-2K CPUs IIRC.

Bouncing that lock across the machine is *painful*, I have vague
memories of cases where the lock ping-pong was most the time spend.

But only Power needs this, all the other architectures are fine with the
lockless approach for MEMBAR_EXPEDITED_PRIVATE.

The ISYNC variant of the same however appears to want TIF flags or
something to aid a number of archs, the rq->lock will not help there.
