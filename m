From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v3 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Thu, 30 Jan 2014 14:27:03 -0800
Message-ID: <1391120823.3138.92.camel@schen9-DESK>
References: <1390933151-1797-1-git-send-email-Waiman.Long@hp.com>
	 <1390933151-1797-2-git-send-email-Waiman.Long@hp.com>
	 <1391108430.3138.86.camel@schen9-DESK>
	 <20140130192835.GK5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18399 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbaA3W1G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Jan 2014 17:27:06 -0500
In-Reply-To: <20140130192835.GK5002@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>


> > > +	/*
> > > +	 * Set up the new cpu code to be exchanged
> > > +	 */
> > > +	my_qcode = SET_QCODE(cpu_nr, qn_idx);
> > > +
> > 
> > If we get interrupted here before we have a chance to set the used flag,
> > the interrupt handler could pick up the same qnode if it tries to
> > acquire queued spin lock.  Then we could overwrite the qcode we have set
> > here.
> > 
> > Perhaps an exchange operation for the used flag to prevent this race
> > condition?
> 
> I don't get why we need the used thing at all; something like:
> 
> struct qna {
> 	int cnt;
> 	struct qnode nodes[4];
> };
> 
> DEFINE_PER_CPU(struct qna, qna);
> 
> struct qnode *get_qnode(void)
> {
> 	struct qna *qna = this_cpu_ptr(&qna);
> 
> 	return qna->nodes[qna->cnt++]; /* RMW */
> }
> 
> void put_qnode(struct qnode *qnode)
> {
> 	struct qna *qna = this_cpu_ptr(&qna);
> 	qna->cnt--;
> }
> 
> Should do fine, right?
> 
> If we interrupt the RMW above the interrupted context hasn't yet used
> the queue and once we return its free again, so all should be well even
> on load-store archs.

Agreed. This approach is more efficient and avoid the overhead 
searching for unused node and setting used flag.

Tim

> 
> The nodes array might as well be 3, because NMIs should never contend on
> a spinlock, so all we're left with is task, softirq and hardirq context.
