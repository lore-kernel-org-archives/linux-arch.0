Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbeHWQQ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Aug 2018 12:16:29 -0400
Date: Thu, 23 Aug 2018 13:46:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma
Message-ID: <20180823124649.sopnukdu4mfz6e46@armageddon.cambridge.arm.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823084709.19717-3-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org, bp@alien8.de, will.deacon@arm.com, riel@surriel.com, jannh@google.com, ascannell@google.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org
Message-ID: <20180823124650.HXAgfOhie9vi43lVRuFZHwSbHIdr1fTAj85_X3nYnzo@z>

On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
> The generic tlb_end_vma does not call invalidate_range mmu notifier,
> and it resets resets the mmu_gather range, which means the notifier
> won't be called on part of the range in case of an unmap that spans
> multiple vmas.
> 
> ARM64 seems to be the only arch I could see that has notifiers and
> uses the generic tlb_end_vma. I have not actually tested it.

We only care about notifiers for KVM but I think it only makes use of
mmu_notifier_invalidate_range_(start|end) which are not affected by the
range reset in mmu_gather.

Your patch looks ok from an arm64 perspective (it would be good if Will
has a look as well since he was the last to touch this part for arm64).

-- 
Catalin
