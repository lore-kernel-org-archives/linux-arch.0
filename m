Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 26 Jan 2005 15:25:33 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: (resend) Converting architectures to 4 level page tables
Message-Id: <20050126152533.63e43c58.davem@davemloft.net>
In-Reply-To: <1106781719.5158.7.camel@npiggin-nld.site>
References: <41F2EB0E.30407@yahoo.com.au>
	<20050125195043.45fed74b.davem@davemloft.net>
	<41F78364.6060409@yahoo.com.au>
	<20050126122623.34b40437.davem@davemloft.net>
	<1106781719.5158.7.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 27 Jan 2005 10:21:59 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> It looks like the following condition may do the trick, do you think?
> Seems to do the right thing in a simple test file, anyway.
> 
> #if !defined(PTRS_PER_XXX) || (PTRS_PER_XXX != 1)

It doesn't work, try the following which matches quite
precisely the sparc64 case.

extern int __get_ptrs_per_pmd(void);

#define PTRS_PER_PMD	__get_ptrs_per_pmd()

int main(void)
{
#if !defined(PTRS_PER_PMD) || (PTRS_PER_PMD != 1)
	return 1;
#endif
	return 0;
}

It will warn like this:

foo.c:7:6: missing binary operator before token "("
foo.c:10:32: missing binary operator before token "("

Which looks exactly like the kind of warnings mm/memory.c was
producing for me on sparc64.

Let's just face it that this is not a compile time test in
any way.  We could make it so by creating some kind of
PTRS_PER_PMD_MIGHT_BE_GREATER_THAN_ONE macro platforms can
define but this is getting really rediculious :-)
