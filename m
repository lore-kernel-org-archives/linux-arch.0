Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:41106 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261919AbUCWCIc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 21:08:32 -0500
Date: Mon, 22 Mar 2004 18:07:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323020756.GS2045@holomorphy.com>
References: <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079999839.23205.40.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 05:18:30PM -0500, Jeff Garzik wrote:
>> This is burned into silicon, so supporting it's not an option. Frankly
>> I think what's best is another device interface for userspace to fall
>> back to when this coherent userspace mmap() is unimplementable, e.g.
>> read()/write() on some device node.

On Tue, Mar 23, 2004 at 10:57:19AM +1100, Benjamin Herrenschmidt wrote:
> Exactly. We can implement the simple/nice interface discussed here, and
> just not support it on those platforms, they'll have to fall back to
> read/write or simply not support those drivers who require that
> functionality.
> Eventually a nopage variant may be worth for things doing really
> large mappings, but I tend to think that when we need to do that mapping
> to userland, it is because we need short latencies, which is the opposite
> of what a nopage implementation provides, dunno if it's worth the pain
> (though it's not _that_ painful).

More generality in fault handling would be useful in various ways even
beyond fixing ALSA's issues. I'm not sure why Linus doesn't like the
notion. I didn't insist on API but just moved on to trying to push for
a solution to the driver issues to get merged at all so I can get on
with cleaning up drivers using whatever API people want for the solution.

I've already been over every ->nopage() in the kernel once (wrt. what's
been merged anyway; a number of times for other reasons), so I really
think I can do a bit of useful footwork here.


-- wli
