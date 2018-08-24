From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Date: Fri, 24 Aug 2018 10:05:48 +0200
Message-ID: <20180824080548.GH24124@hirez.programming.kicks-ass.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, Adin Scannell <ascannell@google.com>, Dave Hansen <dave.hansen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 23, 2018 at 12:15:37PM -0700, Linus Torvalds wrote:
> PeterZ - your "mm/tlb, x86/mm: Support invalidating TLB caches for
> RCU_TABLE_FREE" patch looks exactly the same, but it now no longer has
> the split of tlb_flush_mmu_tlbonly(), since with Nick's patch to move
> the call to tlb_table_flush(tlb) into tlb_flush_mmu_free, there's no
> need for the separate double-underscore version.
> 
> I hope nothing I did screwed things up. It all looks sane to me.
> Famous last words.

Sorry; I got distracted by building a bunk bed for the kids -- and
somehow these things always take way more time than expected.

Anyway, the code looks good to me. Thanks all!
