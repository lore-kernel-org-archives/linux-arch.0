From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 3/6] MCS Lock: optimizations and extra comments
Date: Tue, 21 Jan 2014 11:17:42 +0100
Message-ID: <20140121101742.GR31570@twins.programming.kicks-ass.net>
References: <cover.1390239879.git.tim.c.chen@linux.intel.com>
 <1390267468.3138.37.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1390267468.3138.37.camel@schen9-DESK>
Sender: owner-linux-mm@kvack.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 20, 2014 at 05:24:28PM -0800, Tim Chen wrote:
> @@ -41,8 +47,11 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>  
>  	prev = xchg(lock, node);
>  	if (likely(prev == NULL)) {
> -		/* Lock acquired */
> -		node->locked = 1;
> +		/* Lock acquired, don't need to set node->locked to 1
> +		 * as lock owner and other contenders won't check this value.
> +		 * If a debug mode is needed to audit lock status, then
> +		 * set node->locked value here.
> +		 */

Fail in comment style.

>  		return;
>  	}
>  	ACCESS_ONCE(prev->next) = node;

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
