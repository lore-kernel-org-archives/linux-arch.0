From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Tue, 26 Sep 2017 18:28:31 +0100
Message-ID: <20170926172830.GF15480@leverpostej>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
 <20170925151826.GK828415@devbig577.frc2.facebook.com>
 <20170925153301.GA29775@leverpostej>
 <20170925154404.GA560070@devbig577.frc2.facebook.com>
 <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968060AbdIZR37 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Sep 2017 13:29:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org

Hi,

On Tue, Sep 26, 2017 at 01:47:27AM -0500, Christopher Lameter wrote:
> On Mon, 25 Sep 2017, Tejun Heo wrote:
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

Unfortunately, this instance is not necessarily a single fetch operation,
given that the access is a plain C load from a pointer:

#define raw_cpu_generic_read(pcp)                                       \
({                                                                      \
        *raw_cpu_ptr(&(pcp));                                           \
})

... and thus the compiler is at liberty to tear the access across
multiple instructions. It probably won't, and it would almost certainly
be stupid to do so, but for better or worse we have no guarantee.

> The fetch of a scalar value from memory is an atomic operation and that is
> required from all arches.

Sure, where we ensure said fetch is a single access (e.g. with
READ_ONCE()). Otherwise the compiler is at liberty to tear the access
(e.g. if it fuses it with nearby accesses into a memcpy).

> There is an exception for double word fetches.  Maybe we would need to
> special code that case but so far this does not seem to have been an
> issue.

I've sent a v2 which fixes both cases, only disabling interrupts for
those doubleword fetches, and otherwise using READ_ONCE() to prevent
tearing.

Thanks,
Mark.
