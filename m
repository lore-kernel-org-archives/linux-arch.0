Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38417 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262268AbUC1KSI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 05:18:08 -0500
Date: Sun, 28 Mar 2004 11:17:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040328111753.A2825@flint.arm.linux.org.uk>
References: <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random> <20040323124027.D25134@flint.arm.linux.org.uk> <20040325202543.B16585@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325202543.B16585@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Mar 25, 2004 at 08:25:44PM +0000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>, William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 25, 2004 at 08:25:44PM +0000, Russell King wrote:
> >From what I've gathered, we seem to be happy with the dma_coherent_mmap()
> approach.  Is everyone happy with these prototypes?
> 
> int dma_coherent_mmap(struct device *dev, struct vm_area_struct *vma,
>                       void *cpu_addr, dma_addr_t dma_addr, size_t size);
> 
> and, for the PA-RISC architecture (c/o James Bottomley):
> 
> void dma_coherent_munmap(struct device *dev, struct vm_area_struct *vma,
> 			 void *cpu_addr, dma_addr_t dma_addr, size_t size);

I'm not happy with dma_coherent_munmap() actually - we don't really
know the lifetime of the vma, so drivers should not be tempted into
keeping a reference to it.

Since interest in this subject appears to have dropped to zero (as
can be seen from the numerous (0) responses to my last post) it is
my intention to provide just the dma_mmap_coherent interface and
let PA-RISC people figure out how to handle their architecture.

I'm shortly going to post a couple of patches to support
dma_coherent_mmap() on x86 and ARM on linux-arch.  Could other
architectures follow up with their patches please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
