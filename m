Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45028 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1727241AbfLPMdn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Mon, 16 Dec 2019 07:33:43 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
In-Reply-To: <20191211122955.940455408@infradead.org>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
Date: Mon, 16 Dec 2019 18:01:58 +0530
Message-ID: <87woawzc1t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191216123158.TcstTj8WIj5L6f8tKVlSMFvVBsIXIiEpKue3L3Uoul4@z>

Peter Zijlstra <peterz@infradead.org> writes:

> Towards a more consistent naming scheme.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig              |    3 ++-
>  arch/powerpc/Kconfig      |    2 +-
>  arch/sparc/Kconfig        |    2 +-
>  include/asm-generic/tlb.h |    2 +-
>  mm/mmu_gather.c           |    2 +-
>  5 files changed, 6 insertions(+), 5 deletions(-)
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
>  config MMU_GATHER_RCU_TABLE_FREE
>  	bool
>  
> -config HAVE_RCU_TABLE_NO_INVALIDATE
> +config MMU_GATHER_NO_TABLE_INVALIDATE
>  	bool
> +	depends on MMU_GATHER_RCU_TABLE_FREE


Can we drop this Kernel config option instead use
MMU_GATHER_RCU_TABLE_FREE? IMHO reducing the kernel config related to
mmu_gather can reduce the complexity. 

>  
>  config HAVE_MMU_GATHER_PAGE_SIZE
>  	bool
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -223,7 +223,7 @@ config PPC
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select MMU_GATHER_RCU_TABLE_FREE		if SMP
> -	select HAVE_RCU_TABLE_NO_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
> +	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_MMU_GATHER_PAGE_SIZE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -65,7 +65,7 @@ config SPARC64
>  	select HAVE_KRETPROBES
>  	select HAVE_KPROBES
>  	select MMU_GATHER_RCU_TABLE_FREE if SMP
> -	select HAVE_RCU_TABLE_NO_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
> +	select MMU_GATHER_NO_TABLE_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select HAVE_DYNAMIC_FTRACE
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -137,7 +137,7 @@
>   *  When used, an architecture is expected to provide __tlb_remove_table()
>   *  which does the actual freeing of these pages.
>   *
> - *  HAVE_RCU_TABLE_NO_INVALIDATE
> + *  MMU_GATHER_NO_TABLE_INVALIDATE
>   *
>   *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
>   *  freeing the page-table pages. This can be avoided if you use
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -102,7 +102,7 @@ bool __tlb_remove_page_size(struct mmu_g
>   */
>  static inline void tlb_table_invalidate(struct mmu_gather *tlb)
>  {
> -#ifndef CONFIG_HAVE_RCU_TABLE_NO_INVALIDATE
> +#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
>  	/*
>  	 * Invalidate page-table caches used by hardware walkers. Then we still
>  	 * need to RCU-sched wait while freeing the pages because software
