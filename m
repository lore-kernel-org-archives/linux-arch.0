Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50431 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbcCKNqr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Mar 2016 08:46:47 -0500
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
 <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56E2CC42.5070406@arm.com>
Date: Fri, 11 Mar 2016 13:46:42 +0000
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@infradead.org>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20160311134642.aVoRqN-4aXrimeSSurt8HNQATxijz3MyB61viEC7bAo@z>

Hi Dan,

On 11/03/16 06:47, Dan Williams wrote:
> On Thu, Mar 10, 2016 at 8:05 AM, Niklas S??derlund
> <niklas.soderlund@ragnatech.se> wrote:
>> Hi Christoph,
>>
>> On 2016-03-07 23:38:47 -0800, Christoph Hellwig wrote:
>>> Please add some documentation on where/how this should be used.  It's
>>> not a very obvious interface.
>>
>> Good idea, I have added the following to Documentation/DMA-API.txt and
>> folded it in to this patch. Do you feel it's adequate and do you know
>> anywhere else I should add documentation?
>>
>> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
>> index 45ef3f2..248556a 100644
>> --- a/Documentation/DMA-API.txt
>> +++ b/Documentation/DMA-API.txt
>> @@ -277,14 +277,29 @@ and <size> parameters are provided to do partial page mapping, it is
>>   recommended that you never use these unless you really know what the
>>   cache width is.
>>
>> +dma_addr_t
>> +dma_map_resource(struct device *dev, phys_addr_t phys_addr, size_t size,
>> +                enum dma_data_direction dir, struct dma_attrs *attrs)
>> +
>> +Maps a MMIO region so it can be accessed by the device and returns the
>> +DMA address of the memory. API should only be used to map device MMIO,
>> +mapping of RAM is not permitted.
>> +
>
> I think it is confusing to use the dma_ prefix for this peer-to-peer
> mmio functionality.  dma_addr_t is a device's view of host memory.
> Something like bus_addr_t bus_map_resource().  Doesn't this routine
> also need the source device in addition to the target device?  The
> resource address is from the perspective of the host cpu, it may be a
> different address space in the view of two devices relative to each
> other.

Hmm, the trouble with that is that when the DMA master is behind an 
IOMMU, the address space as seen by the device is dynamic and whatever 
we decide it to be, so there is no distinction between a "DMA" address 
and a "bus" address.

In practice the dmaengine API has clearly worked for however long with 
slave MMIO addresses being a dma_addr_t, and it doesn't look like anyone 
objected to the change to phys_addr_t in -next either. If nothing is 
using bus_addr_t anyway, what's the right thing to do? Looking up 
through higher abstraction layers, we have the likes of struct 
snd_dmaengine_dai_dma_data also expecting the slave address to be a 
dma_addr_t, leading to things like the direct casting in 
bcm2835_i2s_probe() for the non-IOMMU dma != phys != bus case that could 
also be cleaned up with this proposed interface.

Robin.
