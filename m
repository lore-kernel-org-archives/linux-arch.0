Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 26 Jan 2005 15:41:58 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: (resend) Converting architectures to 4 level page tables
Message-Id: <20050126154158.4863f0e8.davem@davemloft.net>
In-Reply-To: <1106782757.5158.23.camel@npiggin-nld.site>
References: <41F2EB0E.30407@yahoo.com.au>
	<20050125195043.45fed74b.davem@davemloft.net>
	<41F78364.6060409@yahoo.com.au>
	<20050126122623.34b40437.davem@davemloft.net>
	<1106781719.5158.7.camel@npiggin-nld.site>
	<20050126152533.63e43c58.davem@davemloft.net>
	<1106782757.5158.23.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 27 Jan 2005 10:39:17 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Well I'd say just don't worry about the runtime test either.
> It is only a small amount of dead code on PTRS_PER_XXX == 1
> architectures, and a special enough case that I think that is
> OK.
> 
> So I'd say just remove the check entirely. If someone really
> cares, they can do the crazy macro!

Okie dokie.  I've added that to my set of changes to get
sparc64 using 4-level page tables.
