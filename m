Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48146 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLSTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 14:19:40 -0400
Date: Fri, 12 Apr 2019 20:19:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Message-ID: <20190412181930.GD12232@hirez.programming.kicks-ass.net>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <20190412111756.GO14281@hirez.programming.kicks-ass.net>
 <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20190412181930.oO9vbKKxxhhzXmO_VQRgxN_Ds2Ccu_3KPySShC8H_MI@z>

On Fri, Apr 12, 2019 at 03:11:22PM +0000, Nadav Amit wrote:
> > On Apr 12, 2019, at 4:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > To clarify, 'that' is Nadav's patch:
> > 
> >  515ab7c41306 ("x86/mm: Align TLB invalidation info")
> > 
> > which turns out to be the real problem.
> 
> Sorry for that. I still think it should be aligned, especially with all the
> effort the Intel puts around to avoid bus-locking on unaligned atomic
> operations.

No atomics anywhere in sight, so that's not a concern.

> So the right solution seems to me as putting this data structure off stack.
> It would prevent flush_tlb_mm_range() from being reentrant, so we can keep a
> few entries for this matter and atomically increase the entry number every
> time we enter flush_tlb_mm_range().
> 
> But my question is - should flush_tlb_mm_range() be reentrant, or can we
> assume no TLB shootdowns are initiated in interrupt handlers and #MC
> handlers?

There _should_ not be, but then don't look at those XPFO patches that
were posted (they're broken anyway).
