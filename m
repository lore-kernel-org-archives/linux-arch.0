From: Jason Low <jason.low2@hp.com>
Subject: Re: [PATCH v8 3/6] MCS Lock: optimizations and extra comments
Date: Tue, 21 Jan 2014 13:01:05 -0800
Message-ID: <CAGQ1y=6SDNen_w4AVdbmvwat5RjuDb7OCtb_aUQzfqwJU3fMDw@mail.gmail.com>
References: <cover.1390239879.git.tim.c.chen@linux.intel.com>
	<1390267468.3138.37.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1390267468.3138.37.camel@schen9-DESK>
Sender: owner-linux-mm@kvack.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, H. Pete
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 20, 2014 at 5:24 PM, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> From: Jason Low <jason.low2@hp.com>

> @@ -41,8 +47,11 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>
>         prev = xchg(lock, node);
>         if (likely(prev == NULL)) {
> -               /* Lock acquired */
> -               node->locked = 1;
> +               /* Lock acquired, don't need to set node->locked to 1
> +                * as lock owner and other contenders won't check this value.
> +                * If a debug mode is needed to audit lock status, then
> +                * set node->locked value here.
> +                */

It would also be good to mention why the value is not checked
in this comment. Perhaps something like the following:

/*
 * Lock acquired, don't need to set node->locked to 1. Threads
 * only spin on its own node->locked value for lock acquisition.
 * However, since this thread can immediately acquire the lock
 * and does not proceed to spin on its own node->locked, this
 * value won't be used. If a debug mode is needed to
 * audit lock status, then set node->locked value here.
 */

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
