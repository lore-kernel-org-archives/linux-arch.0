Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbfHFGvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 02:51:16 -0400
Date: Mon, 5 Aug 2019 23:51:15 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
Message-ID: <20190806065115.GB2508@infradead.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org>
 <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guo Ren <guoren@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190806065115.mwqMKTiTTMQEmnG-vfh_eeIwEkQk7hd7cnDXzciY4GU@z>

On Tue, Jul 30, 2019 at 03:43:20PM +0200, Arnd Bergmann wrote:
> When syncing 'for_cpu', you should not need to write back, because
> there won't be any dirty cache lines.
> 
> If you have a CPU core that does not do speculative loads, you also don't
> need to invalidate here, because you have already done that in the
> _for_device() case, the only reason to invalidate the CPU cache
> again is if a speculative load created a stale cache line that now
> shadows the data received from the device.

Yes.  And that is one reason why I want to lift a set of common helpers
for both the speculating and non-speculating case to the common code
that just calls arch specific writeback/invalidate/writeback+invalidate
helpers.  It hasn't been a priotity so far, but maybe it becomes one
now.  Especially if I could draft someone else to help with it :)
