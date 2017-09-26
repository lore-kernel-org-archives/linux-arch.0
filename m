From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Tue, 26 Sep 2017 09:47:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709260941040.1941@nanos>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com> <20170925151826.GK828415@devbig577.frc2.facebook.com> <20170925153301.GA29775@leverpostej> <20170925154404.GA560070@devbig577.frc2.facebook.com>
 <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967653AbdIZHrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2017 03:47:15 -0400
In-Reply-To: <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org

On Tue, 26 Sep 2017, Christopher Lameter wrote:
> On Mon, 25 Sep 2017, Tejun Heo wrote:
> 
> > Hello,
> >
> > On Mon, Sep 25, 2017 at 04:33:02PM +0100, Mark Rutland wrote:
> > > Unfortunately, the generic this_cpu_read(), which is intended to be
> > > irq-safe, is not:
> > >
> > > #define this_cpu_generic_read(pcp)                                      \
> > > ({                                                                      \
> > >         typeof(pcp) __ret;                                              \
> > >         preempt_disable_notrace();                                      \
> > >         __ret = raw_cpu_generic_read(pcp);                              \
> > >         preempt_enable_notrace();                                       \
> > >         __ret;                                                          \
> > > })
> >
> > I see.  Yeah, that looks like the bug there.
> 
> This is a single fetch operation of a value that needs to be atomic. It
> really does not matter if an interrupt happens before or after that load
> because it could also occur before or after the preempt_enable/disable
> without the code being able to distinguish that case.
> 
> The fetch of a scalar value from memory is an atomic operation and that is
> required from all arches. There is an exception for double word fetches.

this_cpu_read_8() is a double word fetch on many 32bit architectures.

> Maybe we would need to special code that case but so far this does not
> seem to have been an issue.

Just because nobody ran into problem with that it is a non issue? That's
just hillarious.

It's obviously not correct and needs to be fixed _before_ someone has to go
through the pain of debugging such a problem.

Thanks,

	tglx
