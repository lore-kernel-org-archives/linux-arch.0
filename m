Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:46222 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261707AbUCVEqY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Mar 2004 23:46:24 -0500
Date: Sun, 21 Mar 2004 20:46:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322044615.GC2045@holomorphy.com>
References: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079930497.2045.69.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 21, 2004 at 11:41:35PM -0500, James Bottomley wrote:
> Hang on a minute, what makes you think it's legal in any way shape or
> form to construct a user mapping for a coherent area?
> Such an entity, if it were made, wouldn't follow the rules for normal
> mmaps.

Okay, this is bad news for sound (and possibly some graphics) drivers
on PA-RISC, since this mapping of coherent areas into userspace is
exactly what they're trying to do for the device interfaces they
export to the user.

Are you seeing breakage there, or are the drivers doing this
unused on PA-RISC?


-- wli
