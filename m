Return-Path: <SRS0=F7pE=5Y=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH 28/28] s390: use __vmalloc_node in stack_alloc
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-29-hch@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 8 Apr 2020 15:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200408115926.1467567-29-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <6689b12a-4473-af2e-0fa0-69097eb2bb52@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200408134428.bCzQhlcuTmZLJ-7bciuIsD8wNzCCzZJGdZT9CSmdeXI@z>



On 08.04.20 13:59, Christoph Hellwig wrote:
> stack_alloc can use a slightly higher level vmalloc function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/kernel/setup.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 36445dd40fdb..0f0b140b5558 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -305,12 +305,9 @@ void *restart_stack __section(.data);
>  unsigned long stack_alloc(void)
>  {
>  #ifdef CONFIG_VMAP_STACK
> -	return (unsigned long)
> -		__vmalloc_node_range(THREAD_SIZE, THREAD_SIZE,
> -				     VMALLOC_START, VMALLOC_END,
> -				     THREADINFO_GFP,
> -				     PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				     __builtin_return_address(0));
> +	return (unsigned long)__vmalloc_node(THREAD_SIZE, THREAD_SIZE,
> +			THREADINFO_GFP, NUMA_NO_NODE,
> +			__builtin_return_address(0));

Looks sane.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


>  #else
>  	return __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
>  #endif
> 
