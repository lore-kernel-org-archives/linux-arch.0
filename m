From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Mon, 25 Apr 2016 12:10:04 -0700
Message-ID: <20160425191004.GA13906@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org>
 <3286525.zPAGiD4Xk2@avalon>
 <20160321152601.GA11674@infradead.org>
 <20160413132916.GC19650@bigcity.dyn.berto.se>
 <20160421134942.GA3325@infradead.org>
 <20160425142619.GJ28777@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160425142619.GJ28777@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 25, 2016 at 04:26:19PM +0200, Niklas S?derlund wrote:
> I have followed the call path from the usage in 
> drivers/dma/sh/rcar-dmac.c and made sure the dma_addr_t is not used in a 
> bad way.

The dma-debug routines are called from the generic code in
include/linux/dma-mapping.h, and from my reading of the other patches
in your series you are calling it for these as well.
