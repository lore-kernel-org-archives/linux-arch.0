Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:59343 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261706AbUCVE4s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Mar 2004 23:56:48 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040322044615.GC2045@holomorphy.com>
References: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
	<20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
	<20040321225117.F26708@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	<20040321234515.G26708@flint.arm.linux.org.uk>
	<20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
	<20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
	<20040322044615.GC2045@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 21 Mar 2004 23:56:40 -0500
Message-Id: <1079931403.5345.74.camel@mulgrave>
Mime-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2004-03-21 at 23:46, William Lee Irwin III wrote:
> Okay, this is bad news for sound (and possibly some graphics) drivers
> on PA-RISC, since this mapping of coherent areas into userspace is
> exactly what they're trying to do for the device interfaces they
> export to the user.
> 
> Are you seeing breakage there, or are the drivers doing this
> unused on PA-RISC?

Well, our older sound drivers have never worked since ALSA (they hang
off the GSC bus which ALSA doesn't have an abstraction for).  Mostly we
use serial console, and a HP specific thing called a STI framebuffer for
video.

The problems I describe only occur if you try to mmap coherent memory. 
mmaping streaming memory is fine.

But, I would expect that any arch with a virtually indexed cache would
have similar problems: there may be many address aliases in the cache
and the DMA controller probably only knows about one of them.

James
