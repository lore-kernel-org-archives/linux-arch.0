Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050226190943.7aa031e2.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	 <1109222328.15027.12.camel@gaston>
	 <20050224143601.12c340ca.davem@davemloft.net>
	 <1109309524.14993.56.camel@gaston> <1109316055.14992.60.camel@gaston>
	 <20050225103730.75adf2f0.davem@davemloft.net>
	 <1109379369.15027.99.camel@gaston>
	 <20050226190943.7aa031e2.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 27 Feb 2005 20:35:57 +1100
Message-Id: <1109496957.14992.196.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2005-02-26 at 19:09 -0800, David S. Miller wrote:
> .../...
> There are many pte level looping constructs of the form:
> 
> 	pte = ...(pmd, address);
> 	address &= ~PMD_MASK;
> 	end = address + size;
> 	if (end > PMD_SIZE)
> 		end = PMD_SIZE;
> 
> 	some_loop() {
> 		...
> 		set_pte_at(mm, address, pte);
> 		address += PAGE_SIZE;
> 		pte++;
> 		...
> 	}
> 
> This "address" mask screws everything up.
> 
> I know of at least three such cases so far, vmalloc.c:unmap_area_pte(),
> vmalloc.c:map_area_pte(), and mprotect.c:change_pte_range()
> 
> The latter could definitely explain the behavior you are seeing on
> ppc64.

Indeed. Sorry, didn't have a chance to test myself yet here, but that's
definitely a bad one. Note that some of those functions use an address +
base (which would work, I suspect that was a later fix to the ones that
do pte_alloc etc...) and some use yet another scheme where the proper
address is passed along (the ones precalculating "next"). I prefer the
later version.

That's just another argument for having all these sharing common code,
even if it's a bit bulky macro at first, the current state of affairs is
just too prone to fail in weird ways.

Ben.
