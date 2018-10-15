Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56988 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbeLVSFh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Dec 2018 13:05:37 -0500
Message-ID: <a99ff76069ab6559a5664382a9079b5fddfee945.camel@kernel.crashing.org>
Subject: Re: [PATCH 16/33] powerpc/powernv: remove dead npu-dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Oct 2018 13:45:26 +1100
In-Reply-To: <7709932d-efb8-2c9b-5128-99cc491c302b@ozlabs.ru>
References: <20181009132500.17643-1-hch@lst.de>
         <20181009132500.17643-17-hch@lst.de>
         <7709932d-efb8-2c9b-5128-99cc491c302b@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181015024526.9ww3Qm7qHvgxJO4MRbRiU3FAltKQy5m-YKH7SfgmOJY@z>

On Mon, 2018-10-15 at 12:34 +1100, Alexey Kardashevskiy wrote:
> On 10/10/2018 00:24, Christoph Hellwig wrote:
> > This code has been unused since it was merged and is in the way of
> > cleaning up the DMA code, thus remove it.
> > 
> > This effectively reverts commit 5d2aa710 ("powerpc/powernv: Add support
> > for Nvlink NPUs").
> 
> 
> This code is heavily used by the NVIDIA GPU driver.

Some of it is, yes. And while I don't want to be involved in the
discussion about that specific can of worms, there is code in this file
related to the custom "always error" DMA ops that I suppose we could
remove, which is what is getting in the way of Christoph cleanups. It's
just meant as a debug stuff to catch incorrect attempts at doing the
dma mappings on the wrong "side" of the GPU.

Cheers,
Ben.
