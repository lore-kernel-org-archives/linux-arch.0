Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 26 Feb 2005 19:09:43 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 2 arch usage
Message-Id: <20050226190943.7aa031e2.davem@davemloft.net>
In-Reply-To: <1109379369.15027.99.camel@gaston>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	<1109222328.15027.12.camel@gaston>
	<20050224143601.12c340ca.davem@davemloft.net>
	<1109309524.14993.56.camel@gaston>
	<1109316055.14992.60.camel@gaston>
	<20050225103730.75adf2f0.davem@davemloft.net>
	<1109379369.15027.99.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 26 Feb 2005 11:56:09 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2005-02-25 at 10:37 -0800, David S. Miller wrote:
> > I bet the address arg is incorrect in some case.
> 
> Yes, probably. That's the same symptoms we had when zeromap_pud_range
> had the bug getting the address wrong, which means we fail to properly
> flush the hash & TLB for this PTE. I'm not at work (it's sat. already
> here :) but I'll have a look asap.

I added the debugging I suggested and did some runs on sparc64.

There are many pte level looping constructs of the form:

	pte = ...(pmd, address);
	address &= ~PMD_MASK;
	end = address + size;
	if (end > PMD_SIZE)
		end = PMD_SIZE;

	some_loop() {
		...
		set_pte_at(mm, address, pte);
		address += PAGE_SIZE;
		pte++;
		...
	}

This "address" mask screws everything up.

I know of at least three such cases so far, vmalloc.c:unmap_area_pte(),
vmalloc.c:map_area_pte(), and mprotect.c:change_pte_range()

The latter could definitely explain the behavior you are seeing on
ppc64.
