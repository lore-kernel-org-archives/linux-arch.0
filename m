Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Changing  update_mmu_cache()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050225201538.B27842@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston>
	 <20050222090741.B16786@flint.arm.linux.org.uk>
	 <20050222100858.27d05a86.davem@davemloft.net>
	 <20050225201538.B27842@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 12:10:17 +1100
Message-Id: <1109380217.14993.110.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2005-02-25 at 20:15 +0000, Russell King wrote:

> The item I was referring to was my flush_cache_page() changes from
> January 11th (attached), posted to both linux-arch and lkml, and
> previous to that in November some time, along with Linus' reply,
> and my somewhat later reply.

ppc & ppc64 don't use flush_cache_page() so I have little experience
with it, but your patch is fine in that sense that it will have no
impact for me :)

Ben.
