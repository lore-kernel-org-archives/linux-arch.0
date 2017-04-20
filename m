From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Thu, 20 Apr 2017 20:00:43 +0100
Message-ID: <20170420190042.GA9795@leverpostej>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
 <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
 <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935080AbdDTTBO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Apr 2017 15:01:14 -0400
Content-Disposition: inline
In-Reply-To: <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, linux-arm-kernel@lists.infradead.org

On Thu, Apr 20, 2017 at 09:23:18PM +0300, Yury Norov wrote:
> On Thu, Apr 13, 2017 at 08:12:12PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 11, 2017 at 01:35:04AM +0400, Yury Norov wrote:
> > 
> > > +++ b/arch/arm64/include/asm/qspinlock.h
> > > @@ -0,0 +1,20 @@
> > > +#ifndef _ASM_ARM64_QSPINLOCK_H
> > > +#define _ASM_ARM64_QSPINLOCK_H
> > > +
> > > +#include <asm-generic/qspinlock_types.h>
> > > +
> > > +#define	queued_spin_unlock queued_spin_unlock
> > > +/**
> > > + * queued_spin_unlock - release a queued spinlock
> > > + * @lock : Pointer to queued spinlock structure
> > > + *
> > > + * A smp_store_release() on the least-significant byte.
> > > + */
> > > +static inline void queued_spin_unlock(struct qspinlock *lock)
> > > +{
> > > +	smp_store_release((u8 *)lock, 0);
> > > +}
> > 
> > I'm afraid this isn't enough for arm64. I suspect you want your own
> > variant of queued_spin_unlock_wait() and queued_spin_is_locked() as
> > well.
> > 
> > Much memory ordering fun to be had there.
> 
> Hi Peter,
> 
> Is there some test to reproduce the locking failure for the case. I
> ask because I run loctorture for many hours on my qemu (emulating
> cortex-a57), and I see no failures in the test reports.

Even with multi-threaded TCG, a system emulated with QEMU will have far
stronger memory ordering than a real platform. So stress tests on such a
system are useless for testing memory ordering properties.

I would strongly advise that you use a real platform for anything beyond
basic tests when touching code in this area.

> And Jan did it on ThunderX, and Adam on QDF2400 without any problems.
> So even if I rework those functions, how could I check them for
> correctness?

Given the variation the architecture permits, and how difficult it is to
diagnose issues in this area, testing isn't enough here.

You need at least some informal proof as to the primitives doing what
they should, i.e. you should be able to explain why the code is correct.

Thanks,
Mark.
