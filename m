From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv6 2/8] dma-debug: add support for resource mappings
Date: Thu, 19 May 2016 13:21:22 +0200
Message-ID: <20160519112122.GN29375@bigcity.dyn.berto.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160517145002.GD4074@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34781 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbcESLV0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 07:21:26 -0400
Received: by mail-lf0-f49.google.com with SMTP id m64so34655155lfd.1
        for <linux-arch@vger.kernel.org>; Thu, 19 May 2016 04:21:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160517145002.GD4074@char.us.oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, linux-arch@vger.kernel.org, geert+renesas@glider.be, arnd@arndb.de, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com

Hi Konrad,

Thanks for your feedback.

On 2016-05-17 10:50:02 -0400, Konrad Rzeszutek Wilk wrote:
> > +void debug_dma_map_resource(struct device *dev, phys_addr_t addr, =
size_t size,
> > +			    int direction, dma_addr_t dma_addr)
> > +{
> > +	struct dma_debug_entry *entry;
> > +
> > +	if (unlikely(dma_debug_disabled()))
> > +		return;
> > +
> > +	entry =3D dma_entry_alloc();
> > +	if (!entry)
> > +		return;
> > +
> > +	entry->type		=3D dma_debug_resource;
> > +	entry->dev		=3D dev;
> > +	entry->pfn		=3D __phys_to_pfn(addr);
> > +	entry->offset		=3D addr - PHYS_PFN(entry->pfn);
>=20
> Is that right?=20

You are correct that should be:

   entry->offset =3D addr - PFN_PHYS(entry->pfn);

Or even better:

   entry->offset =3D addr - __pfn_to_phys(entry->pfn);

I will address this and resend late next week, still hoping for some=20
more feedback.

>=20
> __phys_to_pfn(addr) is PHYS_PFN(addr), so what you get here is
>=20
> addr - PHYS_PFN(PHYS_PFN(addr)) ?
>=20
>=20
> > +	entry->size		=3D size;
> > +	entry->dev_addr		=3D dma_addr;
> > +	entry->direction	=3D direction;
> > +	entry->map_err_type	=3D MAP_ERR_NOT_CHECKED;
> > +
> > +	add_dma_entry(entry);
> > +}
> > +EXPORT_SYMBOL(debug_dma_map_resource);
> > +

--=20
Regards,
Niklas S=F6derlund
