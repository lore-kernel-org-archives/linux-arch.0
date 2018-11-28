Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40316 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeK2FC4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Nov 2018 00:02:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so20025561lfe.7
        for <linux-arch@vger.kernel.org>; Wed, 28 Nov 2018 10:00:27 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x11sm1499606lfd.81.2018.11.28.10.00.23
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:00:23 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id x85-v6so24283266ljb.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Nov 2018 10:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk> <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com> <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com> <20181128174545.GJ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181128174545.GJ30658@n2100.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Nov 2018 10:00:06 -0800
Message-ID: <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, robin.murphy@arm.com, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org, xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20181128180006.rkOlJjU-Xv1-4O7T0HbdStTyFBuUoZK5qGiZ6rAjxZc@z>

On Wed, Nov 28, 2018 at 9:45 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> > I don't think this is a huge deal, but ERR_PTR() has been hugely
> > successful elsewhere. And I'm not hugely convinced about all these
> > "any address can be valid" arguments. How the hell do you generate a
> > random dma address in the last page that isn't even page-aligned?
>
> kmalloc() a 64-byte buffer, dma_map_single() that buffer.

No.

You already cannot do that kmalloc(), exactly because of ERR_PTR().

Not all memory is accessible even to the kernel. If you have memory
that shows up in the last page of phys_addr_t, you just mark it
reserved at boot-time.

Which is what we ALREADY do for these exact reasons. If the DMA
mappings means that you'd need to add one more page to that list of
reserved pages, then so be it.

The whole argument of "every possible piece of memory is DMA'able" is
just wrong.

                Linus
