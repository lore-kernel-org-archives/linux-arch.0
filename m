Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeHXC7I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Aug 2018 22:59:08 -0400
Date: Fri, 24 Aug 2018 00:27:05 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Message-ID: <20180823232704.GA4487@brain-police>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
 <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, Adin Scannell <ascannell@google.com>, Dave Hansen <dave.hansen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180823232705.5ZtT76m4Rsx1tGlxK9vh6rZxFoV9Zi49nSfph2aYtRo@z>

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
