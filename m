Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64872 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391Ab3KSW7n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Nov 2013 17:59:43 -0500
Subject: Re: [PATCH v5 2/4] MCS Lock: optimizations and extra comments
From: Tim Chen <tim.c.chen@linux.intel.com>
In-Reply-To: <20131119191310.GO4138@linux.vnet.ibm.com>
References: <cover.1383935697.git.tim.c.chen@linux.intel.com>
	 <1383940325.11046.415.camel@schen9-DESK>
	 <20131119191310.GO4138@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Nov 2013 14:57:41 -0800
Message-ID: <1384901861.11046.449.camel@schen9-DESK>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Will Deacon <will.deacon@arm.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20131119225741.n2ScODJKSncyQn8KB_eOvVqXPP1lSNSmfCVlFPoDTkM@z>

On Tue, 2013-11-19 at 11:13 -0800, Paul E. McKenney wrote:
> On Fri, Nov 08, 2013 at 11:52:05AM -0800, Tim Chen wrote:
> > 
> > +/*
> > + * Releases the lock. The caller should pass in the corresponding node that
> > + * was used to acquire the lock.
> > + */
> >  static void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
> >  {
> >  	struct mcs_spinlock *next = ACCESS_ONCE(node->next);
> > @@ -51,7 +60,7 @@ static void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *nod
> >  		/*
> >  		 * Release the lock by setting it to NULL
> >  		 */
> > -		if (cmpxchg(lock, node, NULL) == node)
> > +		if (likely(cmpxchg(lock, node, NULL) == node))
> 
> Agreed here as well.  Takes a narrow race to hit this.
> 
> So, did your testing exercise this path?  If the answer is "yes", 


Paul,

I did some instrumentation and confirmed that the path in question has 
been exercised.  So this patch should be okay.

Tim

> and if the issues that I called out in patch #1 are resolved:
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> >  			return;
> >  		/* Wait until the next pointer is set */
> >  		while (!(next = ACCESS_ONCE(node->next)))
> >

