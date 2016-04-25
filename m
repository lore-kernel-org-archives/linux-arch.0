From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niso@kth.se>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Mon, 25 Apr 2016 16:26:19 +0200
Message-ID: <20160425142619.GJ28777@bigcity.dyn.berto.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org>
 <3286525.zPAGiD4Xk2@avalon>
 <20160321152601.GA11674@infradead.org>
 <20160413132916.GC19650@bigcity.dyn.berto.se>
 <20160421134942.GA3325@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160421134942.GA3325@infradead.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

On 2016-04-21 06:49:42 -0700, Christoph Hellwig wrote:
> On Wed, Apr 13, 2016 at 03:29:17PM +0200, Niklas S?derlund wrote:
> > > Yes, it would be good to do an audit of all the ARM dma_ops as we=
ll
> > > as generic code like drivers/base/dma-*.c, lib/dma-debug.c and
> > > include/linux/dma-*.h
>=20
> What about things like the phys_addr() helper in lib/dma-debug.c?  Th=
at
> was in fact what prompted my question for an audit, and it seems
> to not even feature on your list.  What patterns / symbols did you lo=
ok
> for?


I have followed the call path from the usage in=20
drivers/dma/sh/rcar-dmac.c and made sure the dma_addr_t is not used in =
a=20
bad way.

I also looked at the dma-mapping API and ruled out that the only=20
function that make sens to use with a dma_addr_t from dma_map_resource(=
)=20
are dma_unmap_resource() and dma_mapping_error(). With that I can't see=
=20
how a dma_addr_t would end up in lib/dma-debug.c. But I might be missin=
g=20
something?

In the big picture do you feel the approach I have is the correct way t=
o=20
solve my problem? Provided we can work out this issues ofc?

--=20
Regards,
Niklas S=F6derlund
