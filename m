From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Date: Wed, 10 Jan 2018 17:23:08 +0000
Message-ID: <5b14af5b-e6e9-17c5-d433-f50ccb466f90@arm.com>
References: <20180110080932.14157-1-hch@lst.de>
	<20180110080932.14157-9-hch@lst.de>
	<7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
	<20180110153517.GF17790@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180110153517.GF17790-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 10/01/18 15:35, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 12:16:15PM +0000, Robin Murphy wrote:
>> On 10/01/18 08:09, Christoph Hellwig wrote:
>>> To properly reject too small DMA masks based on the addressability of the
>>> bounce buffer.
>>
>> I reckon this is self-evident enough that it should simply be squashed into
>> the previous patch.
> 
> x86 didn't wire it up before, so I want a clear blaimpoint for this
> change instead of mixing it up.
That almost makes sense, if x86 were using this generic swiotlb_dma_ops 
already. AFAICS it's only ia64, unicore and tile who end up using it, 
and they all had swiotlb_dma_supported hooked up to begin with. Am I 
missing something?

If regressions are going to happen, they'll surely point at whichever 
commit pulls the ops into the relevant arch code - there doesn't seem to 
be a great deal of value in having a piecemeal history of said ops 
*before* that point.

Robin.
