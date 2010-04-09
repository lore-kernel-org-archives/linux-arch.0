From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 07/13] powerpc: Preemptible mmu_gather
Date: Fri, 09 Apr 2010 10:14:07 +0200
Message-ID: <1270800847.20295.3225.camel@laptop>
References: <20100408191737.296180458@chello.nl>
	 <20100408192722.901224587@chello.nl>  <20100409040756.GK5683@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100409040756.GK5683@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>
List-Id: linux-arch.vger.kernel.org

On Fri, 2010-04-09 at 14:07 +1000, Nick Piggin wrote:
> On Thu, Apr 08, 2010 at 09:17:44PM +0200, Peter Zijlstra wrote:
> > Fix up powerpc to the new mmu_gather stuffs.
> > 
> > PPC has an extra batching queue to RCU free the actual pagetable
> > allocations, use the ARCH extentions for that for now.
> > 
> > For the ppc64_tlb_batch, which tracks the vaddrs to unhash from the
> > hardware hash-table, keep using per-cpu arrays but flush on context
> > switch and use a TIF bit to track the laxy_mmu state.
> 
> Hm. Pity powerpc can't just use tlb flush gathering for this batching,
> (which is what it was designed for). Then it could avoid these tricks.
> What's preventing this? Adding a tlb gather for COW case in
> copy_page_range?

I'm not quite sure what about that, didn't fully investigate it, just
wanted to get something working for now.

Of of the things is that both power and sparc need more than the struct
page we normally gather.

I did think of making the mmu_gather have something like

struct mmu_page {
  struct page *page;
#ifdef HAVE_ARCH_TLB_VADDR
  unsigned long vaddr;
#endif
};

struct mmu_gather {
  ...
  unsigned int nr;
  struct mmu_page *pages;
};


and doing that vaddr collection right along with it in the same batch.

I think that that would work, Ben, Dave?
