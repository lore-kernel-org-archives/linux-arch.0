Return-Path: <jgarzik@pobox.com>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53654 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263717AbUCVWSu
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 17:18:50 -0500
Message-ID: <405F6636.2090609@pobox.com>
Date: Mon, 22 Mar 2004 17:18:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <405E1859.5030906@pobox.com>	 <20040321225117.F26708@flint.arm.linux.org.uk>	 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>	 <20040321234515.G26708@flint.arm.linux.org.uk>	 <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>	 <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>	 <20040322093029.A460@flint.arm.linux.org.uk>	 <1079967870.1759.12.camel@mulgrave>	 <20040322151533.C11212@flint.arm.linux.org.uk>	 <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
In-Reply-To: <1079992229.22190.29.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Benjamin Herrenschmidt wrote:
>>I could see a point: since we can only keep one address space coherent,
>>we cannot allow multiple mmappings of the same region.  Thus, processes
>>would be able to hand off the coherent mmap, but wouldn't be allowed
>>simultaneously to map.  the unmap API would be telling the arch that the
>>mapping was free to be remapped.
> 
> 
> You cannot have the mapping coherent in both kernel and user space ? Hrm,
> I'm afraid drivers won't like that. The DRI will definitely be unhappy,
> and while I don't think sound drivers need to tap the buffers from the
> kernel mapping in normal cases, I'm pretty sure things like infiniband
> or myrinet will have a problem too.

You need both kernel and userspace...  for audio drivers, mmap(2) is 
direct to userspace, but read(2) and write(2) must copy_from_user() into 
the allocated DMA area.
