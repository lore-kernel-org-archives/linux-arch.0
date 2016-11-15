From: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Subject: Re: [PATCH v2] arc: Implement arch-specific dma_map_ops.mmap
Date: Tue, 15 Nov 2016 15:45:35 +0000
Message-ID: <a5cd26c2-519e-c541-8044-b24685df8f35@synopsys.com>
References: <1478185573-12871-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51302 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935544AbcKOPqT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2016 10:46:19 -0500
In-Reply-To: <1478185573-12871-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On 11/3/2016 3:06 PM, Alexey Brodkin wrote:
> We used to use generic implementation of dma_map_ops.mmap which is
> dma_common_mmap() but that only worked for simpler cached mappings when
> vaddr = paddr.
> 
> If a driver requests uncached DMA buffer kernel maps it to virtual
> address so that MMU gets involved and page uncached status takes into
> account. In that case usage of dma_common_mmap() lead to mapping of
> vaddr to vaddr for user-space which is obviously wrong. For more detals
> please refer to verbose explanation here [1].
> 
> So here we implement our own version of mmap() which always deals
> with dma_addr and maps underlying memory to user-space properly
> (note that DMA buffer mapped to user-space is always uncached
> because there's no way to properly manage cache from user-space).
> 
> [1] https://lkml.org/lkml/2016/10/26/973
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: <stable@vger.kernel.org>
> ---

Tested-by: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
