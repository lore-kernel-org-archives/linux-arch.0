Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfHUCQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Aug 2019 22:16:54 -0400
Date: Tue, 20 Aug 2019 19:16:50 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] csky: Fixup arch_get_unmapped_area() implementation
Message-ID: <20190821021650.GA32710@infradead.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566304469-5601-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190821021650.EZU97HeIrz7W1kQ7oiADz6whTkKVcLEWDUg4uhXKeK4@z>

> +/*
> + * We need to ensure that shared mappings are correctly aligned to
> + * avoid aliasing issues with VIPT caches.  We need to ensure that
> + * a specific page of an object is always mapped at a multiple of
> + * SHMLBA bytes.
> + *
> + * We unconditionally provide this function for all cases.
> + */

On something unrelated: If csky has virtually indexed caches you also
need to implement the flush_kernel_vmap_range and
invalidate_kernel_vmap_range functions to avoid data corruption when
doing I/O on vmalloc/vmap ranges.
