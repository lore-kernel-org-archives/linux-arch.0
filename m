From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Fri, 11 Mar 2016 11:49:31 +0530
Message-ID: <20160311061931.GN11154@localhost>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160310160522.GB1111@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 10, 2016 at 05:05:23PM +0100, Niklas S??derlund wrote:
> Hi Christoph,
>=20
> On 2016-03-07 23:38:47 -0800, Christoph Hellwig wrote:
> > Please add some documentation on where/how this should be used.  It=
's
> > not a very obvious interface.
>=20
> Good idea, I have added the following to Documentation/DMA-API.txt an=
d=20
> folded it in to this patch. Do you feel it's adequate and do you know=
=20
> anywhere else I should add documentation?
>=20
> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
> index 45ef3f2..248556a 100644
> --- a/Documentation/DMA-API.txt
> +++ b/Documentation/DMA-API.txt
> @@ -277,14 +277,29 @@ and <size> parameters are provided to do partia=
l page mapping, it is
>  recommended that you never use these unless you really know what the
>  cache width is.
> =20
> +dma_addr_t
> +dma_map_resource(struct device *dev, phys_addr_t phys_addr, size_t s=
ize,
> +                enum dma_data_direction dir, struct dma_attrs *attrs=
)
> +
> +Maps a MMIO region so it can be accessed by the device and returns t=
he
> +DMA address of the memory. API should only be used to map device MMI=
O,
> +mapping of RAM is not permitted.
> +
> +void
> +dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
> +                  enum dma_data_direction dir, struct dma_attrs *att=
rs)

Using function prototypes in documentation may not be a great idea as y=
ou
are explaining the role of this function and not arguments.

> +
> +Unmaps the IOMMU region previously mapped. All the parameters passed=
 in
> +must be identical to those passed in (and returned) by the mapping A=
PI.
> +
>  int
>  dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> =20
> -In some circumstances dma_map_single() and dma_map_page() will fail =
to create
> -a mapping. A driver can check for these errors by testing the return=
ed
> -DMA address with dma_mapping_error(). A non-zero return value means =
the mapping
> -could not be created and the driver should take appropriate action (=
e.g.
> -reduce current DMA mapping usage or delay and try again later).
> +In some circumstances dma_map_single(), dma_map_page() and dma_map_r=
esource()
> +will fail to create a mapping. A driver can check for these errors b=
y testing
> +the returned DMA address with dma_mapping_error(). A non-zero return=
 value
> +means the mapping could not be created and the driver should take ap=
propriate
> +action (e.g.  reduce current DMA mapping usage or delay and try agai=
n later).
>=20
> --=20
> Regards,
> Niklas S=F6derlund

--=20
~Vinod
