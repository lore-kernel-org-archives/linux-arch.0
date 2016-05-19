From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv6 2/8] dma-debug: add support for resource mappings
Date: Thu, 19 May 2016 12:42:04 +0100
Message-ID: <573DA68C.3060304@arm.com>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160517145002.GD4074@char.us.oracle.com>
 <20160519112122.GN29375@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160519112122.GN29375@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, linux-arch@vger.kernel.org, geert+renesas@glider.be, arnd@arndb.de, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
List-Id: linux-arch.vger.kernel.org

On 19/05/16 12:21, Niklas S=F6derlund wrote:
> Hi Konrad,
>
> Thanks for your feedback.
>
> On 2016-05-17 10:50:02 -0400, Konrad Rzeszutek Wilk wrote:
>>> +void debug_dma_map_resource(struct device *dev, phys_addr_t addr, =
size_t size,
>>> +			    int direction, dma_addr_t dma_addr)
>>> +{
>>> +	struct dma_debug_entry *entry;
>>> +
>>> +	if (unlikely(dma_debug_disabled()))
>>> +		return;
>>> +
>>> +	entry =3D dma_entry_alloc();
>>> +	if (!entry)
>>> +		return;
>>> +
>>> +	entry->type		=3D dma_debug_resource;
>>> +	entry->dev		=3D dev;
>>> +	entry->pfn		=3D __phys_to_pfn(addr);
>>> +	entry->offset		=3D addr - PHYS_PFN(entry->pfn);
>>
>> Is that right?
>
> You are correct that should be:
>
>     entry->offset =3D addr - PFN_PHYS(entry->pfn);
>
> Or even better:
>
>     entry->offset =3D addr - __pfn_to_phys(entry->pfn);

Better still, simply offset_in_page(addr) (as per dma_map_single()).

Robin.

> I will address this and resend late next week, still hoping for some
> more feedback.
>
>>
>> __phys_to_pfn(addr) is PHYS_PFN(addr), so what you get here is
>>
>> addr - PHYS_PFN(PHYS_PFN(addr)) ?
>>
>>
>>> +	entry->size		=3D size;
>>> +	entry->dev_addr		=3D dma_addr;
>>> +	entry->direction	=3D direction;
>>> +	entry->map_err_type	=3D MAP_ERR_NOT_CHECKED;
>>> +
>>> +	add_dma_entry(entry);
>>> +}
>>> +EXPORT_SYMBOL(debug_dma_map_resource);
>>> +
>
