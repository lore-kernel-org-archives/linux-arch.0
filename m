Return-Path: <SRS0=4F7u=A4=kvack.org=owner-linux-mm@kernel.org>
Message-ID: <20200717111005.024867618@infradead.org>
Date: Fri, 17 Jul 2020 13:10:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 00/11] Fixup page directory freeing
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200717111005.zU7U26RbRzkZe6yO0_QMKshDjujbv3kh2cXTpp28O9s@z>

Hi All,

While fixing a silly bug on SH (patch #1), I realized that even with the
trivial patch to restore prior behaviour, page directory freeing was still
broken.

The thing is, on anything SMP, freeing page directories should observe the
exact same order as normal page freeing:

 1) unhook page/directory
 2) TLB invalidate
 3) free page/directory

Without this any concurrent page-table walk could end up with a Use-after-Free.
This is esp. trivial for anything that has software page-table walkers
(HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
(ie. caches page directories).

Even on UP this might give issues, since mmu_gather is preemptible these days.
An interrupt or preempted task accessing user pages might stumble into the free
page if the hardware caches page directories.

So I've converted everything to always observe the above order, simply so we
don't have to worry about it.

If however I've been over zealous and your arch/mmu really doesn't need this
and you're offended by this potentially superfluous code, please let me know
and I'll replace the patch with one that adds a comment describing your
rationale for why it is not needed.


v1: https://lkml.kernel.org/r/20191211120713.360281197@infradead.org
