From: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
Date: Thu, 9 Apr 2020 13:46:26 +0200
Message-ID: <d4a82787-5dd2-ccde-79b4-ff44848ba04e@gmx.net>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local>
 <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
Content-Language: de-AT
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>, Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org, Sakari Ailus <sakari.ailus@linux.intel.com>, bpf@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-arch.vger.kernel.org

Am 09.04.20 um 10:54 schrieb Benjamin Herrenschmidt:
> On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
>> On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
>>> If this code was broken for non-coherent caches a crude powerpc hack
>>> isn't going to help anyone else.  Remove the hack as it is the last
>>> user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
>>
>> Well Ben added this to make stuff work on ppc, ofc the home grown dma
>> layer in drm from back then isn't going to work in other places. I guess
>> should have at least an ack from him, in case anyone still cares about
>> this on ppc. Adding Ben to cc.
>
> This was due to some drivers (radeon ?) trying to use vmalloc pages for
> coherent DMA, which means on those 4xx powerpc's need to be non-cached.
>
> There were machines using that (440 based iirc), though I honestly
> can't tell if anybody still uses any of it.
The first-gen amigaone platform (6xx/book32s) uses the radeon driver
together with non-coherent DMA. However this only ever worked reliably
for DRI1.

br,
Gerhard

> Cheers,
> Ben.
>
>> -Daniel
>>
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  drivers/gpu/drm/drm_scatter.c | 11 +----------
>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
>>> index ca520028b2cb..f4e6184d1877 100644
>>> --- a/drivers/gpu/drm/drm_scatter.c
>>> +++ b/drivers/gpu/drm/drm_scatter.c
>>> @@ -43,15 +43,6 @@
>>>
>>>  #define DEBUG_SCATTER 0
>>>
>>> -static inline void *drm_vmalloc_dma(unsigned long size)
>>> -{
>>> -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
>>> -	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
>>> -#else
>>> -	return vmalloc_32(size);
>>> -#endif
>>> -}
>>> -
>>>  static void drm_sg_cleanup(struct drm_sg_mem * entry)
>>>  {
>>>  	struct page *page;
>>> @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
>>>  		return -ENOMEM;
>>>  	}
>>>
>>> -	entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
>>> +	entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
>>>  	if (!entry->virtual) {
>>>  		kfree(entry->busaddr);
>>>  		kfree(entry->pagelist);
>>> --
>>> 2.25.1
>>>
>>
>>
>
