From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Date: Fri, 24 Aug 2018 00:27:05 +0100
Message-ID: <20180823232704.GA4487@brain-police>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
 <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, Adin Scannell <ascannell@google.com>, Dave Hansen <dave.hansen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Linus,

On Thu, Aug 23, 2018 at 12:37:58PM -0700, Linus Torvalds wrote:
> On Thu, Aug 23, 2018 at 12:15 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So right now my "tlb-fixes" branch looks like this:
> > [..]
> >
> > I'll do a few more test builds and boots, but I think I'm going to
> > merge it in this cleaned-up and re-ordered form.
> 
> In the meantime, I decided to push out that branch in case anybody
> wants to look at it.
> 
> I may rebase it if I - or anybody else - find anything bad there, so
> consider it non-stable, but I think it's in its final shape modulo
> issues.

Unfortunately, that branch doesn't build for arm64 because of Nick's patch
moving tlb_flush_mmu_tlbonly() into tlb.h (which I acked!). It's a static
inline which calls tlb_flush(), which in our case is also a static inline
but one that is defined in our asm/tlb.h after including asm-generic/tlb.h.

Ah, just noticed you've pushed this to master! Please could you take the
arm64 patch below on top, in order to fix the build?

Cheers,

Will

--->8

From 48ea452db90a91ff2b62a94277daf565e715a126 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Fri, 24 Aug 2018 00:23:04 +0100
Subject: [PATCH] arm64: tlb: Provide forward declaration of tlb_flush() before
 including tlb.h

As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
asm-generic/tlb.h now calls tlb_flush() from a static inline function,
so we need to make sure that it's declared before #including the
asm-generic header in the arch header.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 0ad1cf233470..a3233167be60 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -33,6 +33,8 @@ static inline void __tlb_remove_table(void *_table)
 #define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
 #endif /* CONFIG_HAVE_RCU_TABLE_FREE */
 
+static void tlb_flush(struct mmu_gather *tlb);
+
 #include <asm-generic/tlb.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
-- 
2.7.4
