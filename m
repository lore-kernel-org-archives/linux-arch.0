Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35499 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeGZKYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Jul 2018 06:24:06 -0400
Date: Thu, 26 Jul 2018 11:11:55 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Message-ID: <20180726091155.GA24209@lst.de>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Message-ID: <20180726091155.LLO5aBbvIsaEO7pbRKFaQIDBjLhLA3KH2tFxE-d6Mfs@z>

On Tue, Jul 24, 2018 at 05:13:02PM +0300, Eugeniy Paltsev wrote:
> All DMA devices on ARC haven't worked with SW cache control
> since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
> This happens because we don't check direction argument at all in
> new implementation. Fix that.
> 
> Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Looks sensible.  Might be worth explaining that ARC can speculate
into the areas under DMA, which is why this is required.
