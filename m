From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv6 3/8] dma-mapping: add dma_{map,unmap}_resource
Date: Thu, 19 May 2016 13:29:26 +0200
Message-ID: <20160519112926.GO29375@bigcity.dyn.berto.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160517145445.GE4074@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160517145445.GE4074@char.us.oracle.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, linux-arch@vger.kernel.org, geert+renesas@glider.be, arnd@arndb.de, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
List-Id: linux-arch.vger.kernel.org

Hi Konrad,

Thanks for your feedback.

On 2016-05-17 10:54:45 -0400, Konrad Rzeszutek Wilk wrote:
> > =20
> > -In some circumstances dma_map_single() and dma_map_page() will fai=
l to create
> > -a mapping. A driver can check for these errors by testing the retu=
rned
> > -DMA address with dma_mapping_error(). A non-zero return value mean=
s the mapping
> > -could not be created and the driver should take appropriate action=
 (e.g.
> > -reduce current DMA mapping usage or delay and try again later).
> > +In some circumstances dma_map_single(), dma_map_page() and dma_map=
_resource()
> > +will fail to create a mapping. A driver can check for these errors=
 by testing
> > +the returned DMA address with dma_mapping_error(). A non-zero retu=
rn value
> > +means the mapping could not be created and the driver should take =
appropriate
> > +action (e.g. reduce current DMA mapping usage or delay and try aga=
in later).
>=20
> This looks like it belongs to another patch?

No it is correct (at least intended to be in this patch). All it really=
=20
do is inject dma_map_resource() (which is added in this patch) as one o=
f=20
the calls which return dma_addr_t should be checked for error using=20
dma_mapping_error().  But yes the change effect all lines in the=20
paragraph due to line wrapping.

Hum or maybe I'm misunderstanding your question.

--=20
Regards,
Niklas S=F6derlund
