Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050226211910.79dbfa45.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	 <1109222328.15027.12.camel@gaston>
	 <20050224143601.12c340ca.davem@davemloft.net>
	 <1109309524.14993.56.camel@gaston> <1109316055.14992.60.camel@gaston>
	 <20050225103730.75adf2f0.davem@davemloft.net>
	 <1109379369.15027.99.camel@gaston>
	 <20050226190943.7aa031e2.davem@davemloft.net>
	 <20050226211910.79dbfa45.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 12:45:28 +1100
Message-Id: <1109641528.15027.283.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2005-02-26 at 21:19 -0800, David S. Miller wrote:
> On Sat, 26 Feb 2005 19:09:43 -0800
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> > I know of at least three such cases so far, vmalloc.c:unmap_area_pte(),
> > vmalloc.c:map_area_pte(), and mprotect.c:change_pte_range()
> > 
> > The latter could definitely explain the behavior you are seeing on
> > ppc64.
> 
> Ok, here's a fix, let me know if it makes the PPC64 problems
> go away Ben.

Test machine has been LTP'ing happily over night with that patch.

Ben.
