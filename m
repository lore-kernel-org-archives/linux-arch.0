Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: (resend) Converting architectures to 4 level page tables
From: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20050126152533.63e43c58.davem@davemloft.net>
References: <41F2EB0E.30407@yahoo.com.au>
	 <20050125195043.45fed74b.davem@davemloft.net>
	 <41F78364.6060409@yahoo.com.au>
	 <20050126122623.34b40437.davem@davemloft.net>
	 <1106781719.5158.7.camel@npiggin-nld.site>
	 <20050126152533.63e43c58.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 10:39:17 +1100
Message-Id: <1106782757.5158.23.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-01-26 at 15:25 -0800, David S. Miller wrote:
> 
> It will warn like this:
> 
> foo.c:7:6: missing binary operator before token "("
> foo.c:10:32: missing binary operator before token "("
> 
> Which looks exactly like the kind of warnings mm/memory.c was
> producing for me on sparc64.
> 

OK you're right.

> Let's just face it that this is not a compile time test in
> any way.  We could make it so by creating some kind of
> PTRS_PER_PMD_MIGHT_BE_GREATER_THAN_ONE macro platforms can
> define but this is getting really rediculious :-)

Well I'd say just don't worry about the runtime test either.
It is only a small amount of dead code on PTRS_PER_XXX == 1
architectures, and a special enough case that I think that is
OK.

So I'd say just remove the check entirely. If someone really
cares, they can do the crazy macro!
