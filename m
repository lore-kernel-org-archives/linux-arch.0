Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: (resend) Converting architectures to 4 level page tables
From: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20050126122623.34b40437.davem@davemloft.net>
References: <41F2EB0E.30407@yahoo.com.au>
	 <20050125195043.45fed74b.davem@davemloft.net>
	 <41F78364.6060409@yahoo.com.au>
	 <20050126122623.34b40437.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 10:21:59 +1100
Message-Id: <1106781719.5158.7.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-01-26 at 12:26 -0800, David S. Miller wrote:
> On Wed, 26 Jan 2005 22:47:48 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > So you shouldn't even need that runtime check there I think.
> > The #if was just a small space saving, but you could simply
> > remove that and be done with it I think. Or have I missed
> > something?
> 
> For the architectures where it is a constant "1", keeping
> the check there makes GCC not output any code more than
> a NULL pointer return.  I figured that would be desirable :)

True, and those with a constant something else should get that
runtime if optimized away. However this is still penalising sparc64,
if only by an imperceptible amount!

It looks like the following condition may do the trick, do you think?
Seems to do the right thing in a simple test file, anyway.

#if !defined(PTRS_PER_XXX) || (PTRS_PER_XXX != 1)
