Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 14 Apr 2020 00:23:16 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200414072316.GA5503@infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414072316.f3bOkFQ0g5hyGI3XIDBumhq-O8D4ol5oStKnlaxgmj8@z>

On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappings,
> have vmalloc attempt to allocate PMD-sized pages first, before falling back
> to small pages. Allocations which use something other than PAGE_KERNEL
> protections are not permitted to use huge pages yet, not all callers expect
> this (e.g., module allocations vs strict module rwx).
> 
> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), from
> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.
> 
> This can result in more internal fragmentation and memory overhead for a
> given allocation. It can also cause greater NUMA unbalance on hashdist
> allocations.
> 
> There may be other callers that expect small pages under vmalloc but use
> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
> alternative would be a new function or flag which enables large mappings,
> and use that in callers.

Why do we even use vmalloc in this case rather than just doing a huge
page allocation?  What callers are you intersted in?
