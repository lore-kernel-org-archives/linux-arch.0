From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/2] sched: INIT_PREEMPT_COUNT
Date: Fri, 10 Jul 2009 17:51:06 +0200
Message-ID: <1247241066.7529.50.camel@twins>
References: <20090710125755.559739294@chello.nl>
	 <20090710130125.037018244@chello.nl>
	 <17047.1247240546@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755606AbZGJPvX@vger.kernel.org>
In-Reply-To: <17047.1247240546@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu, tony.luck@intel.com, rth@twiddle.net, geert@linux-m68k.org
List-Id: linux-arch.vger.kernel.org

On Fri, 2009-07-10 at 11:42 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Jul 2009 14:57:56 +0200, Peter Zijlstra said:
> 
> > +/*
> > + * Disable preemption until the scheduler is running.
> > + * Reset by start_kernel()->sched_init()->init_idle().
> > + */
> > +#define INIT_PREEMPT_COUNT	(1)
> > +
> 
> I had to look at this for quite some time before it sank in that it wasn't
> a reset of a #define, or a reset of (1) (anybody else remember changing the
> value of '5' in a Fortran program?).  Especially when stuck in with a bunch
> of cputimer defines. Would have taken even longer if I was looking in sched.h
> for something and not looking at this patch at the same time.
> 
> Can we fix this comment to mention it's thread_info.preempt_count that
> needs the reset?

Something along the lines of the below?

---
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -502,7 +502,9 @@ struct task_cputime {
 
 /*
  * Disable preemption until the scheduler is running.
- * Reset by start_kernel()->sched_init()->init_idle().
+ *
+ * We reset this initial offset of init_thread_info.preempt_count in:
+ *     start_kernel()->sched_init()->init_idle().
  */
 #define INIT_PREEMPT_COUNT	(1)
 
