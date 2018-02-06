Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38207 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeBFPQs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Feb 2018 10:16:48 -0500
MIME-Version: 1.0
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 16:16:47 +0100
Message-ID: <CAK8P3a2rW8-3QNnKyw9tBenYfd+AWXT2KH16N+g=+eLzHLd2WA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, linux-usb@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
Message-ID: <20180206151647.6qo3yMbzqeIUFYEEut8aXKba4YbAOY7Jd_YzdeblUYY@z>

On Tue, Feb 6, 2018 at 11:14 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>         Hi all,
>
> If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
> symbol bad_dma_ops, thus causing a link failure if it is ever used.
>
> The intention of this is twofold:
>   1. To catch users of the DMA API on systems that do no support the DMA
>      mapping API,
>   2. To avoid building drivers that cannot work on such systems anyway.
>
> However, the disadvantage is that we have to keep on adding dependencies
> on HAS_DMA all over the place.
>
> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
> already covering intention #2.  Having to add an explicit dependency on
> HAS_DMA here is cumbersome, and hinders compile-testing.
>
> Hence I think the time is ripe to reconsider the link failure.
> This patch series:
>   - Changes get_dma_ops() to return NULL instead,
>   - Adds a few more dummies to enable compile-testing,
>   - Removes dependencies on HAS_DMA for symbols that already have
>     platform dependencies implying HAS_DMA.
>
> Note that adding more platform dependencies and/or dependencies on
> COMPILE_TEST is encouraged!
>
> This may make life harder for UML, though, as UML usually satisfies all
> other platform dependencies for HAS_DMA.  Similarly, HAS_IOMEM is even
> more complicated.  Can/do we want to do something similar for
> HAS_IOMEM?
>
> This series is against my current local tree, which has a few more
> "depends on HAS_DMA" than upstream.  Of course I will rebase, and split
> the last patch per subsystem, if this RFC is welcomed positively.
>
> Compile-tested with allmodconfig and allyesconfig for m68k/sun3.

David Woodhouse has been looking at some other structures with indirect
pointers (kvm_x86_ops) to reduce the overhead that was added for
avoiding speculative execution of those pointers. I wonder if there are
any dma_map_ops operations that are in a fastpath that needs a similar
optimization. If yes, we might want to think about how to do that part
first to avoid rewriting the same code more than once.

Otherwise, your approach seems fine.

       Arnd
