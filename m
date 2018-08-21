Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725732AbeHUFMT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 01:12:19 -0400
Date: Tue, 21 Aug 2018 02:54:15 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Message-ID: <20180821015413.GD1758@brain-police>
References: <20180820162639.GC25153@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820162639.GC25153@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180821015415.-GgBRsotbw85e40os-71vy8xbzmJAJ0rBruVqSaMk-8@z>

On Mon, Aug 20, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
> On Mon, Aug 20, 2018 at 05:56:50PM +0200, Peter Zijlstra wrote:
> > Yeah, _acquire should be retained; sorry about loosing that. I'm neck
> > deep into tlb invalidate stuff and wrote this without much thinking
> > involved.
> 
> NP.  Here's the current version I've got, with some updated likely()
> hints.
> 
> From 337298a88266f7b21492f893c2bf05409a5392c8 Mon Sep 17 00:00:00 2001
> From: Matthew Wilcox <willy@infradead.org>
> Date: Mon, 20 Aug 2018 10:19:14 -0400
> Subject: [PATCH] locking: Remove an insn from spin and write locks
> 
> Both spin locks and write locks currently do:
> 
>  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>  85 c0                   test   %eax,%eax
>  75 05                   jne    [slowpath]
> 
> This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
> appropriately.  Peter pointed out that using atomic_try_cmpxchg_acquire()
> will let the compiler know this is true.  Comparing before/after
> disassemblies show the only effect is to remove this insn.
> 
> Take this opportunity to make the spin & write lock code resemble each
> other more closely and have similar likely() hints.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/asm-generic/qrwlock.h   |  7 ++++---
>  include/asm-generic/qspinlock.h | 17 ++++++++++-------
>  2 files changed, 14 insertions(+), 10 deletions(-)

Shouldn't make any difference on arm64, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
