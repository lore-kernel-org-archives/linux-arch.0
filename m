Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:37830 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757202AbYBWUJg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 23 Feb 2008 15:09:36 -0500
Date: Sat, 23 Feb 2008 12:08:18 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: + kthread-add-a-missing-memory-barrier-to-kthread_stop.patch
 added to -mm tree
In-Reply-To: <b647ffbd0802231151w481fdcb5hc2a3972e7fd03f69@mail.gmail.com>
Message-ID: <alpine.LFD.1.00.0802231202380.21332@woody.linux-foundation.org>
References: <200802230733.m1N7XnMu018253@imap1.linux-foundation.org>  <20080223162705.GA7686@tv-sign.ru>  <alpine.LFD.1.00.0802230937530.21332@woody.linux-foundation.org>  <20080223182258.GA19946@tv-sign.ru>  <alpine.LFD.1.00.0802231044240.21332@woody.linux-foundation.org>
 <b647ffbd0802231151w481fdcb5hc2a3972e7fd03f69@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, a.p.zijlstra@chello.nl, apw@shadowen.org, Ingo Molnar <mingo@elte.hu>, nickpiggin@yahoo.com.au, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org



On Sat, 23 Feb 2008, Dmitry Adamushko wrote:
> 
> it's not a LOAD that escapes *out* of the region. It's a MODIFY that gets *in*:

Not with the smp_wmb(). That's the whole point.

Ie the patch I'm suggesting is sufficient is appended, and the point is 
that any write before the critical region will be ordered wrt the critical 
region because of the write barrier before the spinlock (which itself is a 
write).

This is also why I mentioned that if you have a really odd architecure 
that considers spinlocks to be "outside" the normal cache coherency 
domain, that would be broken, but I cannot think of a single valid case of 
that, and I consider it insane.

(There are supecomputers that have a separate "barrier" network that can 
be used to do global ordering, but they don't generally do cache coherency 
and dependable memory ordering at all, which is why they need the separate 
barrier network in the first place. So that odd case isn't relevant to 
this discussion, even if it's historically interesting ;^)

But I'd love to hear a good argument why this wouldn't work on some 
architecture that we actually support (or might want to support in the 
future).. Memory ordering is interesting (even if the only people who do 
it right is Intel and AMD).

			Linus

---
 kernel/sched.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index f28f19e..3bceb3b 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1831,6 +1831,7 @@ static int try_to_wake_up(struct task_struct *p, unsigned int state, int sync)
 	long old_state;
 	struct rq *rq;
 
+	smp_wmb();
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
 	if (!(old_state & state))
