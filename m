Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34683 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbeKWRkR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Nov 2018 12:40:17 -0500
Date: Fri, 23 Nov 2018 07:57:20 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181123065720.GB17856@lst.de>
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com> <20181122170715.GI30658@n2100.armlinux.org.uk> <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com> <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com> <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com> <20181122180526.GL30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122180526.GL30658@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, robin.murphy@arm.com, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, joro@8bytes.org, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org, xen-devel@lists.xenproject.org, jdmason@kudzu.us, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Message-ID: <20181123065720.6FGWAuZ2Ehl7tKCn1s_n-ZR7xCGGPGPfGCaCvuozK-w@z>

On Thu, Nov 22, 2018 at 06:05:26PM +0000, Russell King - ARM Linux wrote:
> An alternative idea would be to migrate away from the
> dma_map_single() and dma_map_page() interfaces that return a
> dma_addr_t, and instead have them return an error code or zero
> on success.

See here for a proposal:

https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030912.html

That is just the attr variants, but that would be a start.  Dave didn't
particularly like it, though.

> note the simpler unmap API, which inherently guarantees that the
> parameters to the map could be carried over to the unmap - without
> our many driver authors having to think about it.

The problem is that we can often derive some or all parameters from
field already inherent in the upper layer or hardware interface.  So
for these cases your version would bloat the required data structures.
