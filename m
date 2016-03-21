From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Mon, 21 Mar 2016 08:26:01 -0700
Message-ID: <20160321152601.GA11674@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org>
 <3286525.zPAGiD4Xk2@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3286525.zPAGiD4Xk2@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 17, 2016 at 01:33:51PM +0200, Laurent Pinchart wrote:
> The good news is that, given that no code uses this new API at the moment, 
> there isn't much to audit. The patch series implements the resource mapping 
> for arch/arm only, and makes use of it in the rcar-dmac driver only. Would you 
> like anything audited else than the arch/arm dma mapping implementation, the 
> rcar-dmac driver and the code that then deals with the dma addresses (I'm 
> thinking about the IOMMU subsystem and the ipmmu-vmsa driver in particular) ?

Yes, it would be good to do an audit of all the ARM dma_ops as well
as generic code like drivers/base/dma-*.c, lib/dma-debug.c and
include/linux/dma-*.h
