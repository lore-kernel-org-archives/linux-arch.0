Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:60049 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263723AbUCVWfj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 17:35:39 -0500
Date: Mon, 22 Mar 2004 14:35:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322223509.GO2045@holomorphy.com>
References: <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405F6636.2090609@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Benjamin Herrenschmidt wrote:
>> You cannot have the mapping coherent in both kernel and user space ? Hrm,
>> I'm afraid drivers won't like that. The DRI will definitely be unhappy,
>> and while I don't think sound drivers need to tap the buffers from the
>> kernel mapping in normal cases, I'm pretty sure things like infiniband
>> or myrinet will have a problem too.

On Mon, Mar 22, 2004 at 05:18:30PM -0500, Jeff Garzik wrote:
> You need both kernel and userspace...  for audio drivers, mmap(2) is 
> direct to userspace, but read(2) and write(2) must copy_from_user() into 
> the allocated DMA area.

This is burned into silicon, so supporting it's not an option. Frankly
I think what's best is another device interface for userspace to fall
back to when this coherent userspace mmap() is unimplementable, e.g.
read()/write() on some device node.


-- wli
