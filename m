From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 02/34] arch: Consolidate tsk_is_polling()
Date: Fri, 22 Mar 2013 10:26:19 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303221025530.22263@ionos>
References: <20130321214930.752934102@linutronix.de> <20130321215233.446034505@linutronix.de> <20130322052010.GB31022@thor.bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35272 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933079Ab3CVJ0Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2013 05:26:25 -0400
In-Reply-To: <20130322052010.GB31022@thor.bakeyournoodle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

On Fri, 22 Mar 2013, Tony Breeds wrote:

> On Thu, Mar 21, 2013 at 09:52:57PM -0000, Thomas Gleixner wrote:
>  
> > +/*
> > + * Idle thread specific functions to determine the need_resched
> > + * polling state. We have two versions, one based on TS_POLLING in
> > + * thread_info.status and one based on TIF_POLLING_NRFLAG in
> > + * thread_info.flags
> > + */
> > +#ifdef TS_POLLING
> > +static inline int tsk_is_polling(struct task_struct *p)
> > +{
> > +	return task_thread_info(p)->status & TS_POLLING;
> > +}
> > +#elif defined(TIF_POLLING_NRFLAG)
> > +static inline int tsk_is_polling(struct task_struct *p)
> > +{
> > +	test_tsk_thread_flag(p, TIF_POLLING_NRFLAG);
> > +}
> 
> On powerpc (at least) this is used before it's declared.  Also I think
> you're missing a 'return' in that function.

Mooo
 
> *cough* https://www.kernel.org/pub/tools/crosstool/ *cough*

Yes, I know. /me feels bad
