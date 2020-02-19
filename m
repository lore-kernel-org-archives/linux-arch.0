Return-Path: <SRS0=LzcT=4H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSP5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:57:37 -0500
Date: Wed, 19 Feb 2020 16:57:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200219155715.GD14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219154031.GE18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200219155715.MRTeTXkRWW2f0ofsi5ekwrueEB1sCkGlSldVQrv5i6w@z>

On Wed, Feb 19, 2020 at 04:40:31PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 10:36:14AM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2020 15:47:28 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > --- a/arch/x86/lib/memcpy_32.c
> > > +++ b/arch/x86/lib/memcpy_32.c
> > > @@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
> > >  }
> > >  EXPORT_SYMBOL(memset);
> > >  
> > > -__visible void *memmove(void *dest, const void *src, size_t n)
> > > +__visible notrace void *memmove(void *dest, const void *src, size_t n)
> > >  {
> > >  	int d0,d1,d2,d3,d4,d5;
> > >  	char *ret = dest;
> > > @@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
> > >  
> > >  }
> > >  EXPORT_SYMBOL(memmove);
> > 
> > Hmm, for things like this, which is adding notrace because of a single
> > instance of it (although it is fine to trace in any other instance), it
> > would be nice to have a gcc helper that could call "memmove+5" which
> > would skip the tracing portion.
> 
> Or just open-code the memmove() in do_double_fault() I suppose. I don't
> think we care about super optimized code there. It's the bloody ESPFIX
> trainwreck.

Something like so, I suppose...

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ef00eb6fbb9..543de932dc7c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -350,14 +350,20 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
 		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		unsigned long *dst = &gpregs->ip;
+		unsigned long *src = (void *)regs->dp;
+		int i, count = 5;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
 		 * ESPFIX64 stack.  Copy it to the entry stack.  This fills
 		 * in gpregs->ss through gpregs->ip.
-		 *
 		 */
-		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
+		for (i = 0; i < count; i++) {
+			int idx = (dst <= src) ? i : count - i;
+			dst[idx] = src[idx];
+		}
+
 		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
 
 		/*
