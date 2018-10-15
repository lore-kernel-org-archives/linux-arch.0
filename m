From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 16/33] powerpc/powernv: remove dead npu-dma code
Date: Mon, 15 Oct 2018 07:50:08 +0200
Message-ID: <20181015055008.GA23344@lst.de>
References: <20181009132500.17643-1-hch@lst.de> <20181009132500.17643-17-hch@lst.de> <7709932d-efb8-2c9b-5128-99cc491c302b@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7709932d-efb8-2c9b-5128-99cc491c302b@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 15, 2018 at 12:34:02PM +1100, Alexey Kardashevskiy wrote:
> 
> On 10/10/2018 00:24, Christoph Hellwig wrote:
> > This code has been unused since it was merged and is in the way of
> > cleaning up the DMA code, thus remove it.
> > 
> > This effectively reverts commit 5d2aa710 ("powerpc/powernv: Add support
> > for Nvlink NPUs").
> 
> 
> This code is heavily used by the NVIDIA GPU driver.

Not by the that actually exists in the kernel tree, so it simply doesn't
matter.
