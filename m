Return-Path: <SRS0+795646a07cdf4589e1be+212+infradead.org+dwmw2@baythorne-002242.srs.infradead.org>
Received: from imladris.demon.co.uk ([193.237.130.41]:58778 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261708AbUCWAXH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 19:23:07 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1079999839.23205.40.camel@gaston>
References: <20040322002349.GZ2045@holomorphy.com>
	 <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com>
	 <1079930497.2045.69.camel@mulgrave>
	 <20040322093029.A460@flint.arm.linux.org.uk>
	 <1079967870.1759.12.camel@mulgrave>
	 <20040322151533.C11212@flint.arm.linux.org.uk>
	 <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
	 <405F6636.2090609@pobox.com>  <20040322223509.GO2045@holomorphy.com>
	 <1079999839.23205.40.camel@gaston>
Content-Type: text/plain
Message-Id: <1080001361.16786.40.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 00:22:41 +0000
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-03-23 at 10:57 +1100, Benjamin Herrenschmidt wrote:
> Eventually a nopage variant may be worth for things doing really
> large mappings, but I tend to think that when we need to do that mapping
> to userland, it is because we need short latencies, which is the opposite
> of what a nopage implementation provides, dunno if it's worth the pain
> (though it's not _that_ painful).

Ideally the nopage variant is an implementation detail which the driver
doesn't care about. Latency only counts on the first time each 'page' is
touched, so shouldn't be too much of a problem in general, even for
sound buffers?

-- 
dwmw2
