Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHUDov (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 23:44:51 -0400
MIME-Version: 1.0
References: <1566304469-5601-1-git-send-email-guoren@kernel.org> <20190821021650.GA32710@infradead.org>
In-Reply-To: <20190821021650.GA32710@infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 21 Aug 2019 11:44:37 +0800
Message-ID: <CAJF2gTR196j8BPwZZLC3f--oKWnPYZFuY78efNgnRyhzrQR4Yw@mail.gmail.com>
Subject: Re: [PATCH 1/3] csky: Fixup arch_get_unmapped_area() implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190821034437.o-rH2D3CUbVS0FD8od3qjroT1D93idQdIseoDpmeO4M@z>

Thx Christoph,

On Wed, Aug 21, 2019 at 10:16 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +/*
> > + * We need to ensure that shared mappings are correctly aligned to
> > + * avoid aliasing issues with VIPT caches.  We need to ensure that
> > + * a specific page of an object is always mapped at a multiple of
> > + * SHMLBA bytes.
> > + *
> > + * We unconditionally provide this function for all cases.
> > + */
>
> On something unrelated: If csky has virtually indexed caches you also
> need to implement the flush_kernel_vmap_range and
> invalidate_kernel_vmap_range functions to avoid data corruption when
> doing I/O on vmalloc/vmap ranges.

I'll give another patch for this issue

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
