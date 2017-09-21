From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] membarrier: Provide register expedited
 private command
Date: Thu, 21 Sep 2017 14:13:44 +0200
Message-ID: <20170921121344.movkcoj6rm2s23ig@hirez.programming.kicks-ass.net>
References: <20170918223648.31505-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35360 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdIUMOZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2017 08:14:25 -0400
Content-Disposition: inline
In-Reply-To: <20170918223648.31505-1-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org

On Mon, Sep 18, 2017 at 06:36:47PM -0400, Mathieu Desnoyers wrote:
> @@ -3373,6 +3362,7 @@ static void __sched notrace __schedule(bool preempt)
>  
>  		/* Also unlocks the rq: */
>  		rq = context_switch(rq, prev, next, &rf);
> +		membarrier_arch_sched_in(prev, next);

That's wrong iirc; we just switched stacks, you cannot use @prev and
@next.

>  	} else {
>  		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
>  		rq_unlock_irq(rq, &rf);
