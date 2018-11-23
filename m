Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34658 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbeKWRiI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Nov 2018 12:38:08 -0500
Date: Fri, 23 Nov 2018 07:55:11 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181123065511.GA17856@lst.de>
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com> <20181122170715.GI30658@n2100.armlinux.org.uk> <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com> <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com> <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: robin.murphy@arm.com, linux@armlinux.org.uk, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, jdmason@kudzu.us, xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Message-ID: <20181123065511.kKHgiJYCEk2NF28584Tvsjohm5kFTTFvbkq-fT7Fhoo@z>

On Thu, Nov 22, 2018 at 09:55:25AM -0800, Linus Torvalds wrote:
> No, the big immediate benefit of allowing "return -EINVAL" etc is
> simply legibility and error avoidance.

Well, I can tweak the last patch to return -EINVAL from dma_mapping_error
instead of the old 1 is as bool true.  The callers should all be fine,
although I'd have to audit them.  Still wouldn't help with being able to
return different errors.
