Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:26004 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262503AbUCWLqX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 06:46:23 -0500
Date: Tue, 23 Mar 2004 03:44:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323114452.GE2045@holomorphy.com>
References: <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323113534.GD22639@dualathlon.random>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 06:07:56PM -0800, William Lee Irwin III wrote:
>> More generality in fault handling would be useful in various ways even
>> beyond fixing ALSA's issues. I'm not sure why Linus doesn't like the
>> notion. I didn't insist on API but just moved on to trying to push for

On Tue, Mar 23, 2004 at 12:35:34PM +0100, Andrea Arcangeli wrote:
> my guess is that he doesn't like a branch in the fast path and he thinks
> remap_file_pages approch is simpler for drivers to use.

Hmm. It should move preexisting method calls further up the call chain.
I can't say I have a pressing enough need to pursue it personally
unless it's the way to resolve issues like the one under discussion and
so on. It looks like there's another way that's preferred, so I'm not
looking into it anymore.


On Tue, Mar 23, 2004 at 12:35:34PM +0100, Andrea Arcangeli wrote:
> as for the initial page fault mentioned by Benjamin, that's a non issue,
> if one prefers to preallocate all the ptes thank to take a page fault
> the very first time the pages are touched, I already said some email ago
> that one can call mlock on the mapping and there will be not a single
> page fault anymore afterwards.

mlock actually loops through the fault path, so in a sense it still
requires fault handling on the part of the driver, though AFAICT it can
largely be done by library code. I agree it should be an implementation
detail of dma_mmap_coherent() etc. and pretty much up-front believed
drivers would need code to assist them with fault handling if the did
it, though it didn't originally occur to me that an mmap() function
could install the entire handler on their behalf transparently to them.


-- wli
