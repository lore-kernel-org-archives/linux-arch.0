Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45584 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261503AbUCVXTn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 18:19:43 -0500
Date: Mon, 22 Mar 2004 23:19:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322231933.H11212@flint.arm.linux.org.uk>
References: <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405F6636.2090609@pobox.com>; from jgarzik@pobox.com on Mon, Mar 22, 2004 at 05:18:30PM -0500
Sender: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Bottomley <James.Bottomley@steeleye.com>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 05:18:30PM -0500, Jeff Garzik wrote:
> You need both kernel and userspace...  for audio drivers, mmap(2) is 
> direct to userspace, but read(2) and write(2) must copy_from_user() into 
> the allocated DMA area.

Not actually true in this case - audio drivers are either mmap() only
or read/write only, never both at the same time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
