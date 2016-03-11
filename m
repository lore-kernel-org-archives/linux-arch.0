From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Thu, 10 Mar 2016 22:47:10 -0800
Message-ID: <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<20160308073847.GA15520@infradead.org>
	<20160310160522.GB1111@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160310160522.GB1111@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Dan J Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 10, 2016 at 8:05 AM, Niklas S??derlund
<niklas.soderlund@ragnatech.se> wrote:
> Hi Christoph,
>
> On 2016-03-07 23:38:47 -0800, Christoph Hellwig wrote:
>> Please add some documentation on where/how this should be used.  It's
>> not a very obvious interface.
>
> Good idea, I have added the following to Documentation/DMA-API.txt and
> folded it in to this patch. Do you feel it's adequate and do you know
> anywhere else I should add documentation?
>
> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
> index 45ef3f2..248556a 100644
> --- a/Documentation/DMA-API.txt
> +++ b/Documentation/DMA-API.txt
> @@ -277,14 +277,29 @@ and <size> parameters are provided to do partial page mapping, it is
>  recommended that you never use these unless you really know what the
>  cache width is.
>
> +dma_addr_t
> +dma_map_resource(struct device *dev, phys_addr_t phys_addr, size_t size,
> +                enum dma_data_direction dir, struct dma_attrs *attrs)
> +
> +Maps a MMIO region so it can be accessed by the device and returns the
> +DMA address of the memory. API should only be used to map device MMIO,
> +mapping of RAM is not permitted.
> +

I think it is confusing to use the dma_ prefix for this peer-to-peer
mmio functionality.  dma_addr_t is a device's view of host memory.
Something like bus_addr_t bus_map_resource().  Doesn't this routine
also need the source device in addition to the target device?  The
resource address is from the perspective of the host cpu, it may be a
different address space in the view of two devices relative to each
other.
