Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34427 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHXQ7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Aug 2018 12:59:00 -0400
Date: Fri, 24 Aug 2018 06:24:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
Message-ID: <20180824132419.GA9983@roeck-us.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net>
 <20180824131026.GB11868@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824131026.GB11868@brain-police>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org, bp@alien8.de, riel@surriel.com, jannh@google.com, ascannell@google.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org
Message-ID: <20180824132419.JlsGi-bYdG47X-t0cS-yiyX4tx1LsNX65LnrMPMvUvg@z>

On Fri, Aug 24, 2018 at 02:10:27PM +0100, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 06:07:22AM -0700, Guenter Roeck wrote:
> > On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
> > > The generic tlb_end_vma does not call invalidate_range mmu notifier,
> > > and it resets resets the mmu_gather range, which means the notifier
> > > won't be called on part of the range in case of an unmap that spans
> > > multiple vmas.
> > > 
> > > ARM64 seems to be the only arch I could see that has notifiers and
> > > uses the generic tlb_end_vma. I have not actually tested it.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > This patch breaks riscv builds in mainline.
> 
> Looks very similar to the breakage we hit on arm64. diff below should fix
> it.
> 

Unfortunately it doesn't.

In file included from ./arch/riscv/include/asm/pgtable.h:26:0,
                 from ./include/linux/memremap.h:7,
                 from ./include/linux/mm.h:27,
                 from arch/riscv/mm/fault.c:23:
./arch/riscv/include/asm/tlb.h: In function ‘tlb_flush’:
./arch/riscv/include/asm/tlb.h:19:18: error: dereferencing pointer to incomplete type ‘struct mmu_gather’
  flush_tlb_mm(tlb->mm);
                  ^
./arch/riscv/include/asm/tlbflush.h:58:35: note: in definition of macro ‘flush_tlb_mm’
  sbi_remote_sfence_vma(mm_cpumask(mm)->bits, 0, -1)

Note that reverting the offending patch does fix the problem,
so there is no secondary problem lurking around.

Guenter
