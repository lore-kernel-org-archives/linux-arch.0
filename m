Return-Path: <andrea@suse.de>
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9126
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262496AbUCWLeo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 06:34:44 -0500
Date: Tue, 23 Mar 2004 12:35:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323113534.GD22639@dualathlon.random>
References: <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323020756.GS2045@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 06:07:56PM -0800, William Lee Irwin III wrote:
> On Mon, Mar 22, 2004 at 05:18:30PM -0500, Jeff Garzik wrote:
> >> This is burned into silicon, so supporting it's not an option. Frankly
> >> I think what's best is another device interface for userspace to fall
> >> back to when this coherent userspace mmap() is unimplementable, e.g.
> >> read()/write() on some device node.
> 
> On Tue, Mar 23, 2004 at 10:57:19AM +1100, Benjamin Herrenschmidt wrote:
> > Exactly. We can implement the simple/nice interface discussed here, and
> > just not support it on those platforms, they'll have to fall back to
> > read/write or simply not support those drivers who require that
> > functionality.
> > Eventually a nopage variant may be worth for things doing really
> > large mappings, but I tend to think that when we need to do that mapping
> > to userland, it is because we need short latencies, which is the opposite
> > of what a nopage implementation provides, dunno if it's worth the pain
> > (though it's not _that_ painful).
> 
> More generality in fault handling would be useful in various ways even
> beyond fixing ALSA's issues. I'm not sure why Linus doesn't like the
> notion. I didn't insist on API but just moved on to trying to push for

my guess is that he doesn't like a branch in the fast path and he thinks
remap_file_pages approch is simpler for drivers to use.

as for the initial page fault mentioned by Benjamin, that's a non issue,
if one prefers to preallocate all the ptes thank to take a page fault
the very first time the pages are touched, I already said some email ago
that one can call mlock on the mapping and there will be not a single
page fault anymore afterwards.
