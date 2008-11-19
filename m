From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel (specifically arm in our case)
Date: Wed, 19 Nov 2008 20:43:15 +0000
Message-ID: <20081119204315.GB17209@flint.arm.linux.org.uk>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com> <200811191740.23638.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60008 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYKSUne (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 15:43:34 -0500
Content-Disposition: inline
In-Reply-To: <200811191740.23638.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com

On Wed, Nov 19, 2008 at 05:40:23PM +1100, Nick Piggin wrote:
> It would be interesting to know exactly what problem you are seeing.
> 
> ARM I think is supposed to handle aliasing problems by flushing
> caches at appropriate points. It would be nice to know what's going
> wrong and whether we can cover those holes.

I think there's a problem here: the existing cache handling API is
designed around the MM's manipulation of page tables.  It is generally
not designed to handle aliasing between multiple mappings of the same
page, except with one exception: page cache pages mmap'd into userspace,
which is handled via flush_dcache_page().

O_DIRECT on ARM is probably completely untested for the most part.  It's
not something that is encountered very often, and as such gets zero
testing.  I've certainly never had the tools to be able to test it out,
so even on VIVT it's probably completely buggy.  Bear in mind that most
of my modern platforms use MTD (either cramfs or in the rare case jffs2)
so I'm not sure that I could sensibly even test O_DIRECT - isn't O_DIRECT
for use with proper block devices?

As it's probably clear, I've no clue of the O_DIRECT implementation or
how it's supposed to work.  At a guess, it probably needs a new cache
handling API to be designed, since the existing flush_cache_(range|page)
are basically no-ops on VIPT.  Or maybe we need some way to mark the
userspace pages as being write-through or uncacheable depending on the
features we have available on the processor.  Or something.  Don't know.

So, what is O_DIRECT, and where can I find some information about it?
I don't see anything in Documentation/ describing it.
