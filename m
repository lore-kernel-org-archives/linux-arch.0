From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v7 4/6] MCS Lock: Barrier corrections
Date: Mon, 20 Jan 2014 08:09:12 +0100
Message-ID: <20140120070912.GA32324@gmail.com>
References: <cover.1389890175.git.tim.c.chen@linux.intel.com>
 <1389917308.3138.14.camel@schen9-DESK>
 <20140120023322.GL10038@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140120023322.GL10038@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Thu, Jan 16, 2014 at 04:08:28PM -0800, Tim Chen wrote:
> > This patch corrects the way memory barriers are used in the MCS lock
> > with smp_load_acquire and smp_store_release fucnction.
> > It removes ones that are not needed.
> > 
> > Note that using the smp_load_acquire/smp_store_release pair is not
> > sufficient to form a full memory barrier across
> > cpus for many architectures (except x86) for mcs_unlock and mcs_lock.
> > For applications that absolutely need a full barrier across multiple cpus
> > with mcs_unlock and mcs_lock pair, smp_mb__after_unlock_lock() should be
> > used after mcs_lock if a full memory barrier needs to be guaranteed.
> > 
> > From: Waiman Long <Waiman.Long@hp.com>
> > Suggested-by: Michel Lespinasse <walken@google.com>
> > Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> > Signed-off-by: Jason Low <jason.low2@hp.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> 
> And this fixes my gripes in the first patch in this series, good!

So I'd really suggest doing fixes first in the series, code movement 
second. That will make it much easier to backport the fix to -stable, 
should the need arise.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
