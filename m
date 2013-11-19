Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:57924 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab3KSTNU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 14:13:20 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 19 Nov 2013 12:13:19 -0700
Date: Tue, 19 Nov 2013 11:13:10 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/4] MCS Lock: optimizations and extra comments
Message-ID: <20131119191310.GO4138@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1383935697.git.tim.c.chen@linux.intel.com>
 <1383940325.11046.415.camel@schen9-DESK>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1383940325.11046.415.camel@schen9-DESK>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Will Deacon <will.deacon@arm.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20131119191310.aSXbOegWvgBdg-GcqVWBzH3txoA-U0DqM31GB2AMY-s@z>

On Fri, Nov 08, 2013 at 11:52:05AM -0800, Tim Chen wrote:
> From: Jason Low <jason.low2@hp.com>
> 
> Remove unnecessary operation and make the cmpxchg(lock, node, NULL) == node
> check in mcs_spin_unlock() likely() as it is likely that a race did not occur
> most of the time.
> 
> Also add in more comments describing how the local node is used in MCS locks.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Jason Low <jason.low2@hp.com>
> ---
>  include/linux/mcs_spinlock.h |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mcs_spinlock.h b/include/linux/mcs_spinlock.h
> index b5de3b0..96f14299 100644
> --- a/include/linux/mcs_spinlock.h
> +++ b/include/linux/mcs_spinlock.h
> @@ -18,6 +18,12 @@ struct mcs_spinlock {
>  };
> 
>  /*
> + * In order to acquire the lock, the caller should declare a local node and
> + * pass a reference of the node to this function in addition to the lock.
> + * If the lock has already been acquired, then this will proceed to spin
> + * on this node->locked until the previous lock holder sets the node->locked
> + * in mcs_spin_unlock().
> + *
>   * We don't inline mcs_spin_lock() so that perf can correctly account for the
>   * time spent in this lock function.
>   */
> @@ -33,7 +39,6 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>  	prev = xchg(lock, node);
>  	if (likely(prev == NULL)) {
>  		/* Lock acquired */
> -		node->locked = 1;

Agreed, no one looks at this field in this case, so no need to initialize
it, unless for debug purposes.

>  		return;
>  	}
>  	ACCESS_ONCE(prev->next) = node;
> @@ -43,6 +48,10 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>  		arch_mutex_cpu_relax();
>  }
> 
> +/*
> + * Releases the lock. The caller should pass in the corresponding node that
> + * was used to acquire the lock.
> + */
>  static void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>  {
>  	struct mcs_spinlock *next = ACCESS_ONCE(node->next);
> @@ -51,7 +60,7 @@ static void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *nod
>  		/*
>  		 * Release the lock by setting it to NULL
>  		 */
> -		if (cmpxchg(lock, node, NULL) == node)
> +		if (likely(cmpxchg(lock, node, NULL) == node))

Agreed here as well.  Takes a narrow race to hit this.

So, did your testing exercise this path?  If the answer is "yes", and
if the issues that I called out in patch #1 are resolved:

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

>  			return;
>  		/* Wait until the next pointer is set */
>  		while (!(next = ACCESS_ONCE(node->next)))
> -- 
> 1.7.4.4
> 
> 
> 

