Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbeI1Wp5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 18:45:57 -0400
Date: Fri, 28 Sep 2018 09:21:16 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 20/33] csky/dma: fix up dma_mapping error
Message-ID: <20180928162116.GF19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180928162116.xjNjtUa5667RwyNU9vtnLwMgyr7Hyhu6ND7_vGIRPeI@z>

On Fri, Sep 28, 2018 at 08:51:17AM +0800, Guo Ren wrote:
> The arch_sync_dma_for_cpu()/arch_sync_dma_for_device() implementation is
> broken for some combinations that end up in a BUG() instead of performing
> the necessary flushes.

This should be folded into the original patch adding this code.
