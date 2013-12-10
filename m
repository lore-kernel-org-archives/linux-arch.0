Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:33139 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451Ab3LJRTF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2013 12:19:05 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 10 Dec 2013 10:19:04 -0700
Date: Tue, 10 Dec 2013 09:18:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 tip/core/locking 6/7] locking: Add an
 smp_mb__after_unlock_lock() for UNLOCK+LOCK barrier
Message-ID: <20131210171859.GT4208@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20131210012738.GA24317@linux.vnet.ibm.com>
 <1386638883-25379-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1386638883-25379-6-git-send-email-paulmck@linux.vnet.ibm.com>
 <20131210170404.GB23506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131210170404.GB23506@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, darren@dvhart.com, fweisbec@gmail.com, sbw@mit.edu, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20131210171859.I6pWsEUtXqA2ob2pFg8igOePPTKfM1CnOzZCd6QFXps@z>

On Tue, Dec 10, 2013 at 06:04:04PM +0100, Oleg Nesterov wrote:
> On 12/09, Paul E. McKenney wrote:
> >
> > This commit therefore adds a smp_mb__after_unlock_lock(), which may be
> > placed after a LOCK primitive to restore the full-memory-barrier semantic.
> > All definitions are currently no-ops, but will be upgraded for some
> > architectures when queued locks arrive.
> 
> I am wondering, perhaps smp_mb__after_unlock() makes more sense?
> 
> Note that it already has the potential user:
> 
> 	--- x/kernel/sched/wait.c
> 	+++ x/kernel/sched/wait.c
> 	@@ -176,8 +176,9 @@ prepare_to_wait(wait_queue_head_t *q, wa
> 		spin_lock_irqsave(&q->lock, flags);
> 		if (list_empty(&wait->task_list))
> 			__add_wait_queue(q, wait);
> 	-	set_current_state(state);
> 	+	__set_current_state(state);
> 		spin_unlock_irqrestore(&q->lock, flags);
> 	+	smp_mb__after_unlock();
> 	 }
> 	 EXPORT_SYMBOL(prepare_to_wait);
> 	 
> 	@@ -190,8 +191,9 @@ prepare_to_wait_exclusive(wait_queue_hea
> 		spin_lock_irqsave(&q->lock, flags);
> 		if (list_empty(&wait->task_list))
> 			__add_wait_queue_tail(q, wait);
> 	-	set_current_state(state);
> 	+	__set_current_state(state);
> 		spin_unlock_irqrestore(&q->lock, flags);
> 	+	smp_mb__after_unlock();
> 	 }
> 	 EXPORT_SYMBOL(prepare_to_wait_exclusive);
> 	 
> 
> Assuming it can also be used "later", after another LOCK, like in
> your example in 5/7.

I am fine either way.  But there was an objection to tying this to the
unlock because it costs more on many architectures than tying this to
the lock.

But if you are saying "in addition to" rather than "instead of" that
would be a different conversation.

							Thanx, Paul

