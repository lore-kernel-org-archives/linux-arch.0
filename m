From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Date: Thu, 26 Jul 2018 11:11:55 +0200
Message-ID: <20180726091155.GA24209@lst.de>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
List-Id: linux-arch.vger.kernel.org

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
