From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Fri, 22 Sep 2017 10:24:41 +0200
Message-ID: <20170922082441.rxavx645ewoizuu2@hirez.programming.kicks-ass.net>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
 <20170922032206.GE10893@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46743 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdIVIZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 04:25:00 -0400
Content-Disposition: inline
In-Reply-To: <20170922032206.GE10893@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org

On Fri, Sep 22, 2017 at 11:22:06AM +0800, Boqun Feng wrote:

> The idea is in membarrier_private_expedited(), we go through all ->curr
> on each CPU and 
> 
> 1)	If it's a userspace task and its ->mm is matched, we send an ipi
> 
> 2)	If it's a kernel task, we skip
> 
> 	(Because there will be a smp_mb() implied by mmdrop(), when it
> 	switchs to userspace task).
> 
> 3)	If it's a userspace task and its ->mm is not matched, we take
> 	the corresponding rq->lock and check rq->curr again, if its ->mm
> 	matched, we send an ipi, otherwise we do nothing.
> 
> 	(Because if we observe rq->curr is not matched with rq->lock
> 	held, when a task having matched ->mm schedules in, the rq->lock
> 	pairing along with the smp_mb__after_spinlock() will guarantee
> 	it observes all memory ops before sys_membarrir()).

3) is an insta DoS.
