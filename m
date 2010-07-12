From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
 memory management
Date: Mon, 12 Jul 2010 10:25:08 +0900
Message-ID: <20100712102435B.fujita.tomonori@lab.ntt.co.jp>
References: <4C35034B.6040906@codeaurora.org>
	<20100707230710.GA31792@n2100.arm.linux.org.uk>
	<4C366678.60605@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <4C366678.60605@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: zpfeffer@codeaurora.org
Cc: linux@arm.linux.org.uk, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, 08 Jul 2010 16:59:52 -0700
Zach Pfeffer <zpfeffer@codeaurora.org> wrote:

> The problem I'm trying to solve boils down to this: map a set of
> contiguous physical buffers to an aligned IOMMU address. I need to
> allocate the set of physical buffers in a particular way: use 1 MB
> contiguous physical memory, then 64 KB, then 4 KB, etc. and I need to
> align the IOMMU address in a particular way.

Sounds like the DMA API already supports what you want.

You can set segment_boundary_mask in struct device_dma_parameters if
you want to align the IOMMU address. See IOMMU implementations that
support dma_get_seg_boundary() properly.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
