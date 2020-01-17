Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1726741AbgAQBq2
 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jan 2020 20:46:28 -0500
Date: Thu, 16 Jan 2020 17:46:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] asm-generic/tlb: Avoid potential double flush
Message-ID: <20200116174626.0244f71bbff64eee6c7faa1d@linux-foundation.org>
In-Reply-To: <c12bb139-9eda-74a9-b4de-b147a88ed1b0@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
 <20200116064531.483522-4-aneesh.kumar@linux.ibm.com>
 <c12bb139-9eda-74a9-b4de-b147a88ed1b0@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20200117014626.YjhCLpPG4M7ROiugBSzwz9_7g5_jNyE_W8UCLBE8hqk@z>

On Thu, 16 Jan 2020 12:19:59 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> On 1/16/20 12:15 PM, Aneesh Kumar K.V wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Aneesh reported that:
> > 
> > 	tlb_flush_mmu()
> > 	  tlb_flush_mmu_tlbonly()
> > 	    tlb_flush()			<-- #1
> > 	  tlb_flush_mmu_free()
> > 	    tlb_table_flush()
> > 	      tlb_table_invalidate()
> > 		tlb_flush_mmu_tlbonly()
> > 		  tlb_flush()		<-- #2
> > 
> > does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
> > clear tlb->end in that case.
> > 
> > Observe that any caller to __tlb_adjust_range() also sets at least one
> > of the tlb->freed_tables || tlb->cleared_p* bits, and those are
> > unconditionally cleared by __tlb_reset_range().
> > 
> > Change the condition for actually issuing TLBI to having one of those
> > bits set, as opposed to having tlb->end != 0.
> > 
> 
> 
> We should possibly get this to stable too along with the first two 
> patches. I am not quiet sure if this will qualify for a stable backport. 
> Hence avoided adding Cc:stable@kernel.org

I'm not seeing any description of the user-visible runtime effects. 
Always needed, especially for -stable, please.

It appears to be a small performance benefit?  If that benefit was
"large" and measurements were presented then that would be something
we might wish to backport.
