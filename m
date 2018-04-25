Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35008 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDYGjW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Apr 2018 02:39:22 -0400
Date: Wed, 25 Apr 2018 08:40:55 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-ID: <20180425064055.GA11460@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de> <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com> <20180424191640.GA32495@lst.de> <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180425064055.rw7dbVtbj7SYUsJCM20okbyswMsAf-R2ptchIPkrN0E@z>

On Wed, Apr 25, 2018 at 09:43:43AM +0800, Greentime Hu wrote:
> Hi Crhistoph,
> 
> The ftmac100 works if I revert this commit.

Thanks.  ftmac100 only use dma_map_page, which in the old nds32 code
is just doing a plain page_address and never kmaps.  Can you apply
the patch below on the tree with the origin "nds32: use generic
dma_noncoherent_ops" reverted?  This always just uses page_address,
although that, just like the original code is broken if you actually
have highmem that needs to be mapped:

---
