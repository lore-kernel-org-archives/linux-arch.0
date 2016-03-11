From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Fri, 11 Mar 2016 13:46:42 +0000
Message-ID: <56E2CC42.5070406@arm.com>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<20160308073847.GA15520@infradead.org>
	<20160310160522.GB1111@bigcity.dyn.berto.se>
	<CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Dan,

On 11/03/16 06:47, Dan Williams wrote:
> On Thu, Mar 10, 2016 at 8:05 AM, Niklas S??derlund
> <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org> wrote:
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
