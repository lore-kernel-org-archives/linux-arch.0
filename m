From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Thu, 1 Aug 2013 22:10:18 +0200
Message-ID: <20130801201018.GR3008@twins.programming.kicks-ass.net>
References: <1375324631-32868-1-git-send-email-Waiman.Long@hp.com>
 <1375324631-32868-2-git-send-email-Waiman.Long@hp.com>
 <20130801094029.GK3008@twins.programming.kicks-ass.net>
 <51FAA1C3.2050507@hp.com>
 <51FAA5F8.2070209@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53598 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab3HAUKj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2013 16:10:39 -0400
Content-Disposition: inline
In-Reply-To: <51FAA5F8.2070209@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Waiman Long <waiman.long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Richard Weinberger <richard@nod.at>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matt Fleming <matt.fleming@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Akinobu Mita <akinobu.mita@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>, Harvey Harrison <harvey.ha>

On Thu, Aug 01, 2013 at 11:46:24PM +0530, Raghavendra K T wrote:
> On 08/01/2013 11:28 PM, Waiman Long wrote:
> >On 08/01/2013 05:40 AM, Peter Zijlstra wrote:
> >>On Wed, Jul 31, 2013 at 10:37:10PM -0400, Waiman Long wrote:
> >>
> [...]
> >>
> >>>+         */
> >>>+        for (qn_idx = 1; qn_idx<  MAX_QNODES; qn_idx++) {
> >>>+            if (!node[qn_idx].used)
> >>>+                break;
> >>        }
> >>
> >>>+        if (unlikely(qn_idx == MAX_QNODES)) {
> >>>+            /*
> >>>+             * This shouldn't happen, print a warning message
> >>>+             *&  busy spinning on the lock.
> >>>+             */
> >>>+            pr_warn("qspinlock: queue node table exhausted at "
> >>>+                "cpu %d!\n", cpu_nr);
> >>This could make your machine die hard.. not all contexts can printk().
> >
> >Do you have any suggestion? I could skip the warning and silently do the
> >busy spinning. I just want some way to notify the user of this rare event.
> 
> We have used debugfs in pv-spinlock to avoid that since printk uses
> spinlock again. may be it will help to profile many other parts of
> code too.

I always use early_printk(), but that requires you set up your serial
console properly and joe-user won't have done that.
