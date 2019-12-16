Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39922 "EHLO
 merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1727653AbfLPNUm (ORCPT <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec
 2019 08:20:42 -0500
Date: Mon, 16 Dec 2019 14:20:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
Message-ID: <20191216132004.GO2844@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org> <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191216132004.CXIDfrPdcc1dIdxlqJUFPpUqO1Z2Dqo-Z5AQbH8h5r4@z>

On Mon, Dec 16, 2019 at 06:43:53PM +0530, Aneesh Kumar K.V wrote:
> On 12/16/19 6:07 PM, Peter Zijlstra wrote:

> > I'm confused, are you saing you're happy to have PowerPC eat the extra
> > TLB invalidates? I thought you cared about PPC performance :-)
> > 
> > 
> 
> Instead can we do
> 
> static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> {
> #ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> 	 * Invalidate page-table caches used by hardware walkers. Then we still
> 	 * need to RCU-sched wait while freeing the pages because software
> 	 * walkers can still be in-flight.
> 	 */
> 	tlb_flush_mmu_tlbonly(tlb);
> #endif
> }

How does that not break ARM/ARM64/s390 and x86 ?
