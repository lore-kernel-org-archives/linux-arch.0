From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] dma: Add barrierless dma mapping/unmapping api
Date: Wed, 27 Jan 2010 17:49:47 +1100
Message-ID: <1264574987.3601.171.camel@pasglop>
References: <1264480210.3601.118.camel@pasglop>
	 <20100126134207T.fujita.tomonori@lab.ntt.co.jp>
	 <4B5F4C76.4050100@codeaurora.org>
	 <20100127141901P.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52985 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab0A0GvK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Jan 2010 01:51:10 -0500
In-Reply-To: <20100127141901P.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: adharmap@codeaurora.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dwalker@codeaurora.org, arnd@arndb.de, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com, maciej.sosnowski@intel.com, dan.j.williams@intel.com, beckyb@kernel.crashing.org, yanghy@cn.fujitsu.com, linux-arch@vger.kernel.org, adharmap@quicinc.com

On Wed, 2010-01-27 at 14:19 +0900, FUJITA Tomonori wrote:
> > I somehow missed your post, my apologies. Agreed that
> dma_map/unmap_sg 
> > would be the correct api to use here, however they still call the 
> > dmac_.*_range to map buffers.
> 
> Hmm, sounds like arm's implementation issue. dma_map_sg API doesn't
> require such. dma_map_sg API gives what you want, do a sync only after
> mapping the last buffer.

dmac_* appears to be ARM's low-level ops for cache flushing on
non-coherent DMA, so it's really down to arch stuff here and how ARM
implements dma_[un]map_sg() and we keep a sane global driver API.

Cheers,
Ben.
