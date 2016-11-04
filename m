From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH v2] arc: Implement arch-specific dma_map_ops.mmap
Date: Fri, 4 Nov 2016 05:33:54 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE646785A13C@DE02WEMBXB.internal.synopsys.com>
References: <1478185573-12871-1-git-send-email-abrodkin@synopsys.com>
 <5fcface9-1402-85b7-2caa-624d650d311e@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:40532 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbcKDFfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2016 01:35:19 -0400
In-Reply-To: <5fcface9-1402-85b7-2caa-624d650d311e@synopsys.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Vineet,

> -----Original Message-----
> From: Vineet Gupta [mailto:vgupta@synopsys.com]
> Sent: Thursday, November 03, 2016 8:04 PM
> To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>; linux-snps-arc@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org; Vineet Gupta <Vineet.Gupta1@synopsys.com>; Marek Szyprowski
> <m.szyprowski@samsung.com>; stable@vger.kernel.org
> Subject: Re: [PATCH v2] arc: Implement arch-specific dma_map_ops.mmap
> 
> On 11/03/2016 08:06 AM, Alexey Brodkin wrote:
> > We used to use generic implementation of dma_map_ops.mmap which is
> > dma_common_mmap() but that only worked for simpler cached mappings when
> > vaddr = paddr.
> >
> > If a driver requests uncached DMA buffer kernel maps it to virtual
> > address so that MMU gets involved and page uncached status takes into
> > account. In that case usage of dma_common_mmap() lead to mapping of
> > vaddr to vaddr for user-space which is obviously wrong. For more detals
> > please refer to verbose explanation here [1].
> >
> > So here we implement our own version of mmap() which always deals
> > with dma_addr and maps underlying memory to user-space properly
> > (note that DMA buffer mapped to user-space is always uncached
> > because there's no way to properly manage cache from user-space).
> >
> > [1] https://lkml.org/lkml/2016/10/26/973
> >
> > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> > Cc: <stable@vger.kernel.org>
> 
> I've added a stable 4.5+, since ARC didn't use dma ops until 4.5-rc1.

Again I was hitting a strange problem when sending patch via "git send-email" to
address "<stable@vger.kernel.org> # 3.3.x". Mail server complains on wrong email.
Thus I settled to just mention stable@vger.kernel.org.

Anyways, thanks for doing that!

-Alexey
