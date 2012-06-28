From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/20] mm: Add optional TLB flush to generic RCU
 page-table freeing
Date: Thu, 28 Jun 2012 22:00:01 +1000
Message-ID: <1340884801.20977.84.camel@pasglop>
References: <20120627211540.459910855@chello.nl>
	 <20120627212830.693232452@chello.nl>
	 <CA+55aFwa41fzvx8EZG_gODvw7hSpr+iP+w5fXp6jUcQh-4nFgQ@mail.gmail.com>
	 <1340838106.10063.85.camel@twins> <1340867364.20977.65.camel@pasglop>
	 <1340881511.28750.19.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1340881511.28750.19.camel@twins>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Alex Shi <alex.shi@intel.com>, "Nikunj A.
 Dadhania" <nikunj@linux.vnet.ibm.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tony Luck <tony.luck@intel.com>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit>
List-Id: linux-arch.vger.kernel.org

On Thu, 2012-06-28 at 13:05 +0200, Peter Zijlstra wrote:
> 
> > Some embedded ppc's know about the lowest level (SW loaded PMD) but
> > that's not an issue here. We flush these special TLB entries
> > specifically and synchronously in __pte_free_tlb().
> 
> OK, I missed that.. is that
> arch/powerpc/mm/tlb_nohash.c:tlb_flush_pgtable() ?

Yup.

> > > So even if the hardware did do speculative tlb fills, it would do
> them
> > > from the hash-table, but that's already cleared out.
> > 
> > Right,
> 
> Phew at least I got the important thing right ;-)

Yeah as long as we have that hash :-) The day we move on (if ever) it
will be as bad as ARM :-)

Cheers,
Ben.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
