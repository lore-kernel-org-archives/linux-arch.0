Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
Date: Fri, 10 Jul 2020 11:42:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Message-ID: <20200710094201.GZ4800@hirez.programming.kicks-ass.net>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710015646.2020871-5-npiggin@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710094201.nL-eK7iUKN4_ICKcn2YQEpcBbzJhzc4FraWZH7wlZks@z>

On Fri, Jul 10, 2020 at 11:56:43AM +1000, Nicholas Piggin wrote:
> And get rid of the generic sync_core_before_usermode facility.
> 
> This helper is the wrong way around I think. The idea that membarrier
> state requires a core sync before returning to user is the easy one
> that does not need hiding behind membarrier calls. The gap in core
> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
> tricky detail that is better put in x86 lazy tlb code.
> 
> Consider if an arch did not synchronize core in switch_mm either, then
> membarrier_mm_sync_core_before_usermode would be in the wrong place
> but arch specific mmu context functions would still be the right place.
> There is also a exit_lazy_tlb case that is not covered by this call, which
> could be a bugs (kthread use mm the membarrier process's mm then context
> switch back to the process without switching mm or lazy mm switch).
> 
> This makes lazy tlb code a bit more modular.

Hurmph, I know I've been staring at this at some point. I think I meant
to have a TIF to force the IRET path in the case of MEMBAR_SYNC_CORE.
But I was discouraged by amluto.
