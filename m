Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38612 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbeH3Nw4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Aug 2018 09:52:56 -0400
Date: Thu, 30 Aug 2018 10:51:49 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830095148.GB5942@arm.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830094411.GX24124@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180830095149.1iDIUri101XYfShCiE-tfuzwzsbInBgFQmsM70XOGBA@z>

On Thu, Aug 30, 2018 at 11:44:11AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 29, 2018 at 09:16:43PM +0000, Vineet Gupta wrote:
> > On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:
> > > Hi Guys,
> > > Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
> > > The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
> > > even on boot.
> > >
> > > I don't know exactly what breaks but bisect clearly assign the blame to this commit:
> > > 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> > > https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b09510825f6b9
> > >
> > > Reverting the commit solves this problem.
> > >
> > > I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
> > > generic bitops implementation and it works fine.
> > >
> > > Do you have any ideas what went wrong?
> > 
> > Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> > commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> > __clear_bit_unlock()")
> > That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> > __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> > 
> > This patch undoes that which could explain the issues you see. @Peter, @Will ?
> 
> Right, so the thinking is that on platforms that suffer that issue,
> atomic_set*() should DTRT. And if you look at your spinlock based atomic
> implementation, you'll note that atomic_set() does indeed do the right
> thing.
> 
> arch/arc/include/asm/atomic.h:108

Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644c56a
boils down to concurrent atomic_long_set_release() vs
atomic_long_fetch_or_acquire(), which really needs to work.

I'll keep digging. In the meantime, Vineet, do you have any useful crash
logs and do you only see the crashes in certain configurations (e.g. SMP but
!CONFIG_ARC_HAS_LLSC)?

Will
