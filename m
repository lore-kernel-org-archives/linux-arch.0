Return-Path: <jgarzik@pobox.com>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29596 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261619AbUCVXfg
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 18:35:36 -0500
Message-ID: <405F7837.2010800@pobox.com>
Date: Mon, 22 Mar 2004 18:35:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322231933.H11212@flint.arm.linux.org.uk>
In-Reply-To: <20040322231933.H11212@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Bottomley <James.Bottomley@steeleye.com>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Russell King wrote:
> On Mon, Mar 22, 2004 at 05:18:30PM -0500, Jeff Garzik wrote:
> 
>>You need both kernel and userspace...  for audio drivers, mmap(2) is 
>>direct to userspace, but read(2) and write(2) must copy_from_user() into 
>>the allocated DMA area.
> 
> 
> Not actually true in this case - audio drivers are either mmap() only
> or read/write only, never both at the same time.

Agreed, but due to OSS dain bramage you can read/write as much as you 
like, up until the mmap point, AFAICS.  It's much easier for the driver 
to allocate one set of buffers, than to allocate a set at open(2), throw 
away those allocs at mmap(2) and make new ones.

	Jeff
